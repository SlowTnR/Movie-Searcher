//
//  ViewController.swift
//  Movie Searcher
//
//  Created by Ilja Patrushev on 6.10.2020.
//

import UIKit

// UI
// Network request
// Tap a cell to see info
// Custom cell

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        field.delegate = self
        
    }
    
    // MARK: FIELD
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchMovies()
        return true
    }
    
    func searchMovies(){
        field.resignFirstResponder()
    }
    
    //MARK: TABLE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // show movies details
    }


}

struct Movie {
    
}
