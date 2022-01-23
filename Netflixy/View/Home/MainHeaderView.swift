//
//  MainHeaderView.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 05/01/2022.
//

import UIKit
import Kingfisher
import CoreData

protocol mainHeaderViewDelegate{
    func mainHeaderViewDidTapCell(_ cell: MainHeaderView, model: TitlePreviewViewModel)
}
class MainHeaderView: UIView {
    //MARK: - Variables

    var container: UIViewController?
    var title: Title?
    var delegate: mainHeaderViewDelegate?
    private let headerView: UIImageView = {
       let img = UIImageView(image: UIImage(named: "heroImage"))
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()

    private let playButton: UIButton = {
        let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.layer.cornerRadius = 10
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.5)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        return playButton
    }()
    
    private let downloadButton: UIButton = {
        let downloadButton = UIButton()
        downloadButton.setTitle("Download", for: .normal)
     //   downloadButton.setTitleColor(.label, for: .normal)
        downloadButton.layer.cornerRadius = 10
        downloadButton.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.5)
        downloadButton.layer.borderWidth = 1
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        return downloadButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerView)
        addGradiant()
        addSubview(playButton)
        addSubview(downloadButton)
        applayConstraint()
//        playButton.addTarget(self, action: #selector(playBttnTapped), for: .touchUpInside)
//        downloadButton.addTarget(self, action: #selector(downloadBttnTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerView.frame = bounds
    }
    //MARK: - Helper Functions
    private func addGradiant(){
        let grad = CAGradientLayer()
        grad.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor.copy(alpha: 1) as Any
        ]
        grad.frame = bounds
        layer.addSublayer(grad)
    }

    private func applayConstraint(){
        let playButtonConstraint = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            playButton.widthAnchor.constraint(equalToConstant: Constans.ScreenWidth/3)
        ]
        let downloadButtonConstraint = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
//            downloadButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 30),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            downloadButton.widthAnchor.constraint(equalToConstant: Constans.ScreenWidth/3)
        ]
        NSLayoutConstraint.activate(playButtonConstraint)
        NSLayoutConstraint.activate(downloadButtonConstraint)
        
    }
    
    func configureCellPosterImg(posterPath: String){
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {return}
        headerView.kf.indicatorType = .activity
        
        headerView.kf.setImage(with: imageURL
//                            ,placeholder: #imageLiteral(resourceName: "heroImage"),
//                            options: [.transition(.fade(0.8))]
        )
    }
//    @objc func playBttnTapped(){
//        APIFunctions.getFromYoutube(title: title?.original_name ?? title?.original_title ?? "") { response in
//            DispatchQueue.main.async {
//                self.delegate?.mainHeaderViewDidTapCell(self, model: TitlePreviewViewModel(title: self.title?.original_title ?? self.title?.original_name ?? "" , youtubeView: (response.id)!, titleOverview: self.title?.overview ?? ""))
//            }
//        }
//    }
//    @objc func downloadBttnTapped(){
//        HelperFunctions.insertToEntity(titles: title!)
//    }
    
 
    required init?(coder: NSCoder) {
        fatalError()
    }
}
