//
//  AmiController.swift
//  AMIDECO
//
//  Created by saif on 08/12/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseAuth

class AmiController: UIViewController {

    @IBOutlet weak var faire_devis: UIButton!
    
    @IBOutlet weak var faire_accompt: UIButton!
    
    @IBOutlet weak var faire_facture: UIButton!
    
    @IBOutlet weak var mesClients: UIButton!
    
    
    @IBOutlet weak var mesDocuments: UIButton!
    
    
    
    @IBOutlet weak var deconnexion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOut(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "AccueilController", sender: nil)
        }catch{
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
