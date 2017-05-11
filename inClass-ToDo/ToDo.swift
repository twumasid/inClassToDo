//
//  ToDo.swift
//  inClass-ToDo
//
//  Created by daniel on 23.04.17.
//  Copyright © 2017 daniel. All rights reserved.
//

import UIKit

//struct to contain a toDo item type made up of all todo properties
struct toDoItemType {
    var name = "Todo"
    var desc: String?
    var dateCreated: Date?
    var completed = false
    var image = UIImage()
    var dateDue: Date?
    var location: String?
}

// var ToDo.toDoManager: ToDo = ToDo()

class ToDo: NSObject, NSCoding {
    
    static let toDoManager = ToDo()
    
    //var to contain one toDo Item
    var toDoItem = toDoItemType()
    
    //an array to hold all toDo items in app
    var toDoItems = [toDoItemType]()
    
    //blank initializer
    override init() {
        
    }
    
    //initializer
    init?(name: String, desc: String, dateCreated: Date, completed: Bool, image: UIImage, dateDue: Date, location: String?) {
        ToDo.toDoManager.toDoItem.name = name
        ToDo.toDoManager.toDoItem.desc = desc
        ToDo.toDoManager.toDoItem.dateCreated = dateCreated
        ToDo.toDoManager.toDoItem.completed = completed
        ToDo.toDoManager.toDoItem.image = image
        ToDo.toDoManager.toDoItem.dateDue = dateDue
        ToDo.toDoManager.toDoItem.location = location
    }
    
    func addToDo (name: String, desc: String?, dateCreated: Date?, complete: Bool, image: UIImage, dateDue: Date?, location: String?) {
        ToDo.toDoManager.toDoItems.append(toDoItemType(name: name, desc: desc, dateCreated: dateCreated!, completed: complete, image: image, dateDue: dateDue, location: location))
    }
    
//    func addToDoItem (toDo: toDoItemType) {
//        ToDo.toDoManager.toDoItems.append(toDoItemType(name: toDo.name, desc: toDo.desc, dateCreated: toDo.dateCreated, completed: toDo.completed, image: toDo.image, dateDue: toDo.dateDue, location: toDo.location))
//    }
    
    
//    //saving app data
//    //where to save the Data
      public func saveToDos() {
        
        print("saving")
        
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ToDo.toDoManager.toDoItems, toFile: ToDo.ArchiveURL.path)
            if isSuccessfulSave {
                   print ("saved")
                }
              else {
                  print("DEFCON 5!!! Failed to save Todos.")
                }
        
          }
    
    //get root directory
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //append app location to root directory
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")
    
    
    public func loadTodos() {
        print("loDING")
        ToDo.toDoManager.toDoItems = NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.ArchiveURL.path) as! [toDoItemType]
        
        print(ToDo.toDoManager.toDoItems.count)
    }
    
    
    //a disctionary for saving data
    struct PropertyKey {
        static let name = "name"
        static let desc = "desc"
        static let dateCreated = "dateCreated"
        static let completed = "completed"
        static let image = "image"
        static let dateDue = "dateDue"
        static let location = "location"
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(ToDo.toDoManager.toDoItem.name, forKey: PropertyKey.name)
        aCoder.encode(ToDo.toDoManager.toDoItem.desc, forKey: PropertyKey.desc)
        aCoder.encode(ToDo.toDoManager.toDoItem.dateCreated, forKey: PropertyKey.dateCreated)
        aCoder.encode(ToDo.toDoManager.toDoItem.completed, forKey: PropertyKey.completed)
        aCoder.encode(ToDo.toDoManager.toDoItem.image, forKey: PropertyKey.image)
        aCoder.encode(ToDo.toDoManager.toDoItem.dateDue, forKey: PropertyKey.dateDue)
        aCoder.encode(ToDo.toDoManager.toDoItem.location, forKey: PropertyKey.location)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let desc = aDecoder.decodeObject(forKey: PropertyKey.desc) as! String
        let dateCreated = aDecoder.decodeObject(forKey: PropertyKey.dateCreated) as! Date
        let isCompleted = aDecoder.decodeBool(forKey: PropertyKey.completed)
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as! UIImage
        let dateDue = aDecoder.decodeObject(forKey: PropertyKey.dateDue) as! Date
        let location = aDecoder.decodeObject(forKey: PropertyKey.location) as! String
        
        self.init(name: name, desc: desc, dateCreated: dateCreated,  completed: isCompleted, image: image,dateDue: dateDue, location: location)
    }
    
    

}
