//
//  PreviewMoviesVC.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 12/01/2022.
//

import UIKit
import WebKit

class PreviewMoviesVC: UIViewController {

    //MARK: - Variables
    
    let webKit: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
         lbl.font = .systemFont(ofSize: 20, weight: .bold)
         lbl.text = "dfgfgfdgf"
         lbl.translatesAutoresizingMaskIntoConstraints = false
         return lbl
    }()
    
    let overViewLabel: UILabel = {
        let lbl = UILabel()
         lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.numberOfLines = 0
        lbl.text = "dfgfgfwfsdfdsfdgf"
         lbl.translatesAutoresizingMaskIntoConstraints = false
         return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(webKit)
        view.addSubview(nameLabel)
        view.addSubview(overViewLabel)
        
        addConstraints()

    }
    
    //MARK: - HelperFunctions
    
    private func addConstraints(){
        let webKitConstraints = [
            webKit.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webKit.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webKit.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webKit.heightAnchor.constraint(equalToConstant: Constans.ScreenHeight/3.5)
        ]
        let nameLblConstraints = [
            nameLabel.topAnchor.constraint(equalTo: webKit.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let overLblConstraints = [
            overViewLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10)
        ]
        NSLayoutConstraint.activate(webKitConstraints)
        NSLayoutConstraint.activate(nameLblConstraints)
        NSLayoutConstraint.activate(overLblConstraints)
    }



    func configure(model : TitlePreviewViewModel){
        nameLabel.text = model.title
        overViewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.videoID ?? "")") else {return}
                webKit.load(URLRequest(url: url))
    }
}
