//
//  DevisListController.swift
//  AMIDECO
//
//  Created by saif on 19/01/2018.
//  Copyright © 2018 AS Technology. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

var file_index = -1
var file_list=[File_url]()

class DevisListController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var tableView_file: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        file_index = -1
        file_list.removeAll()
        recup_devis_list()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return file_list.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier:"cell")
        let file = file_list[indexPath.row]
        cell.textLabel?.text = file.nom
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        file_index = indexPath.row
        if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
            let mail = users[Myindex].email
            let fileRef = Storage.storage().reference().child("Devis/\(mail!)/"+file_list[file_index].nom!)
            print(fileRef)
            print(file_index)
            print(file_list[file_index].nom!)
            let local_File = "file:///\(AppDelegate.getAppDelegate().getDocDir())/\(self.randomString(5)+file_list[file_index].nom!)"
            //let encoded = local_File.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
            let localURL = URL(string: local_File)!
            print(localURL)
            _ = fileRef.write(toFile: localURL) { url, error in
                guard error == nil else{
                    AlerteController.showAlert(self, title: "Erreur", message: error!.localizedDescription)
                    return
                }
            }
        }

        //performSegue(withIdentifier: "info", sender: self)
    }
    
    
    func recup_devis_list(){
        if(Auth.auth().currentUser?.email=="ami.deco2@gmail.com"){
            let user=users[Myindex]
            let mail = self.makeFirebaseString(user.email!)
            Database.database().reference().child("devis").child(mail).observe(.childAdded, with: { (snapshot) in
                //print(snapshot)
                if let dictionnaire = snapshot.value as? [String: AnyObject]{
                    let devis = File_url()
                    devis.setValuesForKeys(dictionnaire)
                    file_list.append(devis)
                    DispatchQueue.main.async {
                        self.tableView_file.reloadData()
                    }
                }
                
            }, withCancel: nil)
        
        }
        else if(Auth.auth().currentUser?.email != "ami.deco2@gmail.com"){
            
            let mail = self.makeFirebaseString((Auth.auth().currentUser?.email!)!); Database.database().reference().child("devis").child(mail).observe(.childAdded, with: { (snapshot) in
                //print(snapshot)
                if let dictionnaire = snapshot.value as? [String: AnyObject]{
                    let devis = File_url()
                    devis.setValuesForKeys(dictionnaire)
                    file_list.append(devis)
                    DispatchQueue.main.async {
                        self.tableView_file.reloadData()
                    }
                }
                
            }, withCancel: nil)
        }
    }
    
    
    func makeFirebaseString(_ email: String) -> String{
        let arrCharacterToReplace = [".","#","$","[","]"]
        var finalString = email
        
        for character in arrCharacterToReplace{
            finalString = finalString.replacingOccurrences(of: character, with: ",")
        }
        
        return finalString
    }
    
    func randomString(_ length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }

}
