//
//  DownloadsVC.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 04/01/2022.
//

import UIKit
import CoreData

class DownloadsVC: UIViewController {
    
    //MARK: - Variables
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UpcommingCell.self, forCellReuseIdentifier: UpcommingCell.identifer)
        return table
    }()
    
    private var downloadedMovie: [MovieEnt] = [MovieEnt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromEntity()
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
        
        self.title = "Download"
    }
    
    private func fetchFromEntity(){
        let fetch : NSFetchRequest = MovieEnt.fetchRequest()
        do {
            downloadedMovie = try context.fetch(fetch)
            tableView.reloadData()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func deleteFrom(_ index: NSManagedObject){
        context.delete(index)
        do {
            try context.save()
            
        }catch{
            print(error.localizedDescription)
        }
    }
}

extension DownloadsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadedMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcommingCell.identifer, for: indexPath) as? UpcommingCell else{return UITableViewCell()}
        cell.configure(posterPath: downloadedMovie[indexPath.row].poster_path! , movieName: downloadedMovie[indexPath.row].original_name ?? downloadedMovie[indexPath.row].original_title ?? "Unkown")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constans.ScreenHeight / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isUserInteractionEnabled = false
        guard let title = downloadedMovie[indexPath.row].original_title ?? downloadedMovie[indexPath.row].original_name else {return}
        
        APIFunctions.getFromYoutube(title: title) { response in
            DispatchQueue.main.async {
                let vc = PreviewMoviesVC()
                vc.configure(model: TitlePreviewViewModel(title: title, youtubeView: (response.id)!, titleOverview: self.downloadedMovie[indexPath.row].overview ?? ""))
                self.navigationController?.pushViewController(vc, animated: true)
                tableView.isUserInteractionEnabled = true
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            self.deleteFrom(downloadedMovie[indexPath.row])
            self.downloadedMovie.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        default:
            break;
        }
    }
}
