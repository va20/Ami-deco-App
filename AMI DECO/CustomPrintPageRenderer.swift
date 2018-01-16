//
//  CustomPrintPageRenderer.swift
//  AMIDECO
//
//  Created by Adonis El Khoury  on 02/12/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class CustomPrintPageRenderer: UIPrintPageRenderer{
    
    let A4PageWidth: CGFloat = 595.2
    
    let A4PageHeight: CGFloat = 841.8
    
    override init() {
        super.init()
        
        // Specify the frame of the A4 page.
        let pageFrame = CGRect(x: 0.0, y: 0.0, width: A4PageWidth, height: A4PageHeight)
        
        // Set the page frame.
        self.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        
        // Set the horizontal and vertical insets (that's optional).
        self.setValue(NSValue(cgRect: pageFrame), forKey: "printableRect")
    }
    
    
}


