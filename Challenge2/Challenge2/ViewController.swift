//
//  ViewController.swift
//  Challenge2
//
//  Created by Irfan Khan on 20/02/24.
//

import UIKit

class ViewController: UITableViewController {
    var items = [String]()
    var itemNo = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAll))
    }
    
    
    @objc func deleteAll() {
        items.removeAll()
        tableView.reloadData()
    }
    
    
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "New Item", message: "", preferredStyle: .alert)
        alert.addTextField()
        
        let action = UIAlertAction(title: "Add ", style: .default) { [weak self, weak alert]_ in
            guard let self else { return }
            guard let alert else { return }
            if let item = alert.textFields?[0].text{
                self.add(item)
            }
        }
        
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    func add(_ item: String) {
        items.append(item)
        let indexPath = IndexPath(row: itemNo, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        itemNo += 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.heightAnchor.constraint(equalToConstant: 70).isActive = true
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        cell.textLabel?.textColor = .label
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var accessory = tableView.cellForRow(at: indexPath)?.accessoryType
        
        if accessory == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    
}

