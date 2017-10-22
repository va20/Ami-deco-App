//
//  InscriptionController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 14/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class InscriptionController: UIViewController{

    
    @IBAction func envoyerInscr(_ sender: UIButton) {
        
        guard let nom_client = nom.text,
            nom_client != "",
            let prenom_client = prenom.text,
            prenom_client != "",
            let email_client = email.text,
            email_client != "",
            let pass_client = pass.text,
            pass_client != ""
            else{
                AlerteController.showAlert(self, title: "Manque info",message: "Veuillez remplir tout les champs s'il vous plaît")
                return
        }
        Auth.auth().createUser(withEmail: email_client, password: pass_client){ (user, error) in
            guard error == nil else {
                AlerteController.showAlert(self, title: "Erreur", message: error!.localizedDescription)
                return
            }
            guard let user = user else{ return }
            print(user.email ?? "Email n'existe pas ")
            print(user.uid)
            
            let info = ["nom":  self.nom.text,
                        "prenom":   self.prenom.text,
                        "email":    self.email.text
             ]
            DatabaseServices.shared.usersRef.child(self.email.text!).setValue(info)
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = nom_client+" "+prenom_client
            
            changeRequest.commitChanges(completion: {(error) in
                guard error == nil else{
                    AlerteController.showAlert(self, title: "Erreur Request", message: error!.localizedDescription)
                    return
                }
                //self.performSegue(withIdentifier: "espaceClient", sender: nil)
            })
        }
        
    }
    var ref:DatabaseReference?

    @IBOutlet weak var nom: UITextField!
    
   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var prenom: UITextField!

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        ref=Database.database().reference()
    
    }
    /*func isValidEmail(testStr:String)-> Bool{
        print("validate calendar: \(testStr)")
        let mailRegExp="[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", mailRegExp)
        return emailTest.evaluate(with: testStr)
    }*/
}
