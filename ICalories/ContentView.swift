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
                    Text("I")
                        .foregroundColor(.blue)
                    + Text("Calories")
                        .foregroundColor(.red)
                    
                    }.frame(width: 400, alignment: .leading)
                    .fontWeight(.bold)
                    .font(.custom(
                        "GODOFWAR",
                        size: 50))
                    .underline(true, color: .cyan)
                
// -------- Calories
                Text("\(Int(getTotCalories())) Total de calorias")
                    .foregroundColor(.black)
                    .padding()
                    .fontWeight(.bold)
                
                
                List {
                    ForEach(food) {
                        food in NavigationLink(destination: EditFoodView(food: food)) {
                            VStack {
                                Text(food.name!)
                                         .bold()
                            }
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
                    addFoodView(isAddFoodView: $isAddView)
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
        return 0.0
    }
    
    func deleteFood(offsets: IndexSet){
            withAnimation {
                offsets.map { food[$0] }
                    .forEach(managedObjectContext.delete)

                DataController().save(context: managedObjectContext)
            }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
