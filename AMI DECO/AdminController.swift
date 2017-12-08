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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    
    @IBOutlet weak var welc: UILabel!

    @IBOutlet weak var deconnexion: UIButton!
    
    
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
        if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
            let user = users[Myindex]
            welc.text = "Bonjour "+user.nom!+" "+user.prenom!
        }
        else{
            guard let user = Auth.auth().currentUser?.displayName else{ return }
            welc.text = "Bonjour \(user)"
            // Do any additional setup after loading the view, typically from a nib.
            //welc.text=pseudo
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      
    }
    
    
}
