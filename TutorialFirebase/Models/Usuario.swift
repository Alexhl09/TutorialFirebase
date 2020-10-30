//
//  Usuario.swift
//  TutorialFirebase
//
//  Created by Alejandro Hernández López on 29/10/20.
//

import Foundation

struct Usuario : Codable {
    var nombre : String = ""
    var correo : String = ""
    var edad : Int = 0
    var nuevo : Bool = false
}
