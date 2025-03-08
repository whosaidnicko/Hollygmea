//
//  ProfileViewModel.swift
//  Hollygmea
//

import SwiftUI
import PhotosUI
import CoreData

final class ProfileViewModel: ObservableObject {
    
    var savedName: String = ""
    var savedDateOfBirth: Date = Date()
    var savedEnableNotifications: Bool = false
    var savedIcon: UIImage?
    
    @Published var name: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var enableNotifications: Bool = false
    
    @Published var icon: UIImage?
    @Published var pickerItem: PhotosPickerItem?
    
    var hasCanges: Bool {
        let array: [Bool] = [
            name == savedName,
            dateOfBirth == savedDateOfBirth,
            enableNotifications == savedEnableNotifications,
            icon == savedIcon
        ]
        return array.contains(false)
    }
    
    init() {
        fetchUserData()
    }
    
    func saveUserData() {
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(dateOfBirth, forKey: "userDateOfBirth")
        UserDefaults.standard.set(enableNotifications, forKey: "enableNotifications")
        
        if let imageData = icon?.pngData() {
            let base64String = imageData.base64EncodedString()
            savedIcon = icon
            UserDefaults.standard.set(base64String, forKey: "userIcon")
        }
        
        savedName = name
        savedDateOfBirth = dateOfBirth
        savedEnableNotifications = enableNotifications
        
        UserDefaults.standard.synchronize()
    }
    
    func fetchUserData() {
        name = UserDefaults.standard.string(forKey: "userName") ?? ""
        dateOfBirth = UserDefaults.standard.object(forKey: "userDateOfBirth") as? Date ?? Date()
        enableNotifications = UserDefaults.standard.bool(forKey: "enableNotifications")
        
        savedName = name
        savedDateOfBirth = dateOfBirth
        savedEnableNotifications = enableNotifications
        
        if let base64String = UserDefaults.standard.string(forKey: "userIcon"),
           let imageData = Data(base64Encoded: base64String),
           let image = UIImage(data: imageData) {
            savedIcon = image
            icon = image
        }
    }
    
    func clearUserData() {
        UserDefaults.standard.set("", forKey: "userName")
        UserDefaults.standard.set(nil, forKey: "userDateOfBirth")
        UserDefaults.standard.set(false, forKey: "enableNotifications")
        UserDefaults.standard.set(nil, forKey: "userIcon")
        UserDefaults.standard.synchronize()
        
        name = ""
        dateOfBirth = Date()
        enableNotifications = false
        icon = nil
        
        savedName = ""
        savedDateOfBirth = Date()
        savedEnableNotifications = false
        savedIcon = nil
        
        deleteAllData()
    }
    
    private func deleteAllData() {
        let context = DataController.shared.container.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Training")
        
        do {
            let objects = try context.fetch(fetchRequest)
            
            for object in objects {
                if let managedObject = object as? NSManagedObject {
                    context.delete(managedObject)
                }
            }
            
            try context.save()
        } catch {
            print("Error deleting all data: \(error)")
        }
    }
}
extension View {
    func adaptdievas() -> some View {
        self.modifier(Chikubom())
    }
}
