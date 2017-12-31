//
//  AdminController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 03/10/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AdminController: UIViewController {
    
    var photo_url_list = [Photo_Url]()

    @IBOutlet weak var back_button: UIBarButtonItem!
    
    @IBOutlet weak var supprimer: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser != nil{
            if(Auth.auth().currentUser?.email != "ami.deco2@gmail.com"){
                if (!(Auth.auth().currentUser?.isEmailVerified)!){
                    do{
                        try Auth.auth().signOut()
                        self.performSegue(withIdentifier: "ConnexionController", sender: nil)
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var welc: UILabel!

    @IBOutlet weak var deconnexion: UIButton!
    
    
    
    @IBAction func delete_user(_ sender: UIButton) {
        
        if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
            let alert_verif = UIAlertController(title: "Avertissement",message: "Êtes-vous sûr de vouloir supprimer cet utilisateur? (Toutes les données stockées seront complètement effacées!)",preferredStyle:.alert)
            let user_tmp = users[Myindex]
            let email = self.makeFirebaseString(user_tmp.email!)
            self.list_photo_info(email)
            let ok_action = UIAlertAction(title: "Oui", style: .default){
                (_) in
                
                DatabaseServices.shared.usersRef.child(email).removeValue()
                DatabaseServices.shared.accomptRef.child(email).removeValue()
                DatabaseServices.shared.factureRef.child(email).removeValue()
                DatabaseServices.shared.travauxRef.child(email).removeValue()
                DatabaseServices.shared.photoRef.child(email).removeValue()

                
                let storage_ref = Storage.storage().reference().child("images/\(user_tmp.email!)/")
                print(self.photo_url_list.count)
                for info in self.photo_url_list {
                    storage_ref.child(info.nom!).delete(completion: { (error) in
                        guard error == nil else{
                            AlerteController.showAlert(self, title: "Erreur connexion", message: error!.localizedDescription)
                            return
                        }
                    })
                }

                
                /*Auth.auth().signIn(withEmail: user_tmp.email!, password: user_tmp.id!){ (user, error) in
                    guard error == nil else{
                        AlerteController.showAlert(self, title: "Erreur connexion", message: error!.localizedDescription)
                        return
                    }
                    print("ok sing")
                    guard user != nil else { return }
                    print("ok2")
                }
                Auth.auth().currentUser?.delete(completion: { (error) in
                    guard error == nil else{
                        AlerteController.showAlert(self, title: "Erreur suppression compte", message: error!.localizedDescription)
                        return
                    }
                    print("ok3")
                })*/
                self.performSegue(withIdentifier: "Client_delete", sender: nil)
            }
            let cancel_action = UIAlertAction(title: "Non", style: .default, handler: nil)
            
            alert_verif.addAction(ok_action)
            alert_verif.addAction(cancel_action)
            self.present(alert_verif,animated: true, completion: nil)
            
        }
    }
    
    func makeFirebaseString(_ email: String)->String{
        let arrCharacterToReplace = [".","#","$","[","]"]
        var finalString = email
        
        for character in arrCharacterToReplace{
            finalString = finalString.replacingOccurrences(of: character, with: ",")
        }
        
        return finalString
    }
    
    func list_photo_info(_ email: String){
        Database.database().reference().child("photo").child(email).observe(.childAdded, with: { (snapshot) in
            //print(snapshot)
            if let dictionnaire = snapshot.value as? [String: AnyObject]{
                let photo_info = Photo_Url()
                photo_info.setValuesForKeys(dictionnaire)
                self.photo_url_list.append(photo_info)
            }
            
        }, withCancel: nil)
    }
    
    func checkLogin(){
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(singout), with:nil,afterDelay:0)
        }
        else{
            	
        }
    }
    
    @IBAction func singout(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "AccueilController", sender: nil)
        }catch{
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil{
            if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
                let user = users[Myindex]
                welc.text = "Bonjour "+user.nom!+" "+user.prenom!
                //self.back_button.accessibilityElementsHidden=false
                self.back_button.isEnabled=true
                self.supprimer.isHidden = false

            }
            else if(Auth.auth().currentUser?.email != "ami.deco2@gmail.com"){
                print("fdp4")
                guard let user = Auth.auth().currentUser?.displayName else{ return }
                welc.text = "Bonjour \(user)"
                //self.back_button.accessibilityElementsHidden=false
                self.back_button.isEnabled=false
                self.supprimer.isHidden = true
                // Do any additional setup after loading the view, typically from a nib.
                //welc.text=pseudo
            }
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      
    }
    
    
}
