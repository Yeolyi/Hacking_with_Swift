//
//  ViewController.swift
//  Project7
//
//  Created by SEONG YEOL YI on 2022/01/03.
//

import UIKit

class ViewController: UITableViewController {
    
    var allPetitions = [Petition]()
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = navigationController?.tabBarItem.tag == 0 ? "https://www.hackingwithswift.com/samples/petitions-1.json" :
        "https://www.hackingwithswift.com/samples/petitions-2.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter)),
            UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits)),
        ]
    }
    
    @objc func filter() {
        let alertController = UIAlertController(title: "Filter petitions", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Apply", style: .default, handler: { _ in self.petitions = self.allPetitions.filter { $0.title.contains(alertController.textFields?[0].text ?? "")
            }
            self.tableView.reloadData()
        }))
        self.present(alertController, animated: true)
    }
    
    @objc func showCredits() {
        let alertController = UIAlertController(title: "Data source", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            allPetitions = jsonPetitions.results
            petitions = allPetitions
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let petition = petitions[indexPath.row]
        content.text = petition.title
        content.secondaryText = petition.body
        content.secondaryTextProperties.numberOfLines = 3
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

