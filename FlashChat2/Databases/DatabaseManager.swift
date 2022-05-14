//
//  DatabaseManager.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import UIKit
import Foundation
import CoreData

class DatabaseManager: UIViewController {
    public static let shared = DatabaseManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveDataToCoreData(user: User) {
        do {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserCoreData", into: self.context) as NSManagedObject
            newUser.setValue(user.email, forKey: "email")
            newUser.setValue(user.name, forKey: "name")
            try self.context.save()
        } catch {
            showErrorAlert()
        }
    }
    
    func getDataFromCoreData() -> User? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCoreData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                let data: NSManagedObject = result[0] as! NSManagedObject //as! [NSManagedObject]
                let email = data.value(forKey: "email") as! String
                let name = data.value(forKey: "name") as! String
                return User(email: email, password: "", name: name)
            }
        } catch {
            showErrorAlert()
        }
        return nil
    }
    
    func removeDataFromCoreData(completion: () -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCoreData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                context.delete(result[0] as! NSManagedObject)
                try? context.save()
            }
            completion()
        } catch {
            showErrorAlert()
        }
    }
}
