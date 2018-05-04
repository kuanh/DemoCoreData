//
//  StudentTableViewController.swift
//  DemoCoreDataEmp
//
//  Created by KuAnh on 03/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {

    var coreDataServices = CoreDataServices.shared.students
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coreDataServices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudentTableViewCell

        let image = coreDataServices[indexPath.row].imageStd as? UIImage
        
        cell.lbName.text = coreDataServices[indexPath.row].name
        cell.lbAge.text = "\(coreDataServices[indexPath.row].age)"
        cell.lbAddress.text = coreDataServices[indexPath.row].address
        cell.imageStd.image = image

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.context.delete(coreDataServices[indexPath.row])
            coreDataServices.remove(at: indexPath.row)
            AppDelegate.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let vc = segue.destination as! ViewController
                vc.student = coreDataServices[indexPath.row]
            }
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        coreDataServices = CoreDataServices.shared.students
        tableView.reloadData()
    }
    

}
