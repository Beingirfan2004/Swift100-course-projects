//
//  DetailVC.swift
//  Challenge1
//
//  Created by Irfan Khan on 13/02/24.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureBarButton()
    }
        
    private func configure() {
        if let title = selectedImage {
            let newTitle = title.replacingOccurrences(of: "@3x.png", with: "")
            self.title = newTitle.uppercased()
        }
        navigationItem.largeTitleDisplayMode = .never
        if let safeImage = selectedImage{
            guard let image = UIImage(named: safeImage) else {
                print("Image not found.")
                return
            }
            imageView.image = image
        }
    }
    
    
    func configureBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
    }
    
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Image not found.")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }

}
