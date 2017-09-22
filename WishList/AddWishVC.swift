//
//  AddWishVC.swift
//  WishList
//
//  Created by James Meli on 2/28/17.
//  Copyright © 2017 James Meli. All rights reserved.
//

import UIKit

class AddWishVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var detailsTextField: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var wishImage: UIImageView!
    
    var itemToEdit: Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        
        detailsTextField.delegate = self
        priceTextField.delegate = self
        titleTextField.delegate = self
        
        
        if itemToEdit != nil {
            loadItemData()
        }
        
        wishImage.layer.cornerRadius = 12
        
        let deleteBarButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(AddWishVC.deleteWish))
        
        navigationItem.rightBarButtonItem = deleteBarButton

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        guard let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        
        wishImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }


    @IBAction func addImagePressed(_ sender: Any) {
        
        
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            imagePickerController.sourceType = .savedPhotosAlbum
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        

    }
   
    @IBAction func savePressed(_ sender: Any) {
        
        

        var item: Item!
        let picture = Image(context: context)
        picture.image = wishImage.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
         item.toImage = picture
        
        if let name = titleTextField.text {
            item.name = name
        }
        
        if let details = detailsTextField.text {
            item.details = details
        }
        
        if let price = priceTextField.text {
            item.price = Float((price as NSString).doubleValue)
            
        }
        
        ad.saveContext()
        navigationController?.popToRootViewController(animated: true)
        print("Successfully saved to core data")
            }
    
    func loadItemData(){
        
        if let item = itemToEdit {
            titleTextField.text = item.name
            priceTextField.text = "\(item.price)"
            detailsTextField.text = item.details
            wishImage.image = item.toImage?.image as? UIImage
        }
        
        
    }
    
    func deleteWish(){
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()

        }
        
       navigationController?.popToRootViewController(animated: true)
       
        
    }
    
    
    
    
    
    
}

    
    

    

