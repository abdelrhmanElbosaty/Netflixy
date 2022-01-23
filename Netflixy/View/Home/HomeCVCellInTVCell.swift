//
//  HomeCVCell.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 05/01/2022.
//

import UIKit
import CoreData

protocol homeCVCellInTVCellDelegate{
    func collectionViewTableViewCellDidTapCell(_ cell: HomeCVCellInTVCell, model: TitlePreviewViewModel)
}

class HomeCVCellInTVCell: UITableViewCell {
    
    //MARK: - Variables
    
    static let identifer = "HomeCVCellInTVCell"
    private var titles: [Title] = [Title]()
    
    var delegate: homeCVCellInTVCellDelegate?
    
    private let collectionFeedView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: Constans.ScreenWidth / 3, height: Constans.ScreenHeight )
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(HomeCVCell.self, forCellWithReuseIdentifier: HomeCVCell.identifer)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .cyan
        contentView.addSubview(collectionFeedView)
        setUpCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionFeedView.frame = contentView.bounds
    }
    
    //MARK: - Helper Functions
    
    private func setUpCollection(){
        collectionFeedView.delegate = self
        collectionFeedView.dataSource = self
    }
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionFeedView.reloadData()
        }
    }
    
    private func downloadTapped(indexPath: IndexPath){
        HelperFunctions.insertToEntity(indexPath: indexPath, titles: titles)
    }
   
    
}
//MARK: - Collection Delegates

extension HomeCVCellInTVCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCVCell.identifer, for: indexPath) as? HomeCVCell
        else{return UICollectionViewCell()}
        cell.backgroundColor = .gray
        
        cell.configureCellPosterImg(posterPath: (self.titles[indexPath.row].poster_path!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.isUserInteractionEnabled = false
        guard let title = titles[indexPath.row].original_title ?? titles[indexPath.row].original_name else {return}
        
        APIFunctions.getFromYoutube(title: title) { response in
            self.delegate?.collectionViewTableViewCellDidTapCell(self, model: TitlePreviewViewModel(title: self.titles[indexPath.row].original_name ?? self.titles[indexPath.row].original_title ?? "", youtubeView: (response.id)!, titleOverview: self.titles[indexPath.row].overview!))
            DispatchQueue.main.async {
                collectionView.isUserInteractionEnabled = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let action = UIAction(title: "download", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self.downloadTapped(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [action])
        }
        return config
    }
}
