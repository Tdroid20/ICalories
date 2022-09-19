//
//  EditFoodView.swift
//  ICalories
//
//  Created by user226765 on 9/17/22.
//

import SwiftUI;
import CoreData;

struct EditFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element;
    
    @State var name = "";
    @State var calories = 0.0;
    
    var body: some View {
        Form{
            Section() {
                VStack(alignment: .center){
                    TextField("\(food.name!)", text: $name).multilineTextAlignment(.center).padding().onAppear() {
                        name = food.name!;
                        calories = food.calories
                    }
                    .frame(width: 350, height: 40)
                    .foregroundColor(.blue)
                    .textFieldStyle(.roundedBorder);
                    
                    
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 1...3000, step: 10 )
                }.padding()
                
                
                    Button("Submit"){
                        DataController().editFood(foodOld: food, name: self.name, calories: self.calories, context: managedObjContext )
                        dismiss()
                    }
                
                
            }
        }
    }
}
