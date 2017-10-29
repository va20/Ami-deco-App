//
//  ConnexionController.swift
//  AMI DECO
//
//  Created by Adonis El Khoury  on 05/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ConnexionController: UIViewController{
 
    var ref:DatabaseReference?
    @IBOutlet weak var mdp: UITextField!
    @IBOutlet weak var mail: UITextField!
    
    @IBAction func connection(_ sender: UIButton) {
        guard let email_client = mail.text,
            email_client != "",
            let pass_client = mdp.text,
            pass_client != ""
            else{
                AlerteController.showAlert(self, title: "Manque info", message: "Veuillez remplir tout les champs s'il vous plaît")
                return
        }
        Auth.auth().signIn(withEmail: email_client, password: pass_client) { (user, error) in
            guard error == nil else{
                AlerteController.showAlert(self, title: "Erreur connexion", message: error!.localizedDescription)
                return
            }
            guard let user = user else { return }
            print(user.email ?? "Email")
            print(user.displayName ?? "display name")
            print(user.uid)
            if(email_client=="ami.deco2@gmail.com"){
                self.performSegue(withIdentifier: "ClientsController", sender: nil)
            }
            else{
                self.performSegue(withIdentifier: "AdminController", sender: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        ref=Database.database().reference()
        
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let adminCont: AdminController=segue.destination as! AdminController
        
        adminCont.pseudo=mail.text
        
     /*   if segue.identifier == "showAdmin"{
            
         
            em=email.text!
            mp=mdp.text!
            
            if(em=="ahmed" && mp=="ami"){
                print(em)
                print(mp)
               */
        
            }
        }*/
}


