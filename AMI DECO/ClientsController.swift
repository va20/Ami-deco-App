//
//  ClientsController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 21/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class ClientsController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        	self.navigationController?.isNavigationBarHidden=false
    }*/
    
    var users=[User]()
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Deconnexion",
                                                           style: .plain, target:self,action:#selector(singOut))
        user_list()
    }
    
    var Clients = [Users] ()
    
    let cl = ["salut","bonjour","bonsoir","ntm"]
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier:"cell")
        let user = users[indexPath.row]
        cell.textLabel?.text = user.nom!+" "+user.prenom!
        cell.detailTextLabel?.text = user.email
        return cell
    }

    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true)
    }*/
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var deconnexion: UIButton!
    @IBAction func singOut(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "AccueilController", sender: nil)
        }catch{
            print(error)
        }
    
    }
    
    
    func user_list(){
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            //print(snapshot)
            if let dictionnaire = snapshot.value as? [String: AnyObject]{
                let user = User()
                user.setValuesForKeys(dictionnaire)
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
                
            }, withCancel: nil)
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}
