//
//  TripCommentsViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/15/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//


// finish submit button and entering comment field, need to add counter

import UIKit
import CarpoolKit
import FirebaseCommunity

class TripCommentsViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var commentTextField: UITextField!
    
    var trip: Trip!
    
    override func viewDidLoad() {
        API.observe(trip: trip, sender: self) { result in
            switch result {
            case .success(let newtrip):
                self.trip = newtrip
                self.tableView.reloadData()
            case .failure(let error):
                print(#function, error) //TODO
            }
        }
        self.hideKeyboardWhenTappedAround()
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.3) {
//            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 200, width:self.view.frame.size.width, height:self.view.frame.size.height)
//        }
//
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.3) {
//            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 200, width:self.view.frame.size.width, height:self.view.frame.size.height)
//        }
//    }
    
   
    @IBAction func onSubmitPressed() {
        API.add(comment: commentTextField.text!, to: trip)
        commentTextField.text = ""
    }
    
    
    func addComments(comment: String, to: Trip) {
        API.add(comment: comment, to: to)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip.comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
        cell.bodyCommentLabel.text = trip.comments[indexPath.row].body
        cell.userCommentLabel.text = trip.comments[indexPath.row].user.name
        cell.timeCommentLabel.text = trip.comments[indexPath.row].time.prettyDate + " " + trip.comments[indexPath.row].time.prettyTime
        return cell
    }
}


class CommentsCell: UITableViewCell {
    @IBOutlet weak var timeCommentLabel: UILabel!
    @IBOutlet weak var bodyCommentLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
}
