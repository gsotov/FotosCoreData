//
//  ImagenesTableViewController.swift
//  FotoCoreDatas
//
//  Created by Tecnova on 1/10/19.
//  Copyright © 2019 Gabriel Soto Valenzuela. All rights reserved.
//

import UIKit
import CoreData

class ImagenesTableViewController: UITableViewController {
    var imagenes : [Imagenes] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Imagenes> = Imagenes.fetchRequest()
        
        do {
            imagenes = try contexto.fetch(fetchRequest)
        } catch let error as NSError {
            print("hubo un error", error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imagenes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let imagen = imagenes[indexPath.row]
        
        cell.textLabel?.text = imagen.nombre
        cell.imageView?.image = UIImage(data: imagen.imagen! as Data)
        
        return cell
    }
   
}
