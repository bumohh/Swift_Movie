//
//  ViewController.swift
//  Movie
//
//  Created by Bruno Gomez on 2/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    let vm = ViewModel() //viewmodel instance for direct communication between view and model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tableview setup
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        //viewmodel setup
        vm.delegate = self
        vm.fetch(.url) //tell viewmodel to fetch data
    }


}


extension ViewController : ViewModelDelegate { //conform to protocol for viewmodel to tell view to redo ui once data is fetched properly
    func setUpUI() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

//no need for implimentation
extension ViewController : UITableViewDelegate {
    
}

//set up UI
extension ViewController : UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.getMovieCount() //sets number of rows in tableview for how much data in viewmodel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = vm.getMovieDisplay(indexPath.row)
        cell.textLabel?.numberOfLines = 0; //set cell text to have any number of lines for dynamic cell
        cell.textLabel?.lineBreakMode = .byWordWrapping //allows for dynamic cell
        cell.layer.cornerRadius = 15 //makes cell round
        return cell //returns custom cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MovieViewController") as? MovieViewController else { return }
        
        vc.index = indexPath.row //sets property of movieviewcontroller so that it knows what index was used for proper information to be called
        vc.vm = vm //passes viewmodel for access in destination vc to make function calls
        navigationController?.pushViewController(vc, animated: true)
    }
}
