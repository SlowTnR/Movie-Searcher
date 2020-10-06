//
//  ViewController.swift
//  Movie Searcher
//
//  Created by Ilja Patrushev on 6.10.2020.
//

import UIKit

// http://www.omdbapi.com/?apikey=29e94b43

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
        
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        let query = text.replacingOccurrences(of: " ", with: "%20")
        
        // Get data from API
        
        movies.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=29e94b43&s=\(query)&type=movie")!,
                                   completionHandler: {data, response, error in
                                    
                                    guard let data = data, error == nil else { return}
                                    
                                    // Convert
                                    var result: MovieResult?
                                    do {
                                        result = try JSONDecoder().decode(MovieResult.self, from: data)
                                    }
                                    catch {
                                        print ("error with data convert")
                                    }
                                    
                                    guard let finalResult = result else {
                                        return
                                    }
                                    
                                   
                                    
                                    // Update movies array
                                    
                                    let newMovies = finalResult.Search
                                    self.movies.append(contentsOf: newMovies)
                                    
                                    
                                    // Refresh table
                                    
                                    DispatchQueue.main.async {
                                        self.table.reloadData()
                                    }
                                    
                                   }).resume()
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

struct MovieResult: Codable {
    let Search: [Movie]
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey{
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}
