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
    
    private var _student: [Student]?
    
    var student: [Student] {
        get {
            if _student == nil {
                fetchData()
            }
            return _student ?? []
        }
        
        set {
            _student = newValue
        }
        
    }
    
    private func fetchData() {
        _student = try? AppDelegate.context.fetch(Student.fetchRequest())
    }
    
    func removeData() {
        _student = nil
    }
    
    func addNewStudent(std: Student) {
        _student?.append(std)
    }
    
//    var fetchResultsController: NSFetchedResultsController<Student> {
//
//        if _fetchResultsController != nil {
//            return _fetchResultsController!
//        }
//
//        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
//        fetchRequest.fetchBatchSize = 20
//
//        let idStdSort = NSSortDescriptor(key: "idStd", ascending: false)
//        let nameStdSort = NSSortDescriptor(key: "name", ascending: false)
//        fetchRequest.sortDescriptors = [idStdSort, nameStdSort]
//
//        let aFetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: , sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchResultsController.delegate = self
//        _fetchResultsController = aFetchResultsController
//        do {
//            try _fetchResultsController?.performFetch()
//        } catch let error as NSError {
//            print("\(error), \(error.userInfo)")
//        }
//        return _fetchResultsController!
//    }
//
//    var _fetchResultsController: NSFetchedResultsController<Students>? = nil
    
}
