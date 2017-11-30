//
//  DatabaseServices.swift
//  AMIDECO
//
//  Created by saif on 21/10/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseServices{
    
    static let shared = DatabaseServices()
    private init(){}
    
    let usersRef = Database.database().reference().child("users")
    let travauxRef = Database.database().reference().child("travaux")
    let accomptRef = Database.database().reference().child("accompt")
    let factureRef = Database.database().reference().child("facture")
    let photoRef = Database.database().reference().child("photo")
}
