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
    
    var student: Student?
    
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
        if let masterViewController = segue.destination as? StudentTableViewController {
            let context = masterViewController.fetchResult.managedObjectContext
            if let indexPath = masterViewController.tableView.indexPathForSelectedRow {
                student = masterViewController.fetchResult.object(at: indexPath)
            } else {
                student = Student(context: context)
            }
            student?.name = txtName.text
            student?.age = Int32(txtAge.text!)!
            student?.address = txtAddress.text
            student?.imageStd = viewPhoto.image
            // Save the context.
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }


}

