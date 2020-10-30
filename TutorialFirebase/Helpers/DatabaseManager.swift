//
//  Databasemanager.swift
//  TutorialFirebase
//
//  Created by Alejandro Hernández López on 29/10/20.
//

import Foundation
import Firebase

class DatabaseManager {
    init() {
        
    }
    
    let firestore = Firestore.firestore()
    let decoder = JSONDecoder()
    
    static let shared = DatabaseManager()
    
    func getUsuarios(completion : @escaping([Usuario])-> Void){
        firestore.collection("usuarios").getDocuments { (snapshot, error) in
            if(error == nil){
                var usuarios : [Usuario] = []
                
                for document in snapshot?.documents ?? [] {
                    var dic = document.data()
                    guard let data = try? JSONSerialization.data(withJSONObject: dic, options: []) else {return}
                    let usuario = try? self.decoder.decode(Usuario.self, from: data)
                    usuarios.append(usuario ?? Usuario())
                }
                completion(usuarios)
            }else{
                completion([])
            }
        }
    }
    
    func getUsuariosNuevos(completion : @escaping([Usuario])-> Void){
        firestore.collection("usuarios").whereField("nuevo", isEqualTo: true).getDocuments { (snapshot, error) in
            if(error == nil){
                var usuarios : [Usuario] = []
                
                for document in snapshot?.documents ?? [] {
                    var dic = document.data()
                    guard let data = try? JSONSerialization.data(withJSONObject: dic, options: []) else {return}
                    let usuario = try? self.decoder.decode(Usuario.self, from: data)
                    usuarios.append(usuario ?? Usuario())
                }
                completion(usuarios)
            }else{
                completion([])
            }
        }
    }
    
    func createUsuario(nombre : String, correo : String, edad : Int){
        firestore.collection("usuarios").addDocument(data: ["nombre" : nombre, "correo" : correo, "edad" : edad, "nuevo" : true])
    }
    
    
    func cambiarEdad(id : String, edad : Int){
        firestore.collection("usuarios").document(id).updateData(["edad" : edad])
    }
    
    func eliminarUsuario(id : String){
        firestore.collection("usuarios").document(id).delete()
    }
    
    

    func listaTodos(){
        firestore.collection("usuarios").document("dgsYNiUUFAQyAzcsNzmR").collection("todos").getDocuments { (snapshot, error) in
            if(error == nil){
                for doc in snapshot?.documents ?? [] {
                    guard let nombreString = doc.data()["nombre"] as? String else {return}
                    print(nombreString)
                }
            }
        }
    }
    
}
