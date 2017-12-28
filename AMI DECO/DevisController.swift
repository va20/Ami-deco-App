//
//  DevisController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 26/09/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit


class DevisController :UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate{
    
    
    /*Paramètres pour travaux basiques*/
    @IBOutlet weak var hauteur: UITextField!
    @IBOutlet weak var validation: UIButton!
    @IBOutlet weak var largeur: UITextField!
    @IBOutlet weak var longueur: UITextField!
    @IBOutlet weak var typeTravaux: UIPickerView!
    @IBOutlet weak var typePiece: UITextField!
    
    
    /*Paramètres pour travaux supplémentaires*/
    @IBOutlet weak var hauteurTravauxSup: UITextField!
    @IBOutlet weak var longueurTravauxSup: UITextField!
    @IBOutlet weak var typeTravauxSup: UITextField!
    @IBOutlet weak var prixTravauxSup: UITextField!
    
    /*Paramètres de stockage des infos seléctionnées */
    var h:Double = 0.0;
    var larg:Double = 0.0;
    var long:Double = 0.0;
    var choice:String = "T Placo neuf";
    var p:Double=0.0;
    var typeP:String="";
    var hts:Double=0.0;
    var lts:Double=0.0;
    var tts:Double=0.0;
    var pts:Double=0.0;
    var elements:[String] = [];
    var elementsFinaux:[String:Double] = [:];
    var elementsDevis:[String:String] = [:];
    var elem=elementDevis();
    var cpt=0;
    /* ArrayList qui sera notre devis ( une suite d'élements devis)*/
    var devis=[elementDevis]()
    
    
    
    
    /* Dictionnaire  contenant tout les  éléments du devis */
    
    /*  let surface=largeur+(longueur*2*hauteur)
     pour mètre linéaire=longueur*prix  -> corniche , pleinte
     un mur -> hauteur * longueur
     
     */
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        typeTravaux.dataSource = self
        typeTravaux.delegate = self
        hauteur.delegate=self;
        largeur.delegate=self;
        longueur.delegate=self;
        hauteurTravauxSup.delegate=self;
        longueurTravauxSup.delegate=self;
        prixTravauxSup.delegate=self;
        elements=["T Placo neuf","T Peinture anciens murs peu abimés","T Peinture anciens murs très abimés","T Peinture avec toile de verre à peindre","Stuk mur neuf","Stuk mur abimés","Arezzo simple mur neuf","Arezzo simple mur abimé","Arezzo effet beton mur neuf","Arezzo effet beton mur abimés","Peinture parpin ","Peinture des sols","Peinture sur taille ...","Protection et nettoyage","Pose bandes fourniture et pose","Parquet-Ponçage,deux couches vernis","Portes abimées","Portes neuves","Fenêtres abimées","Fenêtre neuves","Radiateur abimées","Radiateurs abimées","Radiateurs neufs","Peinture façade extèrieure"]
        
        elementsFinaux=["T Placo neuf":22.0,"T Peinture anciens murs peu abimés":23.0,"T Peinture anciens murs très abimés":40.0,"T Peinture avec toile de verre à peindre":22.0,"Stuk mur neuf":65.0,"Stuk mur abimés":90.0,"Arezzo simple mur neuf":60.0,"Arezzo simple murs abimés":85.0,"Arezzo effet beton mur neuf":53.0,"Arezzo effet beton mur abimés":78.0,"Peinture parpin":8.0,"Peinture des sols":27.0,"Peinture sur taille ...":10.0,"Protection et nettoyage":3.0,"Pose bandes fourniture et pose":6.0,"Parquet-Ponçage,deux couches vernis":30.0,"Portes abimées":130.0,"Portes neuves":70.0,"Fenêtres abimées":500.0,"Fenêtre neuves":130.0,"Radiateurs abimées":130.0,"Radiateurs neufs":75.0,"Peinture façade extèrieure":27.0]
        
        
        elementsDevis=["T Placo neuf":" Travaux sur placo neuf: Application d'une couche d'impression,Application de 2 couches d'enduit(Gros,Fin),Ponçage,Application d'une couche d'impression,Application de 2 couches de peinture acrylique","Travaux de peinture sur anciens murs peu abimés : ":"Lessivage,ouverture des fissures,Application d'une couche d'impression,Rebouchage à l'enduit plâtre et pose de bandes Calicot, Application d'une couche d'impression,Application de 2 couches de peinture acrylique","Travaux de peinture sur anciens murs trés abimés : ":"Lessivage,ouverture des fissures,Application d'une couche d'impression,Rebouchage à l'enduit plâtre et pose de toile de verre, Application d'une couche d'impression,Application de 2 couches d'enduit(gros,fin). Ponçage.Application d'une couche d'impression,Application de 2 couches de peinture acrylique","Travaux de peinture avec Toiles de Verre à peindre":"Lessivage,ouverture des fissures,Application d'une couche d'impression,Rebouchage à l'enduit plâtre et pose de toile de verre, Application d'une couche d'impression,Application de 2 couches de peinture acrylique"]
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return elements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choice=elements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return elements.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Montserrat", size: 3)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = elements[row]
        pickerLabel?.textColor = UIColor.blue
        
        return pickerLabel!
    }
    
    @IBAction func valider(_ sender: UIButton) {
        if((hauteur.text?.isEmpty)! || (largeur.text?.isEmpty)! || (longueur.text?.isEmpty)! ||  (typePiece.text?.isEmpty)! || (choice.isEmpty)){
            AlerteController.showAlert(self, title: "Information", message: "Il manque des informations")
            return
        }
        h=Double (hauteur.text!)!;
        larg=Double (largeur.text!)!;
        long=Double (longueur.text!)!;
        var surf=((larg+long)*2*h)+(larg*long);
        p=elementsFinaux[choice]!;
        print(p)
        var price=(surf*p);
        var priceF:String=String(format:"%f",price);
        
        
        if(!((hauteurTravauxSup.text?.isEmpty)!) && !((longueurTravauxSup.text?.isEmpty)!) && !((typeTravauxSup.text?.isEmpty)!) && !((prixTravauxSup.text?.isEmpty)!)){
            elem=elementDevis(tp: typePiece.text!, surface: surf, tt: choice, prix: price, htps:Double(hauteurTravauxSup.text!)! , ltps: Double(longueurTravauxSup.text!)! , tts: typeTravauxSup.text!, pts: Double(prixTravauxSup.text!)!)
        }
        else{
            elem=elementDevis(tp: typePiece.text!, surface: surf, tt: elementsDevis[choice]!, prix: price)
        }
        
        devis.append(elem)
        
        AlerteController.showAlert(self, title: "Pièce enregistrée: prix="+priceF,message:"Passez à la pièce suivante");
        hauteur.text="";
        largeur.text="";
        longueur.text="";
        typePiece.text="";
        print(cpt)
        cpt+=1;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showHtml" {
                let previewViewController = segue.destination as! PreviewViewController
                previewViewController.devisInfo = devis
            }
        }
    }
}





