//
//  DetailsViewController.swift
//  inClass-ToDo
//
//  Created by daniel on 12.04.17.
//  Copyright © 2017 daniel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate{

    //determines if detailsViewControlller is loaded in edit or adding mode
    var isEditMode = false
    
    //temporary container to hold currently loaded or new todoItem
    var currentToDoItem = toDoItemType()
    
    //temporary placeholders to allow date manipulation
    var tCreatedDate = Date()
    var tDueDate = Date()
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    //Interface outlets
    @IBOutlet weak var toDoCreatedOnLabel: UILabel!
    @IBOutlet weak var toDoDateLbl: UILabel!
    @IBOutlet weak var toDoNameTxFd: UITextField!
    @IBOutlet weak var toDoDescTxVw: UITextView!
    @IBOutlet weak var toDoDueDate: UITextField!
    @IBOutlet weak var toDoImageUImg: UIImageView!
    @IBOutlet weak var toDoCompleteSw: UISwitch!
    @IBOutlet weak var toDoLocation: UITextField!
 
    //dismiss view if cancelled
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //hide image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
    
    //set image picker selected image to todoimage
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
         toDoImageUImg.image! =  selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    //when image is tapped
    @IBAction func selectedTaskImage(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
   
    //generate date format
    func generateCustomDateFormat(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let customDate = dateFormatter.string(from: date!)
        return customDate
    }
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if isEditMode {
            
        
            navigationBar.topItem?.title = currentToDoItem.name
            //self.navigationBar.topItem.title = "New Title"
            
            toDoDateLbl.text = generateCustomDateFormat(date: currentToDoItem.dateCreated!)
            toDoNameTxFd.text = currentToDoItem.name
            toDoDescTxVw.text = currentToDoItem.desc
            toDoImageUImg.image = currentToDoItem.image
            toDoCompleteSw.isOn = currentToDoItem.completed
            toDoDueDate.text = generateCustomDateFormat(date: currentToDoItem.dateDue!)
            toDoLocation.text = currentToDoItem.location
            
            
            
            let dueDateCheck = Date().compare(currentToDoItem.dateDue!)
            switch dueDateCheck {
                case .orderedAscending:
                    //over due event
                    toDoDueDate.textColor = UIColor.green
                
                case .orderedDescending:
                    //not yet due
                    toDoDueDate.textColor = UIColor.red
                    //due today
                case .orderedSame:
                    toDoDueDate.textColor = UIColor.yellow
            }
            
            if toDoCompleteSw.isOn {
                todoCompleted()
            }
        }
            
        else{
            self.tCreatedDate = Date()
            toDoDateLbl.text = generateCustomDateFormat(date: self.tCreatedDate)
        }
        
        //populate due date with UIDatePicker
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        toDoDueDate.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(DetailsViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        //populate location with location picker
            //execute some cute here
        
        //toDoLocation.inputView =
        
        

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if toDoDescTxVw.text == "Description" {
            toDoDescTxVw.text = ""
        }
    }
    
    func datePickerValueChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        self.tDueDate = sender.date
        toDoDueDate.text = dateFormatter.string(from: self.tDueDate)
    }
    
    //change some display attibutes if task is complete
    func todoCompleted() {
        toDoCreatedOnLabel.textColor = UIColor.red
        toDoCreatedOnLabel.text = "Complete"
        toDoDateLbl.text = "Created: " + toDoDateLbl.text!
        toDoCompleteSw.onTintColor = UIColor.red
     }
    
//    //remove keyboard if focus is off editing field
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //toDoTaskLbl.text = toDoNameTxFd.text
//        self.view.endEditing(true)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToDetailsView(sender: UIStoryboardSegue){
    
    
    }
    
    
    //UITextField Delegate, hides keyboard when you hit return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

