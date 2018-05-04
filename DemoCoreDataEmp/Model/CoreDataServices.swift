//
//  CoreDataServices.swift
//  DemoCoreDataEmp
//
//  Created by KuAnh on 03/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit
import CoreData

class CoreDataServices: NSObject, NSFetchedResultsControllerDelegate {
    
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
//        let nameStdSort = NSSortDescriptor(key: "name", ascending: false)
//        let ageStdSort = NSSortDescriptor(key: "age", ascending: false)
//        let addressStdSort = NSSortDescriptor(key: "address", ascending: false)
//        let imageStdSort = NSSortDescriptor(key: "imageStd", ascending: false)
//        fetchRequest.sortDescriptors = [nameStdSort,ageStdSort,addressStdSort,imageStdSort]
//
//        let aFetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.context, sectionNameKeyPath: nil, cacheName: "Master")
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
//    var _fetchResultsController: NSFetchedResultsController<Student>? = nil
    
}
