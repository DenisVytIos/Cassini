//
//  ImageViewController.swift
//  Cassini
//
//  Created by Denis on 08.03.2019.
//  Copyright © 2019 Denis Vitrishko. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL?{
        didSet {
            image = nil
            
            
            if view.window != nil {//если view появился на екране, то делаем выборку
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
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil{
            imageURL = DemoURLs.stanford
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       if imageView.image == nil{// если изображения нет то делаем выборку
            fetchImage()
        }
    }

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    var imageView = UIImageView()
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    private func fetchImage() {
        if let url = imageURL {//если  imageURL не равен nil то мы должны скачать данные по этому url
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage (data: imageData)
            
            }
          
            
        }
        
    }
}
