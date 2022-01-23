//
//  UpcommingCell.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 09/01/2022.
//

import UIKit
import SwiftUI
import Kingfisher

class UpcommingCell: UITableViewCell {

    //MARK: - Variables

     static let identifer = "UpcommingCell"
    
    private let PosterImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.image = UIImage(named: "heroImage")
        return img
    }()
    
    private let playButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let movieLbl: UILabel = {
        let lbl = UILabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func configure(posterPath: String, movieName:String){
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {return}
        PosterImg.kf.indicatorType = .activity
        PosterImg.kf.setImage(with: imageURL, placeholder: nil, options: nil)
        
        movieLbl.text = movieName 
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(PosterImg)
        contentView.addSubview(playButton)
        contentView.addSubview(movieLbl)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helper Functions
    
    private func addConstraints(){
        let posterImgConstraint = [
            PosterImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            PosterImg.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            PosterImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            PosterImg.heightAnchor.constraint(equalToConstant: 100),
            PosterImg.widthAnchor.constraint(equalToConstant: 100)
        ]
        let playBtnConstraint = [
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ]
        let lblConstraint = [
            movieLbl.leadingAnchor.constraint(equalTo: PosterImg.trailingAnchor, constant: 10),
          //  movieLbl.topAnchor.constraint(equalTo: PosterImg.topAnchor),
            movieLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieLbl.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -10)
        ]
        
        
        NSLayoutConstraint.activate(posterImgConstraint)
        NSLayoutConstraint.activate(playBtnConstraint)
        NSLayoutConstraint.activate(lblConstraint)
    }

    
}
