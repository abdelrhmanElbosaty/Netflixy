//
//  UpcomingVC.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 04/01/2022.
//

import UIKit
import SwiftUI

class UpcomingVC: UIViewController {
    
    //MARK: - Variables
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UpcommingCell.self, forCellReuseIdentifier: UpcommingCell.identifer)
        return table
    }()
    
    private var upcommingMovie: [Title] = [Title]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        setupTableView()
        getUpcomingMovie()
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
        
        self.title = "Up comming"
    }
    
    private func getUpcomingMovie(){
        APIFunctions.getUpcommingMovies { response in
            self.upcommingMovie = response.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private func downloadTapped(indexPath: IndexPath){
        HelperFunctions.insertToEntity(indexPath: indexPath, titles: upcommingMovie)
    }
}

//MARK: - TableView
extension UpcomingVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcommingMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcommingCell.identifer, for: indexPath) as? UpcommingCell else{return UITableViewCell()}
        cell.configure(posterPath: upcommingMovie[indexPath.row].poster_path! , movieName: upcommingMovie[indexPath.row].original_name ?? upcommingMovie[indexPath.row].original_title ?? "Unkown")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constans.ScreenHeight / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isUserInteractionEnabled = false
        guard let title = upcommingMovie[indexPath.row].original_title ?? upcommingMovie[indexPath.row].original_name else {return}
        
        APIFunctions.getFromYoutube(title: title) { response in
            DispatchQueue.main.async {
                let vc = PreviewMoviesVC()
                vc.configure(model: TitlePreviewViewModel(title: title, youtubeView: (response.id)!, titleOverview: self.upcommingMovie[indexPath.row].overview ?? ""))
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


