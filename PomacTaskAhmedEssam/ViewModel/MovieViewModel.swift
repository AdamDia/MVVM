//
//  MovieViewModel.swift
//  PomacTaskAhmedEssam
//
//  Created by Adam on 10/30/20.
//

import Foundation
import Alamofire

class MovieListViewModel {
    
    //MARK: - clourses used for notify when data updates
    var reloadMoviesList = {() -> () in}
    var errorMessage = {(message: String) -> () in}
 
    //MARK: - Array of Movies List
    var arrayOfData: [ApiResults] = [] {
        didSet {
            reloadMoviesList()
        }
    }
    
    //MARK: - get data from the API
    func getMoviesData(view: UIView) {
        let apiKey = "qwRqEkNrAYCIIw3sJfWqlnAxuHVdUKv7"
        let params = ["api-key": apiKey]
        guard let ApiUrl = URL(string:"https://api.nytimes.com/svc/movies/v2/reviews/search.json") else {return print("Invalid Api_link")}

        AF.request(ApiUrl, method: HTTPMethod.get, parameters: params)
            .responseJSON { response in
                guard let jsonData = response.data else { return }
                do {
                    //Using Decodable data parse
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(MoviesModel.self, from: jsonData)
                    self.arrayOfData = data.results!
                    UIView.animate(withDuration: 3) {
                        view.alpha = 0
                    }
                    print(self.arrayOfData.count)
                } catch {
                    print("Error ->\(error.localizedDescription)")
                    self.errorMessage(error.localizedDescription)
                }

            }
        
    }
    
    
}
