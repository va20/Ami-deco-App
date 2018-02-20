	//
//  PassRecupViewController.swift
//  AMIDECO
//
//  Created by saif on 08/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
    

class PassRecupViewController: UIViewController {

    @IBOutlet weak var client_email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recover_pass(_ sender: UIButton) {
        guard let email = client_email.text,
            email != ""
            else{
                AlerteController.showAlert(self, title: "Manque info",message: "Veuillez saisir votre adresse mail s'il vous plaît")
                return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil{
                AlerteController.showAlert(self, title: "email envoyé",message: "Un courriel de réinitialisation de mot de passe vient d'être envoyé à votre adresse mail")
            }
            else {
                AlerteController.showAlert(self, title: "Erreur", message: error!.localizedDescription)
                return
            }
            
        }
        //self.performSegue(withIdentifier: "ConnexionController", sender: nil)
    }

}
