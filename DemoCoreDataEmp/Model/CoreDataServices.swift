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
    
    private var _students: [Student]?
    
    var students: [Student] {
        get {
            if _students == nil {
                fetchData()
            }
            return _students ?? []
        }
        
        set {
            _students = newValue
        }
        
    }
    
    private func fetchData() {
        _students = try? AppDelegate.context.fetch(Student.fetchRequest())
    }
    
    func removeData() {
        _students = nil
    }
    
    func addNewStudent(name: String?, age: Int?, address: String?, image: UIImage?) {
        let student = Student(context: AppDelegate.context)
        student.name = name
        if age != nil {
            student.age = Int32(age!)
        }
        student.address = address
        student.imageStd = image
        AppDelegate.saveContext()
        fetchData()
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
