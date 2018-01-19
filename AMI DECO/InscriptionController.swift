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
                AlerteController.showAlert(self, title: "Manque info",message: "Veuillez remplir tous les champs s'il vous plaît")
                return
        }
        Auth.auth().createUser(withEmail: email_client, password: pass_client){ (user, error) in
            guard error == nil else {
                AlerteController.showAlert(self, title: "Erreur", message: error!.localizedDescription)
                return
            }
            guard let user = user else{ return }
            //print(user.email ?? "Email n'existe pas ")
            //print(user.uid)
                Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
                    guard error == nil else{
                        AlerteController.showAlert(self, title: "Erreur Request", message: error!.localizedDescription)
                        return
                    }
                    let alert = UIAlertController(title:"Vérification",message:"Un mail de vérification vient d'être envoyé à \(self.email.text ?? "") .",preferredStyle:.alert)
                    let action = UIAlertAction(title:"ok",style:.default){
                        (_) in
                        
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = nom_client+" "+prenom_client
                        
                        changeRequest.commitChanges(completion: {(error) in
                            guard error == nil else{
                                AlerteController.showAlert(self, title: "Erreur Request", message: error!.localizedDescription)
                                return
                            }
                        })
                        let info = ["nom":  self.nom.text,
                                    "prenom":   self.prenom.text,
                                    "email":    self.email.text,
                                    "id_client":   self.pass.text
                        ]
                        let mail = ["email":  self.email.text]
                        let key = self.makeFirebaseString()
                        print(key)
                        DatabaseServices.shared.usersRef.child(key).setValue(info)
                        DatabaseServices.shared.accomptRef.child(key).setValue(mail)
                        DatabaseServices.shared.factureRef.child(key).setValue(mail)
                        DatabaseServices.shared.travauxRef.child(key).setValue(mail)
                        DatabaseServices.shared.photoRef.child(key).setValue(mail)
                        DatabaseServices.shared.devisRef.child(key).setValue(mail)
                        
                        if Auth.auth().currentUser != nil{
                            if (!(Auth.auth().currentUser?.isEmailVerified)!){
                                do{
                                    try Auth.auth().signOut()
                                }catch{
                                    print(error)
                                }
                            }
                        }
                        
                        self.performSegue(withIdentifier: "AccueilController", sender: nil)

                    }
                    alert.addAction(action)
                    self.present(alert, animated: true,completion:nil)
                })
            
        }
        
    }
    
    func randomString(_ length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    func makeFirebaseString()->String{
        let arrCharacterToReplace = [".","#","$","[","]"]
        var finalString = self.email.text
        
        for character in arrCharacterToReplace{
            finalString = finalString?.replacingOccurrences(of: character, with: ",")
        }
        
        return finalString!
    }
}
