//
//  ViewModel.swift
//  Movie
//
//  Created by Bruno Gomez on 2/11/22.
//

import Foundation

class ViewModel {
    
    let nm = NetworkModel.shared //network model singleton
    var delegate : ViewModelDelegate? //delegate to communicate to view
    
    var movies = [Movie]() // data used for tableview in view
    var err : Error? // error in case any errors are returned
    
    func getMovie(_ index: Int) -> Movie? {
        if getMovieCount() == 0 {
            return nil
        }
        return movies[index] //returns movie based off index
    }
    
    func getMovieCount() -> Int {
        return movies.count //returns amount of movies in our data
    }
    
    func getMovieDisplay(_ index: Int) -> String? {
        guard let movie = getMovie(index) else { return nil }
        let title = movie.title ?? "No Title"
        let created = movie.createdAt ?? "No Date"
        let plays = movie.plays ?? 0
        let duration = movie.duration ?? 0.0
        let str = "Title: \(title)\nCreated At: \(created)\nPlays: \(plays)\nDuration: \(duration)"
        return str //returns string set up to be displayed
    }
    
    func getMovieTranscodings(_ index : Int) -> [Transcodings]? {
        guard let movie = getMovie(index), let transcodings = movie.transcodings else { return nil }
        return transcodings //returns transcoding array based off index of certain movie
    }
    
    func getMovieTranscodingDisplay(_ transcoding : Transcodings) -> String? {
        guard let title = transcoding.title, let size = transcoding.size, let id = transcoding.id, let height = transcoding.height, let width = transcoding.width, let state = transcoding.state else { return nil }
        let str = "ID: \(id)\nSize: \(size)\nHeight: \(height)\nWidth: \(width)\nState: \(state)\nTitle: \(title)"
        return str //returns string set up properly to be displayed
    }
    
    func goThroughTranscodings(_ transcodings : [Transcodings]) -> String?{
        var returnStr : String?
        for (index, transcoding) in transcodings.enumerated() {
            if index == 0 {
                returnStr = ""
            }
            guard let str = getMovieTranscodingDisplay(transcoding) else { return nil}
            
            returnStr? += str
            returnStr? += "\n----------------------\n"
        }
        return returnStr //return completely setup transcoding string ready for display
    }
    
    
    func assignMovies(_ movies : [Movie]) {
        self.movies = movies //assign data
    }
    
    func fetch(_ url : URLConstant) {
        nm.delegate = self
        nm.fetch(.url) //fetch request
    }
    
    func refreshUI() {
        delegate?.setUpUI() //tells view to refresh the UI based off data in viewmodel
    }
    
}

extension ViewModel : NetworkModelDelegate {
    
    func setUpMovies(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        guard let resp = response as? HTTPURLResponse else { return }
        
        //setup movies and then assign them, then refresh the UI based off data given from api call in network model
        if data != nil && resp.statusCode >= 200 && resp.statusCode < 400 && error == nil {
            guard let data = data else {
                print("error unwrapping data, might contain nil")
                return }
            do {
                let attempt = try JSONDecoder().decode([Movie].self, from: data)
                assignMovies(attempt)
                refreshUI()
            } catch {
                self.err = error
                return
            }
        }
    }
}
protocol ViewModelDelegate {
    func setUpUI()
}
