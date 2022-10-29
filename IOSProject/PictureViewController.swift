//
//  PictureViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 10/21/22.
//

import UIKit
import Foundation

class PictureViewController: UIViewController {
    
    var receiveString = ""
    var delegate: UIViewController!
    var urlString = "https://api.computerender.com/generate/"
    
    // Create UIImageView Object to hold the api data when it is received
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(receiveString)
        urlString += receiveString
        view.addSubview(imageView)
        imageView.center = view.center
        callAPI()

    }
    
    // API CALL function
    func callAPI(){
        guard let url = URL(string: urlString) else {
            return
        }
        let getDataTask = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else{
                return
            }

            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
            
            DispatchQueue(label: "SaveImageQueue", qos: .background, attributes: .concurrent).async {
                let image = UIImage(data: data)
                let targetSize = CGSize(width: 100, height: 100)
                let scaledImage = image?.scalePreservingAspectRatio(targetSize: targetSize)
                items.append(scaledImage!)
            }
        })
        getDataTask.resume()
    }

}

