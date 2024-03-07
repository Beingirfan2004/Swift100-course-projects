//
//  InitialViewController.swift
//  Project4
//
//  Created by Irfan Khan on 14/02/24.
//

import UIKit

class InitialViewController: UITableViewController {
    var websites = ["hackingwithswift.com", "google.com", "swiftbysundell.com", "youtube.com", "apple.com", "samsung.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        let newTitle = websites[indexPath.row].replacingOccurrences(of: ".com", with: "")
        cell.textLabel?.text = newTitle.uppercased()
        cell.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController{
            vc.website = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}
