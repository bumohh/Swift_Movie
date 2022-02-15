//
//  NetworkModel.swift
//  Movie
//
//  Created by Bruno Gomez on 2/11/22.
//

import Foundation

class NetworkModel {
    static var shared = NetworkModel() //singleton of api handler
    private init() { }
    
    var delegate : NetworkModelDelegate? //delegate for communication between the viewmodel and the api handler
    
    
    //api call to fetch data and then tell the viewmodel to do the data manipulation
    func fetch(_ url : URLConstant) {
        guard let urlObj = URL(string: url.rawValue) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: urlObj) {[weak self] data, response, error in
            self?.delegate?.setUpMovies(data, response, error)
        }.resume()
    }
    
}

protocol NetworkModelDelegate {
    func setUpMovies(_ data : Data?, _ response : URLResponse?, _ error : Error?)
}
