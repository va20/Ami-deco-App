//
//  ConnexionController.swift
//  AMI DECO
//
//  Created by Adonis El Khoury  on 05/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class ConnexionController: UIViewController{
 
    @IBOutlet var email:UITextField!
    @IBOutlet var mdp:UITextField!
    
    var em:String = ""
    var mp:String = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let adminCont: AdminController=segue.destination as! AdminController
        
        adminCont.pseudo=email.text
        
     /*   if segue.identifier == "showAdmin"{
            
         
            em=email.text!
            mp=mdp.text!
            
            if(em=="ahmed" && mp=="ami"){
                print(em)
                print(mp)
               */
        
            }
        }


