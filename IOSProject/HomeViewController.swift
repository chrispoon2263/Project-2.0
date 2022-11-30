//
//  HomeViewController.swift
//  IOSProject
//
//  Created by chi hai on 10/21/22.
//

import UIKit
import CoreData
import FirebaseAuth

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
let imageSegueIdentifier = "ImageSegueIdentifier"
let albumSegueIdentifier = "AlbumSegueIdentifier"

class HomeViewController: UIViewController {
    @IBOutlet weak var buttons: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var makeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        coreData()
        
        // set background image
        let backgroundImage = UIImage(named: "BG2")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        if #available(iOS 15.0, *) {
            buttons.configuration?.attributedTitle?.font = UIFont(name: "Futura Medium", size: 16.0)
            settingsButton.configuration?.attributedTitle?.font = UIFont(name: "Futura Medium", size: 16.0)
            makeButton.configuration?.attributedTitle?.font = UIFont(name: "Futura Medium", size: 16.0)
        } else {
            // Fallback on earlier versions
        }
    }


//    @IBAction func logOutButtonPressed(_ sender: Any) {
//        do {
//            items = []
//            try Auth.auth().signOut()
//            self.dismiss(animated: true)
//        } catch {
//            print("sign out error")
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == imageSegueIdentifier, let nextVC = segue.destination as? TextViewController {
            nextVC.delegate = self
        }
        
        if segue.identifier == albumSegueIdentifier, let nextVC = segue.destination as? AlbumViewController {
            nextVC.delegate = self
        }
        
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
        
        saveContext()
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
    
    // Saves context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
