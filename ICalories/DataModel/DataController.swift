//
//  DataController.swift
//  ICalories
//
//  Created by user226765 on 9/15/22.
//

import Foundation;
import CoreData;

class DataController {
    
    func save(context: NSManagedObjectContext) {
        do {
           try context.save()
        } catch {
            let error = error as NSError;
            print("Ero ao tentar salvar os dados no banco de dados \(error)");
        }

    }
    
    func update() {
        print("Emit update function");
    }
    
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context);
        
        food.id = UUID();
        food.name = name;
        food.date = Date();
        food.calories = calories;
        
        // TODO: Criar função para salvar os dados no contexto
        
    }
    
    func removeFood() {
        
    }
    
    func editFood() {
        
    }
}
