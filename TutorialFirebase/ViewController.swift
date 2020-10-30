//
//  ViewController.swift
//  TutorialFirebase
//
//  Created by Alejandro Hernández López on 29/10/20.
//

import UIKit


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseManager.shared.listaTodos()
        
        DatabaseManager.shared.getUsuariosNuevos { (usuarios) in
            for i in usuarios {
                print(i.correo)
            }
        }
        // Do any additional setup after loading the view.
    }


}

