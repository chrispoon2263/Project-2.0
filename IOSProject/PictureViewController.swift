//
//  PictureViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 10/21/22.
//

import UIKit
import Foundation
import CoreData

class PictureViewController: UIViewController {
    
    //MARK: - Instance Variables
    @IBOutlet weak var spinningIndicator: UIActivityIndicatorView!
    var receiveString = ""
    var delegate: UIViewController!
    var urlString = "https://api.computerender.com/generate/"
    //observer on image variable to stop the spinningindicator when there is an image from the API call
    var image = UIImage(){
        didSet{
            if (spinningIndicator.isAnimating){
                spinningIndicator.stopAnimating()
            }
        }
    }
    
    // Create UIImageView Programatically
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - viewDidLoad
    // receives string from textVC and places imageView onto the VC
    // starts up the loading animation and then calls the API
    override func viewDidLoad() {
        super.viewDidLoad()
        // Receive string from TextVC and add url in front of the receive string
        urlString += receiveString
        
        // Move imageView's center to midX and 350 pixels from top usingFrames/bounds
        imageView.center = CGPoint(x: view.bounds.midX, y: 350)
        view.addSubview(imageView)
        
        //loading indicator
        spinningIndicator.hidesWhenStopped = true
        spinningIndicator.startAnimating()
        // Call the API
        callAPI()
    }
    
    //MARK: - callAPI
    // API CALL function updating the imageview UI with main.async
    // raises an alert when the server is not responding
    func callAPI(){
        guard let url = URL(string: urlString) else {
            return
        }
        let getDataTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                return
            }

            DispatchQueue.main.async {
                //update UIImageView
                if UIImage(data: data) != nil{
                    self.image = UIImage(data: data)!
                    self.imageView.image = self.image
                } else {
                    print("DATA IS NIL SERVER OVERLOAD")
                    let alert = UIAlertController(
                        title: "Too Many Requests Server Cannot Handle",
                        message: "Please Try again later",
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(
                        title: "OK",
                        style: .default
                    ))
                    self.present(alert, animated: true)
                }
                
            }
        })
        getDataTask.resume()
    }
    
    // Saves images to core data
    func saveToCoreData(image: UIImage) {
        let pngImageData = image.pngData()
        let GeneratedImage = NSEntityDescription.entity(forEntityName: "GeneratedImage", in: context)!
        let storedImage = NSManagedObject(entity: GeneratedImage, insertInto: context)
        storedImage.setValue(pngImageData, forKey: "storedImage")
        saveContext()
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
    
    // Upon AlbumButton clicked it will pop off the stack two views and place AlbumVC onto the stack
    @IBAction func AlbumButtonPressed(_ sender: Any) {
        if let navController = self.navigationController{
            // Pop off two view controllers from the stack
            navController.popViewController(animated: false)
            navController.popViewController(animated: false)
            // Push the album view controller to the stack
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "albumStoryboardID") as! AlbumViewController
            navController.pushViewController(vc, animated: true)
        }
    }
    //Upon Savebutton clicked it will save the image to Coredata and global items array holding UIimage objects
    @IBAction func SaveButtonPressed(_ sender: Any) {
        let targetSize = CGSize(width: 100, height: 100)
        let scaledImage = self.image.scalePreservingAspectRatio(targetSize: targetSize)

        //items.append(scaledImage)
        items.append(self.image)
        //ADD ORIGINAL IMAGE TO CORE DATA
        //saveToCoreData(image: scaledImage)
        saveToCoreData(image: self.image)
    }
        
    
    
}

