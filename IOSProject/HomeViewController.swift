//
//  HomeViewController.swift
//  IOSProject
//
//  Created by chi hai on 10/21/22.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

let imageSegueIdentifier = "ImageSegueIdentifier"
let albumSegueIdentifier = "AlbumSegueIdentifier"

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == imageSegueIdentifier, let nextVC = segue.destination as? TextViewController {
            nextVC.delegate = self
        }
        
        if segue.identifier == albumSegueIdentifier, let nextVC = segue.destination as? AlbumViewController {
            nextVC.delegate = self
        }
        
    }
    
    @IBAction func makeImageButtonPressed(_ sender: Any) {
    }
    
    @IBAction func albumButtonPressed(_ sender: Any) {
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
    }

    // Fetches core data
    func coreData() {
        let fetchedResults = retrieveImages()
        
        for storedImage in fetchedResults {
            if let storedImgData = storedImage.value(forKey: "storedImage") {
                
                let image = UIImage(data: storedImgData as! Data)
                items.append(image!)
            }
        }
    }
    
    // Retrieves all images from core data
    func retrieveImages() -> [NSManagedObject] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GeneratedImage")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        return(fetchedResults)!
    }
}
