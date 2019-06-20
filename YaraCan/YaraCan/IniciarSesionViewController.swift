//
//  ViewController.swift
//  YaraCan
//
//  Created by Fernando Huarcaya Torres on 6/11/19.
//  Copyright © 2019 Fernando Huarcaya Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class IniciarSesionViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActInd.stopAnimating()
        ActInd.hidesWhenStopped = true
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        print("clic ingresar")
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in print("Intentando Iniciar Sesión")
                    if error != nil{
                        print("Se presentó el siguiente error: \(error)")
                        let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario \(self.emailTextField.text!) no esta registrado. Por favor Registrese.", preferredStyle: .alert)
        
                        let btnCancel = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
                        alerta.addAction(btnCancel)
                        self.present(alerta, animated: true, completion: nil)
                        print("usuario incorrecto")
                    }else{
                        print("Inicio de sesión exitoso")
                        self.performSegue(withIdentifier: "iniciarsesionSegue", sender: nil)
                    }
                }
    }
    
    

    
    @IBAction func crearUsuarioTapped(_ sender: Any) {
         ActInd.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (Timer) in
            print("cargando")
            self.performSegue(withIdentifier: "registroSegue", sender: nil)
        }
        
       
    }
    
}

