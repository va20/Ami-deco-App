//
//  Deconnexion.swift
//  AMIDECO
//
//  Created by saif on 23/10/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseAuth

class Deconnexion: UIViewController {
    
    @IBOutlet weak var label : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let username = Auth.auth().currentUser?.displayName else{
            return
        }
        //label.text = "Hello \(username)"
    }
    
    /*@IBAction func deconnexion(_ sender : IUButton){
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "Connexion", sender: nil)
        }catch{
            print(error)
        }
    }*/
}
