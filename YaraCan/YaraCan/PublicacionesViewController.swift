//
//  PublicacionesViewController.swift
//  YaraCan
//
//  Created by MAC17 on 18/06/19.
//  Copyright © 2019 Fernando Huarcaya Torres. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class PublicacionesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publicaciones.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! publicViewCell
                let notifi = self.publicaciones[indexPath.row]
                    cell.name.text = notifi.petname
                    cell.descripcion.text = notifi.descripcion
                    cell.imagenPet?.sd_setImage(with: URL(string: notifi.urlImagen), completed: nil)
                return cell

    }

    var publicaciones:[Publicaciones] = []

    @IBOutlet weak var tablaPublicaciones: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablaPublicaciones.delegate = self
        tablaPublicaciones.dataSource = self
        
        Database.database().reference().child("pets")
            .observe(DataEventType.childAdded, with: {(snapshot) in
                let notic = Publicaciones()
                notic.petname = (snapshot.value as! NSDictionary)["namePet"] as! String
                notic.descripcion = (snapshot.value as! NSDictionary)["descripcion"] as! String
                notic.raza = (snapshot.value as! NSDictionary)["raza"] as! String
                notic.sexo = (snapshot.value as! NSDictionary)["sexo"] as! String
                notic.id = snapshot.key
                notic.urlImagen = (snapshot.value as! NSDictionary)["imagenURL"] as! String
                notic.userID = (snapshot.value as! NSDictionary)["userID"] as! String
                self.publicaciones.append(notic)
                self.tablaPublicaciones.reloadData()
                print(notic.id)
                
            })
        }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = publicaciones[indexPath.row]
        print(snap.id)
        performSegue(withIdentifier: "funcionaplis", sender: snap)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "funcionaplis" {
            let siguienteVC = segue.destination as! selectPostViewController
            siguienteVC.snap = sender as! Publicaciones
        }
    }

}
