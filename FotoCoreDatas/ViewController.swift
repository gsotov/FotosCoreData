//
//  ViewController.swift
//  FotoCoreDatas
//
//  Created by Tecnova on 1/9/19.
//  Copyright © 2019 Gabriel Soto Valenzuela. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func guardar(_ sender: UIButton)
    {
        let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let imagenEntity = NSEntityDescription.entity(forEntityName: "Imagenes", in: contexto)
        let newImagen = NSManagedObject(entity: imagenEntity!, insertInto: contexto)
        
        let imagenFinal = imagen.image!.pngData() as NSData?
        
        
        newImagen.setValue(nombre.text, forKey: "nombre")
        newImagen.setValue(imagenFinal, forKey: "imagen")
        
        do {
            try contexto.save()
            print("guardado")
            nombre.text = ""
        } catch let error as NSError {
            print("hubo un error" , error)
        }
    }
    @IBAction func camara(_ sender: UIBarButtonItem)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func galeria(_ sender: UIBarButtonItem)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let imagenTomada = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imagen.image = imagenTomada
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

