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
    
    
    @IBOutlet weak var welc: UILabel!
    //var pseudo:String!
    //var mdp:String!
    
    
    @IBOutlet weak var deconnexion: UIButton!
    
    
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
        guard let user = Auth.auth().currentUser?.displayName else{ return }
        welc.text = "Bonjour \(user)"
        // Do any additional setup after loading the view, typically from a nib.
            //welc.text=pseudo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      
    
}
}
