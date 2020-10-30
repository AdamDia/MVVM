//
//  DetailsVc.swift
//  PomacTaskAhmedEssam
//
//  Created by Adam on 10/30/20.
//

import UIKit
import SDWebImage


class DetailsVc: UIViewController {

    
    @IBOutlet weak var detailsImg: UIImageView!
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsPublishedBy: UILabel!
    @IBOutlet weak var detailsDate: UILabel!
    
    
    var movieImage: String?
    var movieTitle: String?
    var movieBy: String?
    var movieDate: String?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setData()
        }
        
    }
    
    //MARK: - set details Data
    func setData() {
        
        detailsTitle.text = movieTitle
        detailsPublishedBy.text = movieBy
        detailsDate.text = movieDate
        guard let movieImg = movieImage else {return}
        setImage(imageURL: movieImg)
    }
    
    func setImage(imageURL: String) {
     
      let movieImageSet = SDWebImageManager.shared.cacheKey(for: URL(string: imageURL), context: nil)
        detailsImg.sd_setImage(with: URL(string: movieImageSet!), completed: nil)
        
    }

}
