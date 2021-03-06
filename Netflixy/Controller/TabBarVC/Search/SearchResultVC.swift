//
//  SearchResultVC.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 10/01/2022.
//

import UIKit

protocol SearchResultVCDelegate{
    func collectionViewTableViewCellDidTapCell(_ model: TitlePreviewViewModel)
}

class SearchResultVC: UIViewController {
    
    
    //MARK: - Variables
    
    var searchResults: [Title] = [Title]()
    var delegate: SearchResultVCDelegate?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: Constans.ScreenWidth / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 5
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HomeCVCell.self, forCellWithReuseIdentifier: HomeCVCell.identifer)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        collectionView.frame = view.bounds
    }
    
    //MARK: - Helper Function
    
    private func setupCollection(){
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func downloadTapped(indexPath: IndexPath){
        HelperFunctions.insertToEntity(indexPath: indexPath, titles: searchResults)
    }
    
}
extension SearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCVCell.identifer, for: indexPath) as? HomeCVCell else{return UICollectionViewCell()}
        cell.configureCellPosterImg(posterPath: (self.searchResults[indexPath.row].poster_path ?? ""))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.isUserInteractionEnabled = false
        guard let title = searchResults[indexPath.row].original_title ?? searchResults[indexPath.row].original_name else {return}
        
        APIFunctions.getFromYoutube(title: title) { response in
            self.delegate?.collectionViewTableViewCellDidTapCell(TitlePreviewViewModel(title: title, youtubeView: (response.id!) , titleOverview: self.searchResults[indexPath.row].overview ?? ""))
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
