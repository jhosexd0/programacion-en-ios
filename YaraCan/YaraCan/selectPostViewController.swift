//
//  selectPostViewController.swift
//  YaraCan
//
//  Created by MAC17 on 19/06/19.
//  Copyright © 2019 Fernando Huarcaya Torres. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseAuth

class selectPostViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    

    @IBAction func btnRegresar(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comentarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let coment = comentarios[indexPath.row]
        cell.textLabel?.text = coment.Comentario
        cell.detailTextLabel?.text = coment.from
//        cell.imageView?.sd_setImage(with: URL(string: usuario.photoURL), completed: nil)
        return cell
    }
    
    
    
var user:[User] = []
    var snap = Publicaciones()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblpetname: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblraza: UILabel!
    @IBOutlet weak var lblsex: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    
    @IBOutlet weak var txtComentarios: UITextField!
    @IBOutlet weak var tablaComentarios: UITableView!
    
    @IBAction func btnEnviar(_ sender: Any) {
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)

        let mensaje = ["from": Auth.auth().currentUser?.email, "Comentario": txtComentarios.text,"Dia": result, "Hora": "\(hour):\(minutes):\(seconds)","Publicacion":snap.id,"userID":Auth.auth().currentUser?.uid] as [String : Any]
        Database.database().reference().child("comentarios").childByAutoId().setValue(mensaje)
        txtComentarios.text? = ""
    }
    var publicaciones:[Publicaciones] = []
    var comentarios:[Comentarios] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tablaComentarios.delegate = self
        tablaComentarios.dataSource = self
        self.imageView.sd_setImage(with: URL(string: snap.urlImagen), completed: nil)
        self.lblDescripcion.text = snap.petname
        self.lblpetname.text = snap.petname
        self.lblraza.text = snap.raza
        self.lblsex.text = snap.sexo
Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot) in
            let snap2 = User()
            snap2.emal = (snapshot.value as! NSDictionary)["email"] as! String
            snap2.nameFull = (snapshot.value as! NSDictionary)["nameFull"] as! String
    snap2.id = snapshot.key
    if(snap2.id == self.snap.userID){
        self.lblusername.text = snap2.nameFull
        print(snap2.nameFull)
        return
    }
        })

        
//        Cargando comentarios
        Database.database().reference().child("comentarios").observe(DataEventType.childAdded,with :{(snapshot) in
            print(snapshot)
            
            let coment = Comentarios()
            coment.Comentario = (snapshot.value as! NSDictionary)["Comentario"] as! String
            coment.from = (snapshot.value as! NSDictionary)["from"] as! String
            coment.Publicacion = (snapshot.value as! NSDictionary)["Publicacion"] as! String

            if(coment.Publicacion == self.snap.id){
                self.comentarios.append(coment)
                self.tablaComentarios.reloadData()
            }
            
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
