//
//  StudentTableViewController.swift
//  DemoCoreDataEmp
//
//  Created by KuAnh on 03/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit
import CoreData

class StudentTableViewController: UITableViewController {

    var fetchResult = CoreDataServices.shared.fetchResultsController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResult.delegate = self
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResult.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchResult.sections![section].numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudentTableViewCell

        let arrayStudent = fetchResult.object(at: indexPath)
        
        configureCell(cell, withEvent: arrayStudent)
        
        return cell
    }
    
    func configureCell(_ cell: StudentTableViewCell, withEvent student: Student) {
        cell.lbName.text = student.name?.description
        cell.lbAge.text = "\(student.age)"
        cell.lbAddress.text = student.address?.description
        cell.imageStd.image = student.imageStd as? UIImage
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchResult.managedObjectContext
            context.delete(fetchResult.object(at: indexPath))
            do {
                try context.save()
            } catch {
                print("error")
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let vc = segue.destination as? ViewController
                vc?.student = fetchResult.object(at: indexPath)
            }
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        
    }
}

extension StudentTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            configureCell(tableView.cellForRow(at: indexPath!)! as! StudentTableViewCell, withEvent: anObject as! Student)
        case .move:
            configureCell(tableView.cellForRow(at: indexPath!)! as! StudentTableViewCell, withEvent: anObject as! Student)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
