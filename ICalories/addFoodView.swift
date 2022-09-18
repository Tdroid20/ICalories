//
//  addFoodView.swift
//  ICalories
//
//  Created by user226765 on 9/16/22.
//

import SwiftUI;


struct addFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext;
    
    @Binding var isAddFoodView: Bool;
    @State var name : String = "";
    @State var calories : Double = 0.0;
    @State var isNameNull: Bool = false;
    @State var isCalorriesNull: Bool = false
    
    var body: some View {
        
        Form{
            Section {
                VStack{
                    TextField("Food Name", text: $name)
                        .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                    .frame(width: 360, height: 30, alignment: .center)
                    .textFieldStyle(.roundedBorder)
                
                    VStack {
                        Text("Calories: \(Int(calories))")
                        Slider(value: $calories, in: 1...3000, step: 10 )
                    }.padding()
                    
                }.padding()
                
                HStack{
                    Button("Submit") {
                        if(name == "") {
                            isNameNull = true;
                        } else if(calories == 0.0) {
                            isCalorriesNull = true;
                        } else {
                            DataController().addFood(name: name, calories: calories, context: managedObjectContext)
                            isAddFoodView = false
                        }
                        
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .frame(width: 100, height: 30)
                        
                }
                .padding()
                .frame(width: 500)
            }
        }
        .alert("❗┃Alert", isPresented: $isNameNull, actions: {
            Button("Ok", role: .cancel) {
                isNameNull = false;
            }
        }, message: {
            Text("Você não pode registrar uma comida sem definir um nome")
        })
        
        .alert("❗┃Alert", isPresented: $isNameNull, actions: {
            Button("Ok", role: .cancel) {
                isNameNull = false;
            }
        }, message: {
            Text("Você não pode registrar uma comida sem definir um valor para caloria")
        })

        
    }
}
