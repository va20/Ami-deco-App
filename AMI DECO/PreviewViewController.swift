//
//  PreviewViewController.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 29/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import MessageUI



class PreviewViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    
    @IBOutlet weak var nom: UITextField!
    
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var webPreview: UIWebView!
    
    @IBOutlet weak var ville: UITextField!
    @IBOutlet weak var codep: UITextField!
    @IBOutlet weak var voie: UITextField!
    @IBOutlet weak var email: UITextField!
    var devisComposer: DevisComposer!
    
    var devisInfo:[elementDevis] = []
    
    
    var HTMLContent: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Myindex == -1){
            self.nom.isEnabled = false
            self.prenom.isEnabled = false
            self.email.isEnabled = false
            self.voie.isEnabled = false
            self.codep.isEnabled = false
            self.ville.isEnabled = false
        }
        else{
            self.nom.isEnabled = true
            self.prenom.isEnabled = true
            self.email.isEnabled = true
            self.voie.isEnabled = true
            self.codep.isEnabled = true
            self.ville.isEnabled = true
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /*   func createDevisAsHTML() {
     
     devisComposer = DevisComposer()
     if let devisHTML = devisComposer.renderDevis(devisElement: devisInfo ) {
     
     webPreview.loadHTMLString(devisHTML, baseURL: NSURL(string: devisComposer.pathToDevisHTMLTemplate!)! as URL)
     HTMLContent = devisHTML
     }
     }
     */
    
    
    
    
    @IBAction func exportPdf(_ sender: Any) {
        if(Myindex != -1){
            devisComposer = DevisComposer()
            let devisHTML = devisComposer.renderDevis(devisElement: devisInfo )
            HTMLContent = devisHTML
            devisComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
            showOptionsAlert()
        }
        else if (Myindex == -1){
            guard let nom_client = nom.text,
                nom_client != "",
                let prenom_client = prenom.text,
                prenom_client != "",
                let email_client = email.text,
                email_client != "",
                let voie_client = voie.text,
                voie_client != "",
                let codep_client = codep.text,
                codep_client != "",
                let ville_client = ville.text,
                ville_client != ""
                else{
                    AlerteController.showAlert(self, title: "Manque info",message: "Veuillez remplir tous les champs s'il vous plaît")
                    return
            }
            devisComposer = DevisComposer()
            let devisHTML = devisComposer.renderDevis(devisElement: devisInfo )
            HTMLContent = devisHTML
            devisComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
            showOptionsAlert()
        }
        
    }
    
    func showOptionsAlert() {
        let alertController = UIAlertController(title: "Devis terminé ", message: "Votre devis à été crée.\n\n Que voulez-vous faire?", preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        let actionEmail = UIAlertAction(title: "Envoi par Email", style: UIAlertActionStyle.default) { (action) in
            DispatchQueue.main.async {
                self.sendEmail()
            }
        }
        
        let actionNothing = UIAlertAction(title: "Rien", style: UIAlertActionStyle.default) { (action) in
            
        }
        
        alertController.addAction(actionEmail)
        alertController.addAction(actionNothing)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func sendEmail() {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            // Configure the fields of the interface.
            
            mailComposeViewController.setSubject("Invoice")
            mailComposeViewController.addAttachmentData(NSData(contentsOfFile: devisComposer.pdfFilename)! as Data, mimeType: "application/pdf", fileName: "Devis")
            present(mailComposeViewController, animated: true, completion: nil)
        }
    }
}


