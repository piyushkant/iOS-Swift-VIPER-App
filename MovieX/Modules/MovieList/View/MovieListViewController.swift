//
//  MovieListViewController.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import UIKit
import Alamofire

class MovieListViewController: UIViewController {
    
    var movieListCategory: MovieListCategory?
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter:ViewToPresenterMovieListProtocol?
    var movieList: Array<Movie> = Array()
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movieListCategory?.value
        self.setNavigationBarBackCloseButton()

        self.presenter?.startFetchingMovieList(category: movieListCategory ?? .popular, page: page)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension UIViewController {
    func setNavigationBarBackCloseButton() {
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.dismissVC))
    }
    
    @objc private func dismissVC() {
        if let nav = self.navigationController {nav.popViewController(animated: true)}
    }
}

extension MovieListViewController: PresenterToViewMovieListProtocol {
    
    func showMovieList(movieArray: Array<Movie>) {
        self.movieList.append(contentsOf: movieArray)
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView()
    }
    
    func showError() {
        print("Error in fetching movie list!")
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieTableViewCell
       
        let movie = movieList[indexPath.row]
        
        cell.update(movie: movie)
        
        if indexPath.row == movieList.count - 1 {
            page += 1
            self.presenter?.startFetchingMovieList(category: movieListCategory ?? .popular, page: page)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = MovieDetailRouter.createModule()
        view.id = movieList[indexPath.row].id
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
      
        if movieList.count > 0 {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
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
