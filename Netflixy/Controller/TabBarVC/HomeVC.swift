//
//  HomeVC.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 04/01/2022.
//

import UIKit

// Section Enum
///To define what section we were
enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeVC: UIViewController {
    
    //MARK: - Variables
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
    var randomTrendingMovie: Title?
    var header: MainHeaderView?
    
    private let tableFeedView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(HomeCVCellInTVCell.self, forCellReuseIdentifier: HomeCVCellInTVCell.identifer)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpNavigationBar()
        getRandomTrendingMovie()
    }
    override func viewDidLayoutSubviews() {
        tableFeedView.frame = view.bounds
    }
    //MARK: - Helper Functions
    
    //TableView init
    private func setUpTableView(){
        tableFeedView.delegate = self
        tableFeedView.dataSource = self
        view.addSubview(tableFeedView)
        
        header = MainHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: Constans.ScreenHeight / 1.6))
        tableFeedView.tableHeaderView = header
    }
    //Nav bar init
    private func setUpNavigationBar(){
        var img = UIImage(named: "netflixLogo")
        img = img?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .plain, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func getRandomTrendingMovie(){
        
        APIFunctions.getTrendingMovie { response in
            self.randomTrendingMovie = response.results.randomElement()
            DispatchQueue.main.async {
                self.header?.configureCellPosterImg(posterPath: self.randomTrendingMovie?.poster_path ?? "")
            }
        }
    }
}



//MARK: - TableView Delegates

extension HomeVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCVCellInTVCell.identifer, for: indexPath) as? HomeCVCellInTVCell else{return UITableViewCell()}
        
        cell.delegate = self
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            
            APIFunctions.getTrendingMovie { response in
                cell.configure(with: response.results)
            }
            
        case Sections.TrendingTv.rawValue:
            
            APIFunctions.getTrendingTv { response in
                cell.configure(with: response.results)
            }
            
        case Sections.Popular.rawValue:
            
            APIFunctions.getPopularMovies { response in
                cell.configure(with: response.results)
            }
            
        case Sections.Upcoming.rawValue:
            
            APIFunctions.getUpcommingMovies { response in
                cell.configure(with: response.results)
            }
            
        case Sections.TopRated.rawValue:
            
            APIFunctions.getTopTrendingMovies { response in
                cell.configure(with: response.results)
            }
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constans.ScreenHeight / 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.text? = (header.textLabel?.text?.capitalizeFirstDigit())!
    }
    
}

extension HomeVC: homeCVCellInTVCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: HomeCVCellInTVCell, model : TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = PreviewMoviesVC()
            vc.configure(model: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
