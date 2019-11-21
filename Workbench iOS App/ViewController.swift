//
//  ViewController.swift
//  Workbench iOS App
//
//  Created by Sysfore-MAC on 21/11/19.
//  Copyright © 2019 Sysfore-MAC. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //signUpWithEmailAndPassword()
        //signInWithEmailAndPassword()
        //sendPasswordResetLink()
    }
    
    func signUpWithEmailAndPassword(){
        Auth.auth().createUser(withEmail: "utki.619@gmail.com", password: "password"){ AuthResultCallback, error in
            
            guard let user = AuthResultCallback?.user, error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("\(user.email!) created")
            
        }
    }
    
    func signInWithEmailAndPassword(){
        Auth.auth().signIn(withEmail: "utki.619@gmail.com", password: "password"){ authResult,error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("SignIn Successfull")
        }
    }
    
    
    func sendPasswordResetLink(){
        Auth.auth().sendPasswordReset(withEmail: "utki.619@gmail.com"){ error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            print("Password Reset Main has been sent to user's mailId")
            
        }
    }
    
}

