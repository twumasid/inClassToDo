//
//  DetailsViewController.swift
//  inClass-ToDo
//
//  Created by daniel on 12.04.17.
//  Copyright © 2017 daniel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate{

    var isEditMode = false
    var currentToDoItem = toDoItemType()
    
    @IBOutlet weak var toDoTaskLbl: UILabel!
    @IBOutlet weak var toDoDateLbl: UILabel!
    @IBOutlet weak var toDoNameTxFd: UITextField!
    @IBOutlet weak var toDoDescTxVw: UITextView!
    @IBOutlet weak var toDoImageUImg: UIImageView!
    @IBOutlet weak var toDoCompleteSw: UISwitch!
 
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
   
    //generate formatted date
    func generateCustomDate() -> String {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let customDate = dateFormatter.string(from: Date())
        return customDate
    }
    
    override func viewDidLoad() {
        if isEditMode {
            navigationItem.title = currentToDoItem.name
            toDoTaskLbl.text = currentToDoItem.name
            toDoDateLbl.text = currentToDoItem.date
            toDoNameTxFd.text = currentToDoItem.name
            toDoDescTxVw.text = currentToDoItem.desc
            toDoImageUImg.image = currentToDoItem.image
            toDoCompleteSw.isOn = currentToDoItem.completed
        }
        super.viewDidLoad()
    }
    
    //remove keyboard if focus is off editing field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        toDoTaskLbl.text = toDoNameTxFd.text
        self.view.endEditing(true)
    }
    
    //update task label when task name is set
    func textFieldDidEndEditing(_ textField: UITextField) {
        toDoTaskLbl.text = toDoNameTxFd.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITextField Delegate, hides keyboard when you hit return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

