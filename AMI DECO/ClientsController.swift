//
//  ClientsController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 21/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseAuth


class ClientsController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        	self.navigationController?.isNavigationBarHidden=false
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Deconnexion",
                                                           style: .plain, target:self,action:#selector(singOut))
    }
    
    var Clients = [Users] ()
    
    let cl = ["salut","bonjour","bonsoir","ntm"]
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier:"cell")
        
        return (cell)
    }
    
    /*public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cl.count
        
    }*/
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }*/
    
    
    @IBOutlet weak var deconnexion: UIButton!
    
    @IBAction func singOut(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "AccueilController", sender: nil)
        }catch{
            print(error)
        }
    
    }
    
    /*public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        let cell = UITableViewCell (style: UITableViewCellStyle.default, reuseIdentifier: "clientsCell")
    
            cell.textLabel?.text=cl[indexPath.row]
        
            return(cell)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}
