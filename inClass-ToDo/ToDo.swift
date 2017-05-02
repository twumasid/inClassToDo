//
//  ToDo.swift
//  inClass-ToDo
//
//  Created by daniel on 23.04.17.
//  Copyright © 2017 daniel. All rights reserved.
//

import UIKit


struct toDoItemType {
    var name : String!
    var desc : String!
    var date : String!
    var completed = false
    var image = UIImage()
}

class ToDo: NSObject, NSCoding {
//class ToDo: NSObject{

    var toDoItem = toDoItemType()
    var toDoItems = [toDoItemType]()
    
    init?(name: String, desc: String, date: String, image: UIImage, completed: Bool) {
        self.toDoItem.name = name
        self.toDoItem.desc = desc
        self.toDoItem.date = date
        self.toDoItem.completed = completed
        self.toDoItem.image = image
    }
    
    func addToDo (name: String, desc: String, date: String, complete: Bool, image: UIImage) {
        toDoItems.append(toDoItemType(name: name, desc: desc, date: date, completed: complete, image: image))
    }
    
    func addToDoItem (toDo: toDoItemType) {
        toDoItems.append(toDoItemType(name: toDo.name, desc: toDo.desc, date: toDo.date, completed: toDo.completed, image: toDo.image))
    }
    
    
    //saving app data
    //where to save the Data
    
    //get root directory
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //append app location to root directory
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")
    
    private func saveToDos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ToDo, toFile: ToDo.ArchiveURL.path)
        
        if isSuccessfulSave {
            print ("saved")
        }
        else {
            print("DEFCON 5!!! Failed to save Todos.")
        }
        
    }
    
    private func loadTodos() {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchilveURL.path) as! [Todo]
    }
    
    
    
    struct PropertyKey {
        static let name = "toDo Name"
        static let desc = "toDo Description"
        static let date = "01-01-01"
        static let completed = "completed"
        static let image = "image"
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(desc, forkey: PropertyKey.desc)
        aCoder.encode(date, forkey: PropertyKey.date)
        aCoder.encode(completed, forKey: PropertyKey.completed)
        aCoder.encode(image, forKey: PropertyKey.image)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let desc = aDecoder.decodeObject(forKey: PropertyKey.desc) as! String
        let date = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let completed = aDecoder.decodeBool(forKey: PropertyKey.completed)
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as! UIImage
        
        self.init(name: name, desc: desc, date: date, image: image, completed: completed)
    }
    
    

}
