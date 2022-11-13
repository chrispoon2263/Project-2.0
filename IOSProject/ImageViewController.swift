//
//  ImageViewController.swift
//  IOSProject
//
//  Created by  on 11/11/22.
//

import UIKit
import CoreData
import Photos

var selectedImage:UIImage!
var currentIndex:Int!

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(image: selectedImage)
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .black
        scrollView.contentSize = imageView.bounds.size
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.3
        scrollView.maximumZoomScale = 5.0
        scrollView.zoomScale = 2.5
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(recognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Delete Photo",
            message: "This photo will be deleted from your album.",
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(
            title: "Delete",
            style: .destructive,
            handler: {
                (alert: UIAlertAction!) in
                items.remove(at: currentIndex)
                
                // Delete from core data
                let allImages = self.retrieveImages()
                print(currentIndex!)
                let delImage = allImages[currentIndex!]
                context.delete(delImage)
                self.saveContext()
                
                self.popToAlbum()
            }))
        
        controller.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel))
        
        present(controller, animated: true)
    }
    
    // Pops navigation controller stack to AlbumViewController
    func popToAlbum() {
        if let albumVC = self.navigationController?.viewControllers.filter { $0 is AlbumViewController }.first {
            self.navigationController?.popToViewController(albumVC, animated: true)
        }
    }
    
    // Allows the option for users to save images if long presses screen
    @IBAction func handleLongPressGesture (recognizer: UILongPressGestureRecognizer) {
        let controller = UIAlertController(
            title: "Save Photo to Camera Roll",
            message: "This photo will be saved to your camera roll.",
            preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(
            title: "Save",
            style: .default,
            handler: {
                (alert: UIAlertAction!) in
                
                let status = PHPhotoLibrary.authorizationStatus()

                // Photo library access has been granted
                if (status == .authorized) {
                    // Saves image to camera roll
                    var imageToBeSaved = items[currentIndex]
                    UIImageWriteToSavedPhotosAlbum(imageToBeSaved, nil, nil, nil);
                }

                // Photo library access has been denied
                else if (status == .denied) {
                    let secondController = UIAlertController(
                        title: "No Access to Camera Roll",
                        message: "Permission to access camera roll was denied. Please go to device settings to change your preferences.",
                        preferredStyle: .alert)
                    
                    secondController.addAction(UIAlertAction(
                        title: "OK",
                        style: .default))
                    
                    secondController.addAction(UIAlertAction(
                        title: "Cancel",
                        style: .cancel))
                    
                    self.present(secondController, animated: true)
                }
            }))
            
        controller.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel))
            
        present(controller, animated: true)
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
