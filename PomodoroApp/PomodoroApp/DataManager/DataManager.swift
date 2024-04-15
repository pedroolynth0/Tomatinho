//
//  DataManager.swift
//  PomodoroApp
//
//  Created by dti digital on 09/04/24.
//

import Foundation
import Combine


struct DataManager {
    private static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private static let archiveURL = documentsDirectory.appendingPathComponent("timer").appendingPathExtension("plist")
    
    static let recipesDidChange = PassthroughSubject<Void, Never>()
    
    
    
//    static func saveRecipe(_ recipe: Recipe) throws {
//        do {
//            var existingRecipes = try loadRecipes()
//            var tmp = recipe
//            tmp._id = String(existingRecipes.count)
//            existingRecipes.append(tmp)
//            
//            do {
//                let encoder = PropertyListEncoder()
//                let data = try encoder.encode(existingRecipes)
//                try data.write(to: archiveURL, options: .noFileProtection)
//                recipesDidChange.send()
//            } catch {
//                throw RecipeError.saveFailure(reason: "Error saving recipe: \(error)")
//            }
//        } catch {
//            throw RecipeError.deleteFailure(reason: "Error deleting recipe: \(error)")
//        }
//    }
//    
//    static func deleteRecipe(_ recipeID: String) throws {
//        do {
//            var existingRecipes = try loadRecipes()
//            existingRecipes.removeAll { $0._id == recipeID }
//            
//            do {
//                let encoder = PropertyListEncoder()
//                let data = try encoder.encode(existingRecipes)
//                try data.write(to: archiveURL, options: .noFileProtection)
//                recipesDidChange.send()
//            } catch {
//                throw RecipeError.deleteFailure(reason: "Error deleting recipe: \(error)")
//            }
//        } catch {
//            throw RecipeError.loadFailure(reason: "Error deleting recipe: \(error)")
//        }
//    }
//    
//    static func updateRecipe(_ updatedRecipe: Recipe) throws {
//        var existingRecipes = try loadRecipes()
//        
//        if let index = existingRecipes.firstIndex(where: { $0._id == updatedRecipe._id }) {
//            existingRecipes[index] = updatedRecipe
//            
//            do {
//                let encoder = PropertyListEncoder()
//                let data = try encoder.encode(existingRecipes)
//                try data.write(to: archiveURL, options: .noFileProtection)
//                recipesDidChange.send()
//            } catch {
//                throw RecipeError.updateFailure(reason: "Error updating recipe: \(error)")
//            }
//        }
//        else {
//            throw RecipeError.recipeNotFound
//        }
//        
//
//    }
//
//
//    static func loadRecipes() throws -> [Recipe] {
//        do {
//            let data = try Data(contentsOf: archiveURL)
//            let decoder = PropertyListDecoder()
//            return try decoder.decode([Recipe].self, from: data)
//        } catch {
//            print("Error loading recipes: \(error)")
//            return []
//        }
//    }
}
