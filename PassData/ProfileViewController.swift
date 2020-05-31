//
//  ProfileViewController.swift
//  PassData
//
//  Created by mark me on 5/26/20.
//  Copyright © 2020 mark me. All rights reserved.
//

import UIKit
import Firebase

protocol AddModelProtocol {
    func didAddToArray(didAdd:AddModel)
}

struct AddModel {
    
    var image:UIImage
    var field1:String
    var field2:String
    var field3:String
}

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var text1: UITextField!
    @IBOutlet var text2: UITextField!
    @IBOutlet var text3: UITextField!
    @IBOutlet var saveButtonDesine: UIButton!
    
    var delegate:AddModelProtocol?
    var refrence = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picture.layer.cornerRadius = picture.bounds.width/2
        
        self.refrence = Database.database().reference()
        self.saveFIRData()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.tapped(gestureRecognizer:)))
        picture.addGestureRecognizer(tap)
        picture.isUserInteractionEnabled = true
        
        
    }
    @objc func tapped(gestureRecognizer: UITapGestureRecognizer) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.picture.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any)
    {
        guard let image = picture.image else {
            print("You must select an image")
            return
        }
        
        guard let text1 = text1.text else {
            print("text 1 should not be empty")
            return
        }
        guard let text2 = text2.text else {
            print("text 2 should not be empty")
            return
        }
        
        guard let text3 = text3.text else {
            print("text 3 should not be empty")
            return
        }
        
        delegate?.didAddToArray(didAdd: AddModel(image: image, field1: text1, field2: text2, field3: text3))
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func saveFIRData() {
        
        self.uploadImage(self.picture.image!) { url in
            
            self.saveImage(name1: self.text1.text! ?? "", name2: self.text2.text! ?? "", name3: self.text3.text! ?? "", profileURL: url!) { success in
                if success != nil {
                    print("it works Good!")
                }
            }
        }
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let storageRef = Storage.storage().reference().child("myImage.png")
        let imageData = picture.image?.pngData()
        let metData = StorageMetadata()
        metData.contentType = "image/png"
        storageRef.putData(imageData!, metadata: metData) { (metData, error) in
            if error == nil {
                print("Image uploaded successfullyed")
                storageRef.downloadURL(completion: {(url, error)in
                    completion(url)
                })
                
            }else {
                print(error?.localizedDescription ?? "No error found")
                completion(nil)
            }
        }
        
    }
    
    func saveImage(name1: String, name2: String, name3: String, profileURL: URL, completion: @escaping ((_ url: URL?) -> ())) {
        
        let mydic = ["firstName": text1.text!, "lastName": text2.text!, "emailId": text3.text!, "profileURL": profileURL.absoluteString] as [String: Any]
        self.refrence.child("infoData").childByAutoId().setValue(mydic)
    }
    
    
}
