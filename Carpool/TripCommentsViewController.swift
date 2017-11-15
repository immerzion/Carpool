//
//  TripCommentsViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/15/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

// identifiers comments: CommentsCell, add comment: AddCommentsCell

import UIKit
import CarpoolKit
import FirebaseCommunity


class TripCommentsViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
}


class CommentsCell: UITableViewCell {
    @IBOutlet weak var timeCommentLabel: UILabel!
    @IBOutlet weak var bodyCommentLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
    
    
}

class AddCommentsCell: UITableViewCell {
    @IBOutlet weak var addCommentTextField: UITextField!
    @IBAction func submitCommentButton(_ sender: UIButton) {
    }
    
}





