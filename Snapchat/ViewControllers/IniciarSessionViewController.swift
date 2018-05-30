//
//  IniciarSessionViewController.swift
//  Snapchat
//
//  Created by Hanzito on 16/05/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import Firebase

class IniciarSessionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func iniciarSessionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                print("Tenemos un error:\(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                    if let error = error {
                        print("Tenemos un error:\(error)")
                    }
                    else if let user = user {
                        print("Usuario creado exitosamente: \(user.uid)")
                        Database.database().reference().child("usuarios").child(user.uid).child("email").setValue(user.email)
                        self.performSegue(withIdentifier: "IniciarSessionSegue", sender: nil)
                    }
                }
            }
            else if let user = user {
                print("Inicio de session exitoso: \(user.uid)")
                self.performSegue(withIdentifier: "IniciarSessionSegue", sender: nil)
            }
        }
    }
    
}

