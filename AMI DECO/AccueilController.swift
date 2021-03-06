//
//  ViewController.swift
//  AMI DECO
//
//  Created by Adonis El Khoury  on 30/08/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseAuth


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class AccueilController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            if (Auth.auth().currentUser?.email == "ami.deco2@gmail.com") {
                self.performSegue(withIdentifier: "ClientsController", sender: nil)
            }
            else if(Auth.auth().currentUser?.email != "ami.deco2@gmail.com"){
                self.performSegue(withIdentifier: "AdminController", sender: nil)
            }
        }
    }
    
    @IBOutlet var Connexion:UIButton!
    
    @IBAction func connexion(sender: UIButton!){
        if Auth.auth().currentUser != nil{
             if (Auth.auth().currentUser?.email == "ami.deco2@gmail.com") {
                self.performSegue(withIdentifier: "ClientsController", sender: nil)
             }
             else{
                self.performSegue(withIdentifier: "AdminController", sender: nil)
            }
        }
        else{
            self.performSegue(withIdentifier: "ConnexionController", sender: nil)
        }
    }
    
    
    @IBOutlet var Inscription:UIButton!
    
    @IBAction func inscription(sender: UIButton){
        if Auth.auth().currentUser != nil{
            if (Auth.auth().currentUser?.email == "ami.deco2@gmail.com") {
                self.performSegue(withIdentifier: "ClientsController", sender: nil)
            }
            else{
                self.performSegue(withIdentifier: "AdminController", sender: nil)
            }
        }
        else{
            self.performSegue(withIdentifier: "InscriptionController", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        print("Bienvenu chez AMI DECO")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

