//
//  DataController.swift
//  ICalories
//
//  Created by user226765 on 9/15/22.
//

import Foundation;
import CoreData;

class DataController : ObservableObject {
  
  let container = NSPersistentContainer(name: "FoodModel");
  
  init() {
    
    container.loadPersistentStores{
      descripiton, error in if let error = error {
        print("Error ao carregar os dados \(error)")
      }
    }
  }
    
    func save(context: NSManagedObjectContext) {
        do {
          try context.save();
        } catch {
            let error = error as NSError;
            print("Ero ao tentar salvar os dados no banco de dados \(error)");
        }

    }
        
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context);
        
        food.id = UUID();
        food.name = name;
        food.date = Date();
        food.calories = calories;
        
      save(context: context);
        
    }
    
  func editFood(foodOld: Food, name: String, calories: Double, context: NSManagedObjectContext) {
    foodOld.name = name;
    foodOld.date = Date();
    foodOld.calories = calories;
    
    save(context: context);

    }
}
