//
//  ViewController.swift
//  AMIDECO
//
//  Created by saif on 29/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseStorage
import SDWebImage
import FirebaseDatabase
import FirebaseAuth

//photo
class PhotoController: UIViewController, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var index_path:Int = 0
    var customFlowImageLayout: CollectionViewFlowLayout!
    var images = [ImageProperties]()
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var add_photo: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
            self.add_photo.isEnabled=true
        }
        else if(Auth.auth().currentUser?.email != "ami.deco2@gmail.com"){
            self.add_photo.isEnabled=false
        }
        imagePicker.delegate = self
        imageCharge()
        customFlowImageLayout = CollectionViewFlowLayout()
        collectionView.collectionViewLayout = customFlowImageLayout
        collectionView.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(false, animated:false)
    }
    
    
    @objc func imagePickerController(_ : UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
            dismiss(animated: true, completion: nil)
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
                //les donnes dans la memoire
                var data = Data()
                data = UIImageJPEGRepresentation(pickedImage, 0.8)!
                
                //cree une reference vers le fichier qu'on veut uploader
                let user_tmp = users[Myindex]
                let photo_name = randomString(20)
                let imageRef = Storage.storage().reference().child("images/\(user_tmp.email!)/" + photo_name)
                
            
                //uploader le fichier au images/randomString
                _ = imageRef.putData(data, metadata: nil) { (metadata,error) in
                    guard let metadata = metadata else {
                        return
                    }
                    //metadata contient des informations sur le fichier uploader
                    let downloadURL = metadata.downloadURL()
                    print(downloadURL!)
                    print(downloadURL!.absoluteString)
                    
                    //mise a jour l'url dans la base de donnée
                    if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
                        let user = users[Myindex]
                        let child_user = self.makeFirebaseString(user.email!)
                        print("child ami DECOO:"+child_user)
                        let key_user = DatabaseServices.shared.photoRef.child(child_user).childByAutoId().key
                        let image_user = ["url": downloadURL?.absoluteString,
                                          "nom":    photo_name]
                        let childUpdate_user = ["/\(key_user)":image_user]
                        DatabaseServices.shared.photoRef.child(child_user).updateChildValues(childUpdate_user)
                    }
                }
            }
        }
        
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

    @IBAction func loadImage(_ sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion: nil)
    }
    
    public func imageCharge(){
        var child=""
        if(Auth.auth().currentUser?.email! == "ami.deco2@gmail.com"){
            let user = users[Myindex]
            child = self.makeFirebaseString(user.email!)
        }
        else if(Auth.auth().currentUser?.email! != "ami.deco2@gmail.com"){
            child = self.makeFirebaseString((Auth.auth().currentUser?.email!)!)
        }
        DatabaseServices.shared.photoRef.child(child).observe(DataEventType.value,with: { (snapshot) in
            var newImage = [ImageProperties]()
            
            for imagePropertiesSnapshot in snapshot.children{
                let imagePropObject = ImageProperties(snapshot: imagePropertiesSnapshot as! DataSnapshot)
                newImage.append(imagePropObject)
            }
            
            self.images = newImage;
            self.collectionView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! ImageCollectionViewCell
        
        let image = images[indexPath.row]
        self.index_path=indexPath.row
        cell.imageView.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named: "image"))
        
        let tap_image = UITapGestureRecognizer(target: self,action: #selector(imageTapped))
        
        let tap_image_long = UILongPressGestureRecognizer(target: self,action: #selector(Long_Press))
        
        cell.imageView.addGestureRecognizer(tap_image)
        
        cell.imageView.addGestureRecognizer(tap_image_long)
        
        
        return cell
        
    }
    
    func makeFirebaseString(_ email: String) -> String{
        let arrCharacterToReplace = [".","#","$","[","]"]
        var finalString = email
        
        for character in arrCharacterToReplace{
            finalString = finalString.replacingOccurrences(of: character, with: ",")
        }
        
        return finalString
    }
    
    @IBAction func Long_Press(_ sender: UILongPressGestureRecognizer){
        if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
            let image = images[self.index_path]
            let alert_verif = UIAlertController(title: "Avertissement",message: "Êtes-vous sûr de vouloir supprimer cette image?",preferredStyle:.alert)
            let user_tmp = users[Myindex]
            let email = self.makeFirebaseString(user_tmp.email!)
            let ok_action = UIAlertAction(title: "Oui", style: .default){
                (_) in
                let storage_ref = Storage.storage().reference().child("images/\(user_tmp.email!)/")
                storage_ref.child(image.nom!).delete(completion: { (error) in
                    guard error == nil else{
                        AlerteController.showAlert(self, title: "Erreur connexion", message: error!.localizedDescription)
                        return
                    }
                })
                self.performSegue(withIdentifier: "Client_delete", sender: nil)
            }
            let cancel_action = UIAlertAction(title: "Non", style: .default, handler: nil)
            
            alert_verif.addAction(ok_action)
            alert_verif.addAction(cancel_action)
            self.present(alert_verif,animated: true, completion: nil)
            
        }
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .white
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
}
