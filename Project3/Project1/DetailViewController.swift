//
//  DetailViewController.swift
//  Project1
//
//  Created by Irfan Khan on 07/02/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage : String?
    var totalImages : Int?
    var currentImageNo : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        showImage()
    }
    
    private func configure() {
        if let current = currentImageNo, let total = totalImages {
            title = "Picture \(String(describing: current + 1)) of \(String(describing: (total)))"
        }
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem    = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
    
    func showImage() {
        if let safeImage = selectedImage {
            imageView.image = UIImage(named: safeImage)
        }
    }
    
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No images found.")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
