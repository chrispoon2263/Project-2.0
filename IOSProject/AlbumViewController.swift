//
//  AlbumViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 10/28/22.
//

import UIKit
import CoreData

let lakeImage = UIImage(named: "lake.png")!
let targetSize = CGSize(width: 100, height: 100)

let scaledImage = lakeImage.scalePreservingAspectRatio(
    targetSize: targetSize
)

var items: [UIImage] = [scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage]
var originalImages: [UIImage] = [scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage, scaledImage]

protocol reloadView{
    func reloadCollectionView()
}

class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, reloadView{
  

    var imageView: UIImageView!
    let cellIdentifier = "CellIdentifier"
    var delegate:UIViewController!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        var imageView:UIImageView=UIImageView(frame: CGRect(x:0, y:0, width:100, height:100))
        var img = items[indexPath.row]
        imageView.image = img
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Segue
        print("You selected cell #\(indexPath.item)!")
    }
    
    func reloadCollectionView(){
        self.collectionView.reloadData()
    }

}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
