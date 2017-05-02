//
//  ToDoTableViewCell.swift
//  inClass-ToDo
//
//  Created by daniel on 23.04.17.
//  Copyright © 2017 daniel. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {



    @IBOutlet weak var toDoImageUImg: UIImageView!
    @IBOutlet weak var toDoTaskName: UILabel!
    @IBOutlet weak var toDoTaskDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
