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
    
    @IBOutlet weak var nom: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var prenom: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    var ref:DatabaseReference?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        ref=Database.database().reference()
        
    }
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
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = nom_client+" "+prenom_client

            changeRequest.commitChanges(completion: {(error) in
                guard error == nil else{
                    AlerteController.showAlert(self, title: "Erreur Request", message: error!.localizedDescription)
                    return
                }
                
                let info = ["nom":  self.nom.text,
                            "prenom":   self.prenom.text,
                            "email":    self.email.text
                ]
                let mail = ["email":  self.email.text]
                DatabaseServices.shared.usersRef.child(self.nom.text!+self.prenom.text!).setValue(info)
                DatabaseServices.shared.accomptRef.child(self.nom.text!+self.prenom.text!).setValue(mail)
                DatabaseServices.shared.factureRef.child(self.nom.text!+self.prenom.text!).setValue(mail)
                DatabaseServices.shared.travauxRef.child(self.nom.text!+self.prenom.text!).setValue(mail)
                self.performSegue(withIdentifier: "AdminController", sender: nil)
            })
        }
        
    }
    
    /*func isValidEmail(testStr:String)-> Bool{
        print("validate calendar: \(testStr)")
        let mailRegExp="[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", mailRegExp)
        return emailTest.evaluate(with: testStr)
    }*/
}
