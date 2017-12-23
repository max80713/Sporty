//
//  LoginController.swift
//  iSports
//
//  Created by Susu Liang on 2017/12/13.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class LoginController: UIViewController {
    
    let keyChain = KeychainSwift()

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBAction func signIn(_ sender: Any) {
        guard let email = emailText.text,
            let password = passwordText.text
            else {
                print("Form is not valid.")
                return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    var message: String = ""
                    
                    switch errCode {
                    case .invalidEmail:
                        message = NSLocalizedString("Invalid email", comment: "")
                    case .userNotFound:
                        message = NSLocalizedString("Wrong email", comment: "")
                    case .wrongPassword:
                        message = NSLocalizedString("Wrong password", comment: "")
                    default:
                        print("Create User Error: \(error!)")
                        
                    }
                    
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    if self.presentedViewController == nil {
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                return
            }
                        
            let tabBarController = TabBarController(itemTypes: [ .map, .home, .my])
            tabBarController.selectedIndex = 1
            self.present(tabBarController, animated: true, completion: nil)
        })
    }
    
    @IBAction func signUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpController = storyboard.instantiateViewController(withIdentifier: "signUpController")
        self.present(signUpController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        keyChain.clear()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}