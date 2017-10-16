//
//  ClientsController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 21/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class ClientsController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var Clients = [Users] ()
    
    let cl = ["salut","bonjour","bonsoir","ntm"]
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cl.count
        
    }
    
    
   
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        let cell = UITableViewCell (style: UITableViewCellStyle.default, reuseIdentifier: "clientsCell")
    
            cell.textLabel?.text=cl[indexPath.row]
        
            return(cell)
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
