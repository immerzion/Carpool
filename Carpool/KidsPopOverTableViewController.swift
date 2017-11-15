////
////  KidsPopOverTableViewController.swift
////  Carpool
////
////  Created by Ernesto Bautista on 11/8/17.
////  Copyright © 2017 Immerzion Interactive. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//class KidsPopOverViewController: UITableViewController {
//    
//    var kidsArray = ["Jack", "Jill", "Jenny", "John"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.reloadData()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        tableView.reloadData()
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return kidsArray.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "KidCell", for: indexPath)
//        cell.textLabel?.text = kidsArray[indexPath.row]
//        print(kidsArray[indexPath.row])
//        return cell
//    }
//    
//}

