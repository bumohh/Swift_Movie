//
//  MovieViewController.swift
//  Movie
//
//  Created by Bruno Gomez on 2/11/22.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var MovieInformationLbl: UILabel!
    var vm : ViewModel?
    var index : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MovieInformationLbl.text = ""
        //get data to present transcodings
        guard let index = index else { return }
        guard let transcodings = vm?.getMovieTranscodings(index) else { return }
        guard let transcodingStr = vm?.goThroughTranscodings(transcodings) else { return }
        //setup transcoding label
        MovieInformationLbl.text? = transcodingStr
        
    }

}
