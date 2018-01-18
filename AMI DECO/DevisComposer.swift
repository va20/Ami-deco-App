//
//  DevisComposer.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 29/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class DevisComposer: NSObject {
    
    let pathToDevisHTMLTemplate = Bundle.main.path(forResource: "Devis", ofType: "html",inDirectory:"pdf")
    
    let pathToSingleItemHTMLTemplate = Bundle.main.path(forResource: "ElementDevis", ofType: "html",inDirectory:"pdf")
    
    
    let pathToLastItemHTMLTemplate = Bundle.main.path(forResource: "Last", ofType: "html",inDirectory:"pdf")
    
    let senderInfo = "Ahmed Abdellatif <br>72 rue de Rome <br>75008 PARIS<br>France <br> AMI DECO </br>"
    
    
    let logoImageURL = Bundle.main.path(forResource: "logo", ofType: "png",inDirectory:"pdf")
    
    var DevisName=" "
    /*Nom du client à récuperer ici */
    let recipientInfo=" "
    
    var pdfFilename: String!
    
    var totalPrice=0.0
    var totalPriceS: String!
    
    override init() {
        super.init()
    }
    
    
    func renderDevis(devisElement: [elementDevis]!)->String! {
        for i in 0..<devisElement.count{
            totalPrice = totalPrice+devisElement[i].prix
        }
        totalPriceS=String(format:"%f",totalPrice);
        
        
        do {
            // The invoice items will be added by using a loop.
            var allItems = ""
            
            
            // Load the invoice HTML template code into a String variable.
            print("^^^^^^^^")
            print(pathToDevisHTMLTemplate)
            var HTMLContent = try String(contentsOfFile: pathToDevisHTMLTemplate!)
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#LOGO_IMAGE#", with: logoImageURL!)
            
            
            
            
            // Invoice date.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#DEVIS_DATE#", with: formatAndGetCurrentDate())
            
            
            
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#SENDER_INFO#", with: senderInfo)
            
            
            // Recipient info.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#RECIPIENT_INFO#", with: recipientInfo.replacingOccurrences(of:"\n", with: "<br>"))
            
            // Total amount.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TOTAL#", with:totalPriceS)
            
            
            
            // For all the items except for the last one we'll use the "single_item.html" template.
            // For the last one we'll use the "last_item.html" template.
            for i in 0..<devisElement.count {
                var itemHTMLContent: String!
                print("--------------------------")
                print(pathToSingleItemHTMLTemplate)
                print(pathToLastItemHTMLTemplate)
                print(pathToDevisHTMLTemplate!)
                
                
                // Determine the proper template file.
                if i != devisElement.count - 1 {
                    itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
                    
                    
                }
                else {
                    itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
                    
                    
                }
                
                // Replace the description and price placeholders with the actual values.
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#ITEM_DESC#", with: devisElement[i].typeTravaux+" "+devisElement[i].murType)
                
                // Format each item's price as a currency value.
                var b:String = String(format:"%f", devisElement[i].prix)
                
                let formattedPrice = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(value:b)
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#PRICE#", with: formattedPrice)
                
                // Add the item's HTML code to the general items string.
                allItems += itemHTMLContent
            }
            
            // Set the items.
            HTMLContent = HTMLContent.replacingOccurrences(of:"#ITEMS#", with: allItems)
            
            // The HTML code is ready.
            return HTMLContent
            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
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
    
    func makeFirebaseString(_ email: String) -> String{
        let arrCharacterToReplace = [".","#","$","[","]"]
        var finalString = email
        
        for character in arrCharacterToReplace{
            finalString = finalString.replacingOccurrences(of: character, with: ",")
        }
        
        return finalString
    }
    
    func formatAndGetCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        return dateFormatter.string(from: NSDate() as Date)
    }
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        print(Myindex)
        if(Myindex == -1){
            print("il me faut le mail")
        }
        else if(Myindex != -1){
            let user_tmp = users[Myindex]
            let file_string_alea = self.randomString(10)
            DevisName = "Devis_"+user_tmp.nom!+"_"+user_tmp.prenom!+"_"+file_string_alea+".pdf"
        
        
            pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Devis\(DevisName).pdf"
            pdfData?.write(toFile: pdfFilename, atomically: true)
        
            let fileRef = Storage.storage().reference().child("Devis/\(user_tmp.email!)/"+DevisName)
        
        
            //uploader le fichier au images/randomString
            _ = fileRef.putData(pdfData! as Data, metadata: nil) { (metadata,error) in
                guard let metadata = metadata else {
                    return
                }
                //metadata contient des informations sur le fichier uploader
                let downloadURL = metadata.downloadURL()
            
                //mise a jour l'url dans la base de donnée
                if(Auth.auth().currentUser?.email == "ami.deco2@gmail.com"){
                    let child_user = self.makeFirebaseString(user_tmp.email!)
                    print("child ami DECOO:"+child_user)
                    let key_user = DatabaseServices.shared.devisRef.child(child_user).childByAutoId().key
                    let file_user = ["url": downloadURL?.absoluteString,
                                  "nom":    file_string_alea]
                    let childUpdate_user = ["/\(key_user)":file_user]
                    DatabaseServices.shared.devisRef.child(child_user).updateChildValues(childUpdate_user)
                }
            }
        }
        print(pdfFilename)
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        for i in 0..<printPageRenderer.numberOfPages {
            UIGraphicsBeginPDFPage()
            printPageRenderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext()
        
        return data
    }
    
}




