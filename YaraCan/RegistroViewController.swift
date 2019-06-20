//
//  RegistroViewController.swift
//  YaraCan
//
//  Created by Fernando Huarcaya Torres on 6/15/19.
//  Copyright © 2019 Fernando Huarcaya Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistroViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contraseña: UITextField!
    
    @IBOutlet weak var nameFulllbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registrarTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.email.text!, password: self.contraseña.text!, completion: {(user,error) in
            print("intentando crear usuario")
            if(error != nil){
                print("Se presento el siguiente error al crear el usuario: \(error)")
            }else{
                print("El usuario fue creado exitosamente")
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                Database.database().reference().child("usuarios").child(user!.user.uid).child("nameFull").setValue(self.nameFulllbl.text)
                
                let alerta = UIAlertController(title: "GAAAAAAAAAA", message: "Usuario \(self.email!.text!) se creo correctament", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: {(UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                })
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }
            
        })
    }
    
    @IBAction func cancelarTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func mostrarAlerta(titulo: String,mensaje: String, accion:String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnCANCELOK = UIAlertAction(title: accion, style: .default, handler: nil)
        alerta.addAction(btnCANCELOK)
        present(alerta,animated: true,completion: nil)
    }
    

}
