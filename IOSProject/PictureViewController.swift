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
    
    var receiveString = ""
    var delegate: UIViewController!
    var urlString = "https://api.computerender.com/generate/"
    var tempScaledImage = UIImage()
    var tempImage = UIImage()
    
    // Create UIImageView Programatically
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Receive string from TextVC and add url in front of the receive string
        urlString += receiveString
        
        // Move imageView's center to midX and 350 pixels from top usingFrames/bounds
        imageView.center = CGPoint(x: view.bounds.midX, y: 350)
        view.addSubview(imageView)
        
        // Call the API
        callAPI()
    }
    
    // API CALL function
    func callAPI(){
        guard let url = URL(string: urlString) else {
            return
        }
        let getDataTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                if let error = error {
                }
                return
            }

            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
            
            DispatchQueue(label: "GetImageQueue", qos: .background, attributes: .concurrent).async {
                let image = UIImage(data: data)
                let targetSize = CGSize(width: 100, height: 100)
                let scaledImage = image?.scalePreservingAspectRatio(targetSize: targetSize)
                items.append(scaledImage!)
               
                self.saveToCoreData(image:scaledImage!)
                self.tempScaledImage = scaledImage!
                self.tempImage = image!
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
    
    func perform<T>(_ expression: @autoclosure () throws -> T, errorTransform: (Error) -> Error) throws -> T {
        do {
            return try expression()
        } catch {
            throw errorTransform(error)
        }
    }
    
    
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
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        items.append(tempScaledImage)
        saveToCoreData(image: tempScaledImage)
        
    }
    

}

