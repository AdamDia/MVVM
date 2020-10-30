//
//  MasterCell.swift
//  PomacTaskAhmedEssam
//
//  Created by Adam on 10/30/20.
//

import Foundation
import UIKit
import SDWebImage
import NotificationCenter


protocol MasterDetails {
    func sendMasterData(index: Int)
}


let notificationLoadTableDataAfterSettingImag = NSNotification.Name("Pressed")

class MasterCell: UITableViewCell {
    
    @IBOutlet weak var masterCellImg: UIImageView!
    @IBOutlet weak var masterCellTitleLbl: UILabel!
    @IBOutlet weak var masterCellPublishedByLbl: UILabel!
    @IBOutlet weak var masterCellDateLbl: UILabel!
    @IBOutlet weak var lineSperator: UIView!
    
    let placeHolderImage = UIImage(named: "appleLogo")
    var delegate: MasterDetails!
    var indexPath: IndexPath!
    
    
    @IBAction func masterCellBtnClicked(_ sender: Any) {
        print("Cell Clicked")
        delegate?.sendMasterData(index: indexPath.row)
    }
    
    var movie: ApiResults? {
        didSet {
            setMasterCellData()
        }
    }
    
    //MARK: - set Cell data 
    func setMasterCellData() {
        guard let movie = movie else { return }
        
        masterCellTitleLbl.text = movie.title
        masterCellPublishedByLbl.text = movie.publishedBy
        masterCellDateLbl.text = movie.publishedDate
        masterCellImg.sd_setImage(with: URL(string: movie.multimedia.photo),
                                  placeholderImage: placeHolderImage,
                                  options: .continueInBackground,
                                  context: nil,
                                  progress: nil) { (downloadedImage, downloadedException, CasheType, downloadURL) in
            if let downloadedException = downloadedException {
                print("Error downloading the Image", downloadedException.localizedDescription)
            } else {
                print("Success \(String(downloadURL!.absoluteString))")
            }
        }
                
    }
    
}
