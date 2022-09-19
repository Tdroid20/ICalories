//
//  ContentView.swift
//  ICalories
//
//  Created by user226765 on 9/15/22.
//

import SwiftUI;
import CoreData;

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext;
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order : .reverse)]) var food: FetchedResults<Food>
    
    @State var isAddView: Bool = false;
 
    var body: some View {
        NavigationView {
            VStack {
                HStack {
// --------- Title
                    VStack(alignment: .leading) {
                        VStack {
                            Text("I")
                                .foregroundColor(.blue)
                            + Text("Calories")
                                .foregroundColor(.red)
                            
                        }.frame(width: .maximum(350, y0(30)), alignment: .leading)
                            .fontWeight(.bold)
                            .font(.custom(
                                "GODOFWAR",
                                size: 50))
                            .underline(true, color: .cyan)

                    }
                    
                }
                // -------- Calories
                Text("\(Int(getTotCalories())) Total de calorias")
                    .foregroundColor(.black)
                    .padding()
                    .fontWeight(.bold)
                
                
                List {
                    ForEach(food) {
                        food in NavigationLink(destination: EditFoodView(food: food)) {
                            FoodDetailView(FoodName: food.name!, foodCalories: food.calories, FoodDate: food.date!)
                        }
                    }.onDelete(perform: deleteFood)
                }
                    .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isAddView = true
                        }, label: {
                            Label("Add Food", systemImage: "plus.circle")
                        })
                    }
                }
                .sheet(isPresented: $isAddView) {
                    addFoodView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                
            }
            
        }
    }
    
    func getTotCalories() -> Double {
        var caloriesToday: Double = 0.0;
        for thisFood in food {
            if(Calendar.current.isDateInToday(thisFood.date!)) {
                caloriesToday += thisFood.calories
            }
        }
        return caloriesToday;
    }
    
    func deleteFood(offsets: IndexSet){
            withAnimation {
                offsets.map { food[$0] }
                    .forEach(managedObjectContext.delete)

                DataController().save(context: managedObjectContext)
            }
        }
}

struct FoodDetailView: View {
    
    var FoodName: String = "Food is Not Specified"
    var foodCalories: Double = 0.0;
    var FoodDate: Date = Date()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(FoodName)
                    .bold();
                
                HStack{
                    Text("\(Int(foodCalories)) ") +
                    Text("Kcal").foregroundColor(.red)
                }
                Text("Data da comida: ") + Text(FoodDate.formatted()).foregroundColor(.blue)

            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
