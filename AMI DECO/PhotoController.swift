//
//  ViewController.swift
//  AMIDECO
//
//  Created by saif on 29/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UICollectionViewDataSource{

    var images = [UIImage]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCharge()

        // Do any additional setup after loading the view.
    }

    public func imageCharge(){
        images.append(UIImage(named: "Google.G.")!)
        images.append(UIImage(named: "Google.G.")!)
        self.collectionView.reloadData()
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
        
        cell.imageView.image = image
        
        return cell
        
    }
    
    
}
