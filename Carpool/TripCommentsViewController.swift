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

class TripCommentsViewController: UITableViewController {
    
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
    }
    
    @IBOutlet var commentTextField: UITextField!
    
    @IBAction func onSubmitPressed() {
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
        cell.timeCommentLabel.text = trip.comments[indexPath.row].time.prettyDate
        return cell
    }
}


class CommentsCell: UITableViewCell {
    @IBOutlet weak var timeCommentLabel: UILabel!
    @IBOutlet weak var bodyCommentLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
}
