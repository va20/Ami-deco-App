//
//  DevisComposer.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 29/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class DevisComposer: NSObject {
    
    let pathToDevisHTMLTemplate = Bundle.main.path(forResource: "Devis", ofType: "html",inDirectory:"www")
    
    let pathToSingleItemHTMLTemplate = Bundle.main.path(forResource: "ElementDevis", ofType: "html",inDirectory:"www")
    
    
    let pathToLastItemHTMLTemplate = Bundle.main.path(forResource: "Last", ofType: "html",inDirectory:"www")
    
    let senderInfo = "Ahmed Abdellatif <br>72 rue de Rome <br>75008 PARIS<br>France <br> AMI DECO </br>"
    
    
    let logoImageURL = Bundle.main.path(forResource: "logo", ofType: "png",inDirectory:"www")
    
    let DevisName=" "
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
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of:"#ITEM_DESC#", with: devisElement[i].typeTravaux)
                
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
        
        pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Devis\(DevisName).pdf"
        pdfData?.write(toFile: pdfFilename, atomically: true)
        
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




