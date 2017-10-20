//
//  InscriptionController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 14/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseDatabase


class InscriptionController: UIViewController{

    
    @IBAction func envoyerInscr(_ sender: UIButton) {
        print("zobi")
    }
    // var ref:DatabaseReference?

    @IBOutlet weak var nom: UITextField!
    
   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var prenom: UITextField!
    
    /*@IBAction func connexion(sender: UIButton){
        
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
      //  ref=Database.database().reference()
    
    }
 
    /*@IBAction func inscription(sender: UIButton!) {
       // ref?.child("photos").childByAutoId().setValue("qqc")
        print("zobi")
    }
    /*@IBAction func inscr(_ sender: Any) {
     
    }*/*/
    
}
