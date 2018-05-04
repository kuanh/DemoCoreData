//
//  CoreDataServices.swift
//  DemoCoreDataEmp
//
//  Created by KuAnh on 03/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit
import CoreData

class CoreDataServices {
    
    static var shared: CoreDataServices = CoreDataServices()
    
    var fetchResultsController: NSFetchedResultsController<Student> {

        if _fetchResultsController != nil {
            return _fetchResultsController!
        }

        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.fetchBatchSize = 20

        let nameStdSort = NSSortDescriptor(key: "name", ascending: false)
        
        fetchRequest.sortDescriptors = [nameStdSort]

        _fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.context, sectionNameKeyPath: nil, cacheName: "Master")

        do {
            try _fetchResultsController?.performFetch()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        return _fetchResultsController!
    }

    var _fetchResultsController: NSFetchedResultsController<Student>?
    
}

