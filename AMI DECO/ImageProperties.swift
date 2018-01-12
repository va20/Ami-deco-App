//
//  ImageProperties.swift
//  AMIDECO
//
//  Created by saif on 30/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct ImageProperties{
    let key:String!
    var url:String!
    let nom:String!
    let itemref:DatabaseReference!
    
    init(url:String,key:String,nom:String){
        self.key=key
        self.url=url
        self.nom=nom
        self.itemref=nil
    }
    
    init(snapshot:DataSnapshot){
        key=snapshot.key
        itemref=snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        if let imageUrl = snapshotValue?["url"] as? String {
            url = imageUrl
        }
        if let nomImage = snapshotValue?["nom"] as? String {
            nom=nomImage
        }
        else{
            url = ""
            nom = ""
        }
        
    }
    
    
}
