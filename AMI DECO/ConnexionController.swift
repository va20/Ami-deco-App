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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    @IBAction func connection(_ sender: UIButton) {
        guard let email_client = mail.text,
            email_client != "",
            let pass_client = mdp.text,
            pass_client != ""
            else{
                AlerteController.showAlert(self, title: "Manque info", message: "Veuillez remplir tous les champs s'il vous plaît")
                return
        }
        Auth.auth().signIn(withEmail: email_client, password: pass_client) { (user, error) in
            guard error == nil else{
                AlerteController.showAlert(self, title: "Erreur connexion", message: error!.localizedDescription)
                return
            }
            guard user != nil else { return }
            if(email_client=="ami.deco2@gmail.com"){
                self.performSegue(withIdentifier: "ClientsController", sender: nil)
            }
            else if let user = Auth.auth().currentUser{
                if !user.isEmailVerified {
                    let alert_verif = UIAlertController(title: "Vérification",message: "Votre adresse \(email_client) n'a pas encore été vérifié. Voulez-vous recevoir un autre mail de vérification? ",preferredStyle:.alert)
                    let ok_action = UIAlertAction(title: "Oui", style: .default){
                        (_) in
                            user.sendEmailVerification(completion: nil)
                    }
                    let cancel_action = UIAlertAction(title: "Non", style: .default, handler: nil)
                    
                    alert_verif.addAction(ok_action)
                    alert_verif.addAction(cancel_action)
                    self.present(alert_verif,animated: true, completion: nil)
                }
                else{
                    self.performSegue(withIdentifier: "AdminController", sender: nil)
                    
                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        ref=Database.database().reference()
        
    }
    
    func makeFirebaseString()->String{
        let arrCharacterToReplace = [".","#","$","[","]"]
        var finalString = self.mail.text
        
        for character in arrCharacterToReplace{
            finalString = finalString?.replacingOccurrences(of: character, with: ",")
        }
        
        return finalString!
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


