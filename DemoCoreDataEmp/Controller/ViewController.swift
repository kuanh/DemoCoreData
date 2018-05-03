//
//  ViewController.swift
//  DemoCoreDataEmp
//
//  Created by KuAnh on 03/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

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
            txtName.text = std.name?.description
            txtAge.text = "\(std.age)"
            txtAddress.text = std.address?.description
            viewPhoto.image = std.imageStd as? UIImage
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
            if let indexPath = masterViewController.tableView.indexPathForSelectedRow {
                
            } else {
                guard txtName.text != "" else { return }
                CoreDataServices.shared.addNewStudent(name: txtName.text, age: Int(txtAge.text ?? ""), address: txtAddress.text, image: viewPhoto.image)
            }
        }
    }


}

