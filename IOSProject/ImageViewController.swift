//
//  ImageViewController.swift
//  IOSProject
//
//  Created by  on 11/11/22.
//

import UIKit
import CoreData

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
