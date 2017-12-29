//
//  AlerteController.swift
//  AMIDECO
//
//  Created by saif on 22/10/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class AlerteController{
    static func showAlert(_ inViewController: UIViewController,title: String, message: String){
        let alert = UIAlertController(title:title,message:message,preferredStyle:.alert)
        let action = UIAlertAction(title:"ok",style:.default,handler:nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true,completion:nil)
    }
}


