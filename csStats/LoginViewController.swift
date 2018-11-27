//
//  LoginViewController.swift
//  csStats
//
//  Created by Tobias Frantsen on 27/11/2018.
//  Copyright © 2018 Tobias Frantsen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.backgroundColor = .green
        self.loginButton.setTitleColor(.black, for: .normal)
        self.loginButton.setTitle("Login", for: .normal)
        
        self.loginButton.layer.cornerRadius = 10
        
        
        self.loginButton.becomeFirstResponder()
        self.view.backgroundColor = .blue
       
    }
    
    @IBAction func loginButtonTap(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menuViewController") as? ViewController  {
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
