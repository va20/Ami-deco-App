//
//  Devis.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 21/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import Foundation


class elementDevis{
    
    /* Cette classe représente un élément du devis */
    
    
    
    var typePiece : String
    var surface : Double/* ici on prend hauteur , longueur, largeur et on applique la formule */
    var typeTravaux:String
    var prix: Double
    
    
    init(tp:String, surface:Double, tt:String, prix:Double){
        
        self.typePiece=tp
        self.surface=surface
        self.typeTravaux=tt
        self.prix=prix
        
    }
    
    
}
