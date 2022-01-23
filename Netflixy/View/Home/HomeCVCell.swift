//
//  HomeCVCell.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 07/01/2022.
//

import UIKit
import Kingfisher


class HomeCVCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    static let identifer = "HomeCVCell"
    
    private let posterImg:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImg)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImg.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    //MARK: - Helper Functions

    func configureCellPosterImg(posterPath: String){
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {return}
        posterImg.kf.indicatorType = .activity
        posterImg.contentMode = .scaleAspectFill
        posterImg.kf.setImage(with: imageURL
                            ,placeholder: #imageLiteral(resourceName: "noImg")
//                           , options: [.transition(.fade(0.8))]
        )
        
    }
}
