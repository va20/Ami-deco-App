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

class PhotoController: UIViewController, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var customFlowImageLayout: CollectionViewFlowLayout!
    var images = [ImageProperties]()
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            //les donnes dans la memoire
            var data = Data()
            data = UIImageJPEGRepresentation(pickedImage, 0.8)!
            
            //cree une reference vers le fichier qu'on veut uploader
            
            let imageRef = Storage.storage().reference().child("images/" + randomString(20))
        
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
                print(Auth.auth().currentUser?.email!)
                let child = self.makeFirebaseString((Auth.auth().currentUser?.email!)!)
                print("child :"+child)
                let key = DatabaseServices.shared.usersRef.child(child).childByAutoId().key
                let image = ["url": downloadURL?.absoluteString]
                let childUpdate = ["/\(key)":image]
                DatabaseServices.shared.usersRef.child(child).updateChildValues(childUpdate)
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
        let child = self.makeFirebaseString((Auth.auth().currentUser?.email!)!)
        DatabaseServices.shared.usersRef.child(child).observe(DataEventType.value,with: { (snapshot) in
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
        
        cell.imageView.sd_setImage(with: URL(string: image.url), placeholderImage: UIImage(named: "image"))
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
}
