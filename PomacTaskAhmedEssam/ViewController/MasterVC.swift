//
//  MasterVC.swift
//  PomacTaskAhmedEssam
//
//  Created by Adam on 10/30/20.
//

import UIKit

class MasterVC: UIViewController, MasterDetails{
    
    //Var to get the data from the protocol function
    var moviePassedToDetails: ApiResults?
    //MARK: - conform the protocol
    func sendMasterData(index: Int) {
      moviePassedToDetails = viewModel.arrayOfData[index]
        self.performSegue(withIdentifier: "showSegue", sender: self)
    }
    
    
    @IBOutlet weak var whiteBackgroundview: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var moviesTableView: UITableView!
    //view model obj
    var viewModel = MovieListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageSetup()
   
    }
    
    func pageSetup() {
        activityIndicator.startAnimating()
        viewModel.getMoviesData(view: whiteBackgroundview)
        
        closureSetUp()
    }
    
  
    
    ///closure initialize
    func closureSetUp()  {
        viewModel.reloadMoviesList = { [weak self] ()  in
            ///UI chnages in main tread
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
               self?.activityIndicator.stopAnimating()
                
            }
        }
        viewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    

}


extension MasterVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell") as! MasterCell
        let listObj = viewModel.arrayOfData[indexPath.row]
        cell.delegate = self
        cell.indexPath = indexPath
        ///Cell data settings
        cell.movie = listObj
        if viewModel.arrayOfData.count - 1 == indexPath.row {
            cell.lineSperator.alpha = 0
        }
      
        return cell
    }
    
}

extension MasterVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSegue" {
            let viewController = segue.destination as? DetailsVc
            guard let vc = viewController else {return}
            vc.movieTitle = moviePassedToDetails?.title
            vc.movieBy = moviePassedToDetails?.publishedBy
            vc.movieDate = moviePassedToDetails?.publishedDate
            vc.movieImage = moviePassedToDetails?.multimedia.photo
        }
    }
}
