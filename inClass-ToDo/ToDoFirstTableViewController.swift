//
//  ToDoFirstTableViewController.swift
//  inClass-ToDo
//
//  Created by daniel on 24.04.17.
//  Copyright © 2017 daniel. All rights reserved.
//

import UIKit

class ToDoFirstTableViewController: UITableViewController {
    
    
    var selectedCellIndex = Int()
    
    @IBOutlet var toDoTable: UITableView!
    
//    let sections = ["Incomplete","Complete"]
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }

    
    //Conform to UITablekit Protocol
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return toDoManager.toDoItems.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        //return sections.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        cell.toDoTaskName.text = toDoManager.toDoItems[indexPath.row].name
        cell.toDoTaskDesc.text = toDoManager.toDoItems[indexPath.row].desc
        cell.toDoImageUImg.image = toDoManager.toDoItems[indexPath.row].image
        return cell
    }
    
    //Refresh to table contents
    override func viewDidAppear(_ animated: Bool) {
        toDoTable.reloadData()
    }
    
    //UITableViewDeleteItem
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            toDoManager.toDoItems.remove(at: indexPath.row)
            toDoTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        
        case "addItem":
            let destVwController = segue.destination as! DetailsViewController
            destVwController.isEditMode = false
        
        case "showDetails":
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let selectedToDoItem = toDoManager.toDoItems[(selectedIndexPath?.row)!]
            let destVwController = segue.destination as! DetailsViewController
            destVwController.isEditMode = true
            destVwController.currentToDoItem = selectedToDoItem
            self.selectedCellIndex = (selectedIndexPath?.row)!
            
        default :
            print ("wrong segue")
        }
    }
    
    @IBAction func unwindToToDoList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? DetailsViewController {
            
            //split processing between updating vs adding new item
            if sourceViewController.isEditMode {
                toDoManager.toDoItems[selectedCellIndex].dateCreated = sourceViewController.tCreatedDate
                toDoManager.toDoItems[selectedCellIndex].name = sourceViewController.toDoNameTxFd.text!
                toDoManager.toDoItems[selectedCellIndex].desc = sourceViewController.toDoDescTxVw.text!
                toDoManager.toDoItems[selectedCellIndex].image = sourceViewController.toDoImageUImg.image!
                toDoManager.toDoItems[selectedCellIndex].completed = sourceViewController.toDoCompleteSw.isOn
                toDoManager.toDoItems[selectedCellIndex].dateDue = sourceViewController.tDueDate
                toDoManager.toDoItems[selectedCellIndex].location = sourceViewController.toDoLocation.text!
                
                toDoTable.reloadData()
            }
            else {
                
                toDoManager.addToDo(name: sourceViewController.toDoNameTxFd.text!,
                                    desc: sourceViewController.toDoDescTxVw.text!,
                                    dateCreated: sourceViewController.tCreatedDate,
                                    complete: sourceViewController.toDoCompleteSw.isOn,
                                    image: sourceViewController.toDoImageUImg.image!,
                                    dateDue: sourceViewController.tDueDate,
                                    location: sourceViewController.toDoLocation.text!)

                toDoTable.reloadData()
            }
            
        }
    }
}
