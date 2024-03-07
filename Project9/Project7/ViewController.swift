//
//  ViewController.swift
//  Project7
//
//  Created by Irfan Khan on 21/02/24.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    let refresh = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureRightBarButton()
        configureLeftBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredPetitions = petitions
    }
    
    
    func configureLeftBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchTapped))
    }
    
    
    func configureRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "book.closed"), style: .plain, target: self, action: #selector(creditTapped))
    }
    
    
    @objc func searchTapped() {
        let alert = UIAlertController(title: "Search for Petitions", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let searchAction = UIAlertAction(title: "Search", style: .default) { [weak alert, weak self] action in
            guard let self else { return }
            guard let alert else { return }
            
            self.filteredPetitions = []
            for petition in petitions {
                if petition.title.lowercased().contains((alert.textFields?[0].text?.lowercased())!) {
                    filteredPetitions.append(petition)
                }
            }
            tableView.reloadData()
        }
        alert.addAction(searchAction)
        present(alert, animated: true)
        
    }
    
    
    @objc func creditTapped() {
        let alert = UIAlertController(title: "Credits", message: "The data comes from 'We the people' api of White House.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    func getData() {
        var urlString: String {
            if navigationController?.tabBarItem.tag == 0 {
                return "https://www.hackingwithswift.com/samples/petitions-1.json"
            } else {
                return "https://www.hackingwithswift.com/samples/petitions-2.json"
            }
        }
        let url = URL(string: urlString)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URLRequest(url: url!)) { [weak self] data, response, error in
            guard let self else {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                showError()
                return
            }
            
            if let _ = error {
                showError()
                return
            }
            
            guard let safeData = data else {
                showError()
                return
            }
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Petitions.self, from: safeData)
                self.petitions = decodedData.results
                self.filteredPetitions = self.petitions
                DispatchQueue.main.async{ [weak self] in
                    self?.tableView.reloadData()
                }
            } catch {
                showError()
            }
            
        }
        task.resume()
    }
    
    
    func showError() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed. Please check your internet connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self?.present(alert, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let filteredPetition = filteredPetitions[indexPath.row]
        
        cell.textLabel?.text = filteredPetition.title
        cell.detailTextLabel?.text = filteredPetition.body
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }


}

