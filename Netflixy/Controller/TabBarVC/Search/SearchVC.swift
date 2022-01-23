//
//  SearchVC.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 04/01/2022.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate  {
    
    //MARK: - Varibales
    
    var moviesList: [Title] = [Title]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UpcommingCell.self, forCellReuseIdentifier: UpcommingCell.identifer)
        return table
    }()
    
    private let searchController: UISearchController = {
        let searchBar = UISearchController(searchResultsController: SearchResultVC())
        searchBar.searchBar.placeholder = "Find a Movie or a Tv show"
        searchBar.searchBar.tintColor = .white
        searchBar.automaticallyShowsSearchResultsController = true
        searchBar.searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupTableView()
        getDiscoveredMoview()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.tableView.deselectSelectedRow(animated: true)
    }
    
    
    //MARK: - Helper Functions
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    private func setupUI(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.title = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    private func getDiscoveredMoview(){
        APIFunctions.discoveredMovies { response in
            self.moviesList = response.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private func downloadTapped(indexPath: IndexPath){
        HelperFunctions.insertToEntity(indexPath: indexPath, titles: moviesList)
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcommingCell.identifer, for: indexPath) as? UpcommingCell else {return UITableViewCell()}
        cell.configure(posterPath: moviesList[indexPath.row].poster_path! , movieName: moviesList[indexPath.row].original_name ?? moviesList[indexPath.row].original_title ?? "Unkown")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constans.ScreenHeight / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isUserInteractionEnabled = false
        guard let title = moviesList[indexPath.row].original_title ?? moviesList[indexPath.row].original_name else {return}
        
        APIFunctions.getFromYoutube(title: title) { response in
            DispatchQueue.main.async {
                let vc = PreviewMoviesVC()
                vc.configure(model: TitlePreviewViewModel(title: title, youtubeView: (response.id)!, titleOverview: self.moviesList[indexPath.row].overview ?? ""))
                self.navigationController?.pushViewController(vc, animated: true)
                tableView.isUserInteractionEnabled = true
            }
        }
    }
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let action = UIAction(title: "download", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self.downloadTapped(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [action])
        }
        return config
    }
    
    
}
extension SearchVC: UISearchResultsUpdating,SearchResultVCDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 1,
              let resultsController = searchController.searchResultsController as? SearchResultVC else {return}
        
        resultsController.delegate = self
        
        APIFunctions.searchMovies(query: query) { response in
            resultsController.searchResults = response.results
            DispatchQueue.main.async {
                resultsController.collectionView.reloadData()
            }
        }
    }
    
    func collectionViewTableViewCellDidTapCell(_ model: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = PreviewMoviesVC()
            vc.configure(model: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
