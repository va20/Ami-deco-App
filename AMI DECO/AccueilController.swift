//
//  ViewController.swift
//  AMI DECO
//
//  Created by Adonis El Khoury  on 30/08/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class AccueilController: UIViewController {
    
    @IBOutlet var Connexion:UIButton!
    
    @IBAction func connexion(sender: UIButton!){
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Bienvenu chez AMI DECO")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

