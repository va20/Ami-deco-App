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
    
    @IBOutlet weak var longueur: UITextField!
    @IBOutlet weak var largeur: UITextField!
    @IBOutlet weak var typePiece: UITextField!
    
    @IBOutlet weak var typeTravauxPiece: UIPickerView!
    
    @IBOutlet weak var typeTravauxMur: UIPickerView!
    
    /*Paramètres pour travaux supplémentaires*/
    
    @IBOutlet weak var largeurTravauxSup: UITextField!
    @IBOutlet weak var hauteurTravauxSup: UITextField!
    
    @IBOutlet weak var validation: UIButton!
    @IBOutlet weak var suivant: UIButton!
    @IBOutlet weak var prixTravauxSup: UITextField!
    @IBOutlet weak var typeTravauxSup: UITextField!
    @IBOutlet weak var longueurTravauxSup: UITextField!
    /*Paramètres de stockage des infos seléctionnées */
    var h:Double = 0.0;
    var larg:Double = 0.0;
    var long:Double = 0.0;
    var choice:String = "T Placo neuf";
    var choice2:String = "Plafond peu abimé";
    var schoice:Double=0.0;
    var mchoice:Double=0.0;
    
    
    
    var typeP:String="";
    var hts:Double=0.0;
    var lts:Double=0.0;
    var tts:Double=0.0;
    var pts:Double=0.0;
    var elements:[String] = [];
    var Murs:[String] = [];
    var mursFinaux:[String:Double] = [:];
    var elementsFinaux:[String:Double] = [:];
    var elementsDevis:[String:String] = [:];
    var MurDevis:[String:String] = [:];
    
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
        typeTravauxPiece.delegate=self
        typeTravauxMur.delegate=self
        
        /* typeTravaux.dataSource = self
         typeTravaux.delegate = self
         hauteur.delegate=self;
         largeur.delegate=self;
         longueur.delegate=self;
         hauteurTravauxSup.delegate=self;
         longueurTravauxSup.delegate=self;
         prixTravauxSup.delegate=self;*/
        
        elements=["T Placo neuf","T Peinture anciens murs peu abimés","T Peinture anciens murs très abimés","T Peinture avec toile de verre à peindre","Stuk mur neuf","Stuk mur abimé","Arezzo simple mur neuf","Arezzo simple mur abimé","Arezzo effet beton mur neuf","Arezzo effet beton mur abimé","Peinture parpin ","Peinture des sols","Peinture sur taille ...","Protection et nettoyage","Pose bandes fourniture","Parquet-Ponçage,deux couches vernis","Portes abimées","Portes neuves","Fenêtres abimées","Fenêtre neuves","Rad p abimé","Rad p neuf","Rad m abimé","Rad m neuf","Rad g abimé","Rad g neuf","Peinture façade extèrieure","Corniche neuve","Corniche ancienne","P placo mate","P placo satain","P plinthe neuve","P plinthe ancienne","Toile verre P placo neuf","Toile verre P mur ancien","Tv enduit + p murs plafonds anciens","Ponçage parket + vernis","Pose moquette sans f","Rafrayage sur sale","Rafrayage F"]
        
        Murs=["Plafond peu abimé","Plafond très abimé","Plafond propre"]
        
        elementsFinaux=["T Placo neuf":22.0,"T Peinture anciens murs peu abimés":23.0,"T Peinture anciens murs très abimés":40.0,"T Peinture avec toile de verre à peindre":22.0,"Stuk mur neuf":65.0,"Stuk mur abimé":90.0,"Arezzo simple mur neuf":60.0,"Arezzo simple mur abimé":85.0,"Arezzo effet beton mur neuf":53.0,"Arezzo effet beton mur abimé":78.0,"Peinture parpin":8.0,"Peinture des sols":27.0,"Peinture sur tv dp":10.0,"Protection et nettoyage":3.0,"Pose bandes fourniture et pose":6.0,"Parquet-Ponçage,deux couches vernis":30.0,"Portes abimées":130.0,"Portes neuves":70.0,"Fenêtres abimées":500.0,"Fenêtre neuves":130.0,"Rad p abimé":130.0,"Rad p neuf":75.0,"Rad m abimé ":130.0,"Rad m neuf":75.0,"Rad g abimé":130.0,"Rad g neuf":75.0,"Peinture façade extèrieure":27.0,"Corniche neuve":17.0,"Corniche ancienne":28,"P placo mate":17,"P placo satain":19,"P plinthe neuve":8.0,"P plinthe ancienne":14.0,"Toile verre P placo neuf":19.0,"Toile verre P mur ancien":24.0,"Tv enduit + p murs plafonds anciens":42.0,"Ponçage parket + vernis":28.0,"Pose moquette sans f":9.0,"Rafrayage sur sale":13.0,"Rafrayage F":15.0,]
        
        
        mursFinaux=["Plafond peu abimé":30.0,"Plafond très abimé":45.0,"Plafond propre":27.0]
        
        elementsDevis=["T Placo neuf":" Travaux sur placo neuf: Application d'une couche d'impression,Application de 2 couches d'enduit(Gros,Fin),Ponçage,Application d'une couche d'impression,Application de 2 couches de peinture acrylique","T Peinture anciens murs peu abimés":" Travaux de peinture sur anciens murs peu abimés : Lessivage,ouverture des fissures,Application d'une couche d'impression,Rebouchage à l'enduit plâtre et pose de bandes Calicot, Application d'une couche d'impression,Application de 2 couches de peinture acrylique","T Peinture anciens murs très abimés":"Travaux de peinture sur anciens murs trés abimés : Lessivage,ouverture des fissures,Application d'une couche d'impression,Rebouchage à l'enduit plâtre et pose de toile de verre, Application d'une couche d'impression,Application de 2 couches d'enduit(gros,fin). Ponçage.Application d'une couche d'impression,Application de 2 couches de peinture acrylique","T Peinture avec toile de verre à peindre":"Travaux de peinture avec Toiles de Verre à peindre :Lessivage,ouverture des fissures,Application d'une couche d'impression,Rebouchage à l'enduit plâtre et pose de toile de verre, Application d'une couche d'impression,Application de 2 couches de peinture acrylique", "Stuk mur neuf":" Stuk mur neuf","Stuk mur abimé":"Stuk mur abimé","Arrezo Simple mur neuf":"Arrezo simple sur mur neuf","Arrezo simple mur abimé":"Arrezo simple sur mur abimé","Arrezo effet beton mur neuf":"Arrezo effet beton sur mur neuf","Arrezo effet beton mur abimé":"Arrezo Effet Beton sur ùur abimé","Peinture parpin":" Peinture sur parpin: 2 couches de peinture blanche","Peinture des sols":"Peinture des sols ","Peinture sur tv dp":"Peinture sur toile de verre deja posée","Protection et nettoyage":" Protection et nettoyage","Pose bandes fourniture":"Pose bandes fourniture ","Parquet-Ponçage,deux couches vernis":" Parquet et Ponçage , 2 couches vernis","Portes abimées":"Portes abimées ","Portes neuves":"Portes neuves ","Fenêtres abimées":"Fenêtres abimées ","Fenêtres neuves":"Fenêtres neuves ","Rad p neuf":"Radiateur petit neuf ","Rad p abimé":" Radiateur petit abimé","Rad m neuf":"Radiateur moyen neuf ","Rad m abimé":"Radiateur moyen abimé ","Rad g neuf":" Radiateur grand neuf","Rad g abimé":"Radiateur grand abimé ","Peinture façade extèrieure":"Peinture sur façade extèrieure: Carcher, Ouvertures fissures, Impression, Rebouchage, 2 couches de peintures","Corniche neuve":"Corniche neuve","Corniche ancienne":"Corniche ancienne","P placo mate":"Peinture sur placo neuf mate: 1 couche enduit gros, 1 couche enduit fin, Ponçage, 1 couche d'impression,2 couches peinture mate","P placo satain":"Peinture sur placo satiné: 1 couche enduit gros, 1 couche enduit fin, Ponçage,1 couche impression, 2 couches peinture satinée","P plinthe neuve":"Peinture sur plinthe neuve","P plinthe ancienne":"Peinture sur plinthe ancienne","Toile verre P placo neuf":"Toile de verre à peindre sur placo neuf: 1 couche enduit gros, 1 couche enduit fin, Ponçage, 1 couche d'impression, Pose toile de verre à peindre, 2 couches de peinture au choix","Toile verre P mur ancien":"Toile de verre à peindre sur mur ancien","Tv enduit + p murs plafonds anciens":"Toile de verre ennduit et peinture sur murs et plafonds anciens","Ponçage parket + vernis":"Ponçage parquet et vernis","Pose moquette sans f":"Pose moquette sans f","Rafrayage sur sale":"Rafrayage sur sale","Rafrayage F":"Rafrayage f"]
        
        MurDevis=["Plafond peu abimé":"Plafond peu abimé :Ouverture de fissure, impression, bande calicot,ponçage,2 couches peinture mate","Plafond très abimé":"Plafond très abimé :Travaux toile de verre à enduire, Ouverture de fissure, impression, colle pour carro, pose de toile de verre, 2 couches enduit gros, 1 couche enduit fin,impression et 2 couches de peinture","Plafond propre":"Plafond propre: Impression et 2 couches de peinture"]
        
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
        
        if(pickerView==typeTravauxPiece){
            return elements[row]
            
        }
        if(pickerView==typeTravauxMur){
            return Murs[row]
        }
        return " "
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView==typeTravauxPiece){
            choice=elements[row]
            
        }
        if(pickerView==typeTravauxMur){
            choice2=Murs[row]
            print("*****")
            print(choice2)
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView==typeTravauxPiece){
            return elements.count
            
        }
        if(pickerView==typeTravauxMur){
            return Murs.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if(pickerView==typeTravauxPiece){
            
            
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "Montserrat", size: 3)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = elements[row]
            pickerLabel?.textColor = UIColor.blue
            
            return pickerLabel!
        }
        if(pickerView==typeTravauxMur){
            var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "Montserrat", size: 3)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = Murs[row]
            pickerLabel?.textColor = UIColor.blue
            
            return pickerLabel!
        }
        return pickerLabel!
        
    }
    @IBAction func next(_ sender: Any) {
        if((hauteur.text?.isEmpty)! || (largeur.text?.isEmpty)! || (longueur.text?.isEmpty)! ||  (typePiece.text?.isEmpty)! || (choice.isEmpty)){
            AlerteController.showAlert(self, title: "Information", message: "Il manque des informations")
            return
        }
        h=Double (hauteur.text!)!;
        larg=Double (largeur.text!)!;
        long=Double (longueur.text!)!;
        var mur=(larg*long);
        var surf=((larg+long)*2*h);
        schoice=elementsFinaux[choice]!;
        mchoice=mursFinaux[choice2]!;
        print("----------")
        print(mchoice)
        var price=(surf*schoice)+(mur*mchoice);
        var priceF:String=String(format:"%f",price);
        
        
        if(!((hauteurTravauxSup.text?.isEmpty)!) && !((longueurTravauxSup.text?.isEmpty)!) && !((typeTravauxSup.text?.isEmpty)!) && !((prixTravauxSup.text?.isEmpty)!)){
            
            elem=elementDevis(tp: typePiece.text!, surface: surf, tt:typeTravauxSup.text!, prix: Double(prixTravauxSup.text!)!,murType:choice2)
            
            
            /* elem=elementDevis(tp: typePiece.text!, surface: surf, tt: choice, prix: price, htps:Double(hauteurTravauxSup.text!)! , ltps: Double(longueurTravauxSup.text!)! , tts: typeTravauxSup.text!, pts: Double(prixTravauxSup.text!)!,mt:choice2)*/
        }
        else{
            elem=elementDevis(tp: typePiece.text!, surface: surf, tt: elementsDevis[choice]!, prix: price,murType:MurDevis[choice2]!)
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
        /*let alertController = UIAlertController(title: "Devis validé ", message: "Etes-vous sur de vouloir valider ? Toute validation est définitive.\n\n Que voulez-vous faire?", preferredStyle: UIAlertControllerStyle.alert)
         
         
         let actionNothing = UIAlertAction(title: "Continuer devis", style: UIAlertActionStyle.default) { (action) in
         }
         let actionValidation = UIAlertAction(title: "Valider et exporter pdf", style: UIAlertActionStyle.default) { (action) in
         DispatchQueue.main.async {
         */
        if let identifier = segue.identifier {
            if identifier == "showPdf" {
                let previewViewController = segue.destination as! PreviewViewController
                previewViewController.devisInfo = self.devis
                
            }
        }
    }
    
    /*   alertController.addAction(actionValidation)
     alertController.addAction(actionNothing)*/
    
    /*
     
     
     }*/
    
    
}





