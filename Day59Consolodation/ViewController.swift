//
//  ViewController.swift
//  Day59Consolodation
//
//  Created by Daniel O'Leary on 4/1/19.
//  Copyright © 2019 Impulse Coupled Dev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var aircraft = [AircraftData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Airbus Aircraft"
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=Airbus&format=json"
//        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
//        let urlString = "https://restcountries.eu/rest/v2/all"

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                // return will only be reached if the parse(json:) was NOT reached.
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonAircraft = try? decoder.decode(Aircraft.self, from: json) {
            aircraft = jsonAircraft.search
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            print("I got nothing")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("aircraft count is \(aircraft.count)")
        return aircraft.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let aircraftType = aircraft[indexPath.row]
        cell.textLabel?.text = aircraftType.title
        cell.detailTextLabel?.text = "Subtitle goes here"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = aircraft[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func showError() {
        let ac = UIAlertController(title: "Error Loading", message: "There was an error loading data from the web.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dang", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }


}

