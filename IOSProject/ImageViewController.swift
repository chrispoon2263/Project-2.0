//
//  ImageViewController.swift
//  IOSProject
//
//  Created by  on 11/11/22.
//

import UIKit

var selectedImage:UIImage!

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
}
