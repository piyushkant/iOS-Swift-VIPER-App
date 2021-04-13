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
    let posterStore = PosterStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.startFetchingMovieList(category: .popular, page: 1)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieTableViewCell
       
        let movie = movieArray[indexPath.row]
        
        guard let id = movie.id, let title = movie.title else {return cell}
        
        if let image = self.presenter?.getMoviePoster(id: id) {
            cell.update(image: image, title: title)
        } else {
            cell.update(image: nil, title: title)
        }
        
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

    func update(image: UIImage?, title: String?) {
        posterImageView.image = image
        titleLabel.text = title
    }
}
