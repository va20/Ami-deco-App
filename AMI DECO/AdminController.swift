//
//  AdminController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 03/10/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import Foundation
import UIKit

class AdminController: UIViewController {
    
    
    @IBOutlet weak var welc: UILabel!
    var pseudo:String!
    var mdp:String!
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            welc.text=pseudo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      
    
}
}
