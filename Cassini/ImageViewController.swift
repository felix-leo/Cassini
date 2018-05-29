//
//  ImageViewController.swift
//  Cassini
//
//  Created by sysadmin on 5/28/18.
//  Copyright © 2018 BYUH. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: URL? {
        didSet {
            image = nil
            
            // if the view is load, then fetch the image
            if view.window != nil {
                fetchImage()
            }
        }
    }
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit() // set it to intrinsic size
            scrollView.contentSize = imageView.frame.size // to enable scroll
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // if the image is nil
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            
            scrollView.addSubview(imageView)
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageView =  UIImageView()
    
    private func fetchImage() {
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                self.image = UIImage(data: imageData)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil{
            imageURL = DemoURLs.stanford
        }
        
    }
}
