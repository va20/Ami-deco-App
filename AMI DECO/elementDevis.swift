
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
    var hauteurTravauxSupp: Double?
    var largeurTravauxSupp: Double?
    var typeTravauxSupp: String?
    var prixTravauxSupp: Double?
    var murType:String
    
    init(){
        
        self.typePiece=""
        self.surface=0.0
        self.typeTravaux=""
        self.prix=0.0
        self.murType=""
    }
    
    
    
    init(tp:String, surface:Double, tt:String, prix:Double,murType:String){
        
        self.typePiece=tp
        self.surface=surface
        self.typeTravaux=tt
        self.prix=prix
        self.murType=murType
    }
    
    /*  init(tp:String, surface:Double, tt:String, prix:Double, htps:Double,ltps:Double,tts:String,pts:Double,mt:String){
     
     
     self.typePiece=tp
     self.surface=surface
     self.typeTravaux=tt
     self.prix=prix
     self.hauteurTravauxSupp=htps
     self.largeurTravauxSupp=ltps
     self.typeTravauxSupp=tts
     self.prixTravauxSupp=pts
     self.murType=mt
     
     
     }*/
    
    
}
