//
//  ViewController.swift
//  DemoCoreDataEmp
//
//  Created by KuAnh on 03/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var viewPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    var student: Student? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let std = student {
            if let name = txtName, let age = txtAge, let address = txtAddress {
                name.text = std.name?.description
                age.text = "\(std.age)"
                address.text = std.address?.description
                viewPhoto.image = std.imageStd as? UIImage
            }
        }
    }
    
    @IBAction func selectedImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imageSelected = info[UIImagePickerControllerOriginalImage] as! UIImage
        viewPhoto.image = imageSelected
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let name = txtName, let age = txtAge, let address = txtAddress {
            let context = CoreDataServices.shared.fetchResultsController.managedObjectContext
            let newStudent = Student(context: context)
            if let list = student {
                list.name = name.text
                list.age = Int32(age.text!)!
                list.address = address.text
                list.imageStd = viewPhoto.image
            } else {
                newStudent.name = txtName.text
                newStudent.age = Int32(txtAge.text!)!
                newStudent.address = txtAddress.text
                newStudent.imageStd = viewPhoto.image
            }
            do {
                try context.save()
            }catch  {
                fatalError("\(error)")
            }
            
        }
//        if let masterViewController = segue.destination as? StudentTableViewController, let std = student {
//            let context = CoreDataServices.shared.fetchResultsController.managedObjectContext
//            if let indexPath = masterViewController.tableView.indexPathForSelectedRow {
//                var updateStudent = CoreDataServices.shared.fetchResultsController.object(at: indexPath)
//                updateStudent = std
//                masterViewController.tableView.reloadRows(at: [indexPath], with: .none)
//            } else {
//                let newStudent = Student(context: context)
//                newStudent.name = txtName.text
//                newStudent.age = Int32(txtAge.text!)!
//                newStudent.address = txtAddress.text
//                newStudent.imageStd = viewPhoto.image
//            }
//            do {
//                try context.save()
//            }catch  {
//                fatalError("\(error)")
//            }
//        }
    }


}

