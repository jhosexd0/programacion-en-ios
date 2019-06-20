//
//  AdopcionViewController.swift
//  YaraCan
//
//  Created by MAC17 on 19/06/19.
//  Copyright © 2019 Fernando Huarcaya Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AdopcionViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var namePet: UITextField!
    
    @IBOutlet weak var razalbl: UITextField!
    @IBOutlet weak var sexolbl: UITextField!
    
    @IBOutlet weak var descripcionlbl:
    UITextField!
    
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func publicarHandler(_ sender: Any) {
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(imagenID).jpg")
        cargarImagen.putData(imagenData!,metadata: nil){(metadata,error) in
            if error != nil{
                self.mostrarAlerta(titulo: "error", mensaje: "Se produjo un error al subir la imagen. Verifique su conexion de internet y vuelva a intentarlo", accion: "Aceptar")
                
                print("Ocurrio un error al subir imagen: \(error)")
                return
            }else{
                cargarImagen.downloadURL(completion: {(url, error) in
                    guard let enlaceURL = url else{
                        self.mostrarAlerta(titulo: "error", mensaje: "Se produjo un error al obtener informacion de la imagen", accion: "Cancelar")
                        
                        print("Ocurrio un error al obtener informacion de imagen \(error)")
                        return
                    }
                    //self.performSegue(withIdentifier: "algoPro", sender: url?.absoluteString)
                    let snap = ["namePet": self.namePet.text, "sexo": self.sexolbl.text,"raza": self.razalbl.text,"descripcion":self.descripcionlbl.text, "imagenURL":url?.absoluteString,"userID":Auth.auth().currentUser?.uid] as [String : Any]
                    let alerta = UIAlertController(title: "Creacion de publicacion", message: "La mascota se creo correctamente ", preferredStyle: .alert)
                    let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: {(UIAlertAction) in
                        
                    })
                    alerta.addAction(btnOK)
                    self.present(alerta, animated: true, completion: nil)
                    Database.database().reference().child("pets").childByAutoId().setValue(snap)
                })
                
                
            }
            print("------------ \(cargarImagen)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cargarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        // elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func mostrarAlerta(titulo: String,mensaje: String, accion:String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnCANCELOK = UIAlertAction(title: accion, style: .default, handler: nil)
        alerta.addAction(btnCANCELOK)
        present(alerta,animated: true,completion: nil)
    }
}
