//
//  ImageViewController.swift
//  Snapchat
//
//  Created by Hanzito on 16/05/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoButton: UIButton!
    
    var imagenPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenPicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagenPicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagenPicker.sourceType = .savedPhotosAlbum
        imagenPicker.allowsEditing = false
        present(imagenPicker, animated:  true, completion: nil)
    }
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoButton.isEnabled = false
        let imageFolder = Storage.storage().reference().child("imagenes")
        let imagenData = UIImagePNGRepresentation(imageView.image!)!
        
        imageFolder.child("\(NSUUID().uuidString).jpg").putData(imagenData, metadata: nil, completion: {(medatada,error)in
            print("Intentando subir imagen")
            if error != nil {
                print("Ocurrio un error: \(error)")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
