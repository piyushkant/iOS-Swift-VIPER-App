//
//  MovieListViewController.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import UIKit
import Alamofire

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter:ViewToPresenterProtocol?
    var movieArray: Array<Movie> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarBackButton()

        self.presenter?.startFetchingMovieList(category: .popular, page: 1)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension MovieListViewController {
    private func setNavigationBarBackButton() {
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.dismissVC))
    }
    
    @objc private func dismissVC() {
        if let nav = self.navigationController {nav.popViewController(animated: true)}
    }
}

extension MovieListViewController: PresenterToViewProtocol {
    func showMovieList(movieArray: Array<Movie>) {
        self.movieArray = movieArray
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView()
    }

    func showError() {
        print("Error in fetching!!!!")
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieTableViewCell
        cell.accessoryType = .disclosureIndicator
       
        let movie = movieArray[indexPath.row]
        
        cell.update(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked row", indexPath.row)
//        presenter?.showMovieController(navigationController: navigationController!)
    }
}

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func update(movie: Movie?) {
        if let posterPath  = movie?.posterPath {
            posterImageView.load(urlString: EndPoint.poster(path: posterPath).url.absoluteString)
        } 

        titleLabel.text = movie?.title
        titleLabel.textColor = .darkGray
        
        dateLabel.text = movie?.relaseDate
        dateLabel.textColor = .lightGray
    }
}
