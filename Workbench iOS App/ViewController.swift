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
       
        //signUpWithEmailAndPassword() // working
        signInWithEmailAndPassword()   // working
        //sendPasswordResetLink()       // working
        //passwordlessSignIn() //scrapped
        //writeSingleValueToRealTimeDatabase()  // working
        writeMultipleValueToRealTimeDatabase()  // working
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
    
    
    func passwordlessSignIn(){
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "workbench-ef004.firebaseapp.com")
        // The sign-in operation has to always be completed in the app.
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        Auth.auth().sendSignInLink(toEmail: "utki.619@gmail.com", actionCodeSettings: actionCodeSettings){ error in
            if let error = error {
                print(error)
            }
            UserDefaults.standard.set("utki.619@gmail.com", forKey: "Email")
            print("Confirmation Link has been sent to your mail")
        }
    }
    
    func signInWithEmailAndPassword(){
        Auth.auth().signIn(withEmail: "utki.619@gmail.com", password: "password"){ authResult,error in
            
            if let error = error {
                print(error.localizedDescription)
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
    
    
    func writeSingleValueToRealTimeDatabase(){
        
        let currentUser = Auth.auth().currentUser?.uid
        print(currentUser!)
        
        let dataModel = DataModel(firstName: "Utkarsh", lastName: "Shekhar", contactNo: 9590831118)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        //Node --> workbench-ef004/testNode/data/uid
        //Access --> PUBLIC as of now
        ref.child("testNode").child("data").child(currentUser!).setValue(dataModel.nsdictionary)
        
        
    }
    
    
    func writeMultipleValueToRealTimeDatabase(){
        let currentUser = Auth.auth().currentUser?.uid
        print(currentUser!)
        
         //Node --> workbench-ef004/testNode/putMethod/uid
         //Access --> PUBLIC as of now
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        
        let datamodel = DataTwoModel(query: "Usb Drive not working", date: result)
        var ref : DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("testNode").child("putMethod").child(currentUser!).childByAutoId().setValue(datamodel.nsdictionary) //childByAutoId() creates new node inside user node
        
        
    }
    
    func readingFromRealTimeDb(){
        
    }
    
    
    func uploadFilesToStorage(){
        
    }
    
    func downloadfilesFromStorage(){
        
    }
    
}


// Model One
struct DataModel{
    let firstName: String
    let lastName: String
    let contactNo: Int
    
    var dictionary : [String : Any] {
        return ["firstName" : firstName,
                "lastName" : lastName,
                "contactNo": contactNo
        ]
    }
    
    var nsdictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
}


// Model Two
struct DataTwoModel{
    let query : String
    let date : String
    
    var dictionary : [String : Any] {
        return["query" : query,
               "date" : date
        ]
    }
    
    var nsdictionary : NSDictionary {
        return dictionary as NSDictionary
    }
}



/*
 
 https://essp.sysfore.com/index.php/api/login_check
 Utkarsh _SYS-337
 
 */
