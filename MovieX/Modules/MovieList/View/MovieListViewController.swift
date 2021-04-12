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
    
    var presentor:ViewToPresenterProtocol?
    var movieArray: Array<Movie> = Array()
    let posterStore = PosterStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presentor?.startFetchingMovieList(category: .popular, page: 1)
        
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
        
        posterStore.fetchImage(for: movie, completion: { (result) -> Void in
            
            guard let _ = self.movieArray.firstIndex(of: movie),
                case let .success(image) = result else {
                    return
            }
            
            cell.update(image: image, title: movie.title)
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked row", indexPath.row)
//        presentor?.showMovieController(navigationController: navigationController!)
    }
}

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(image: nil, title: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(image: nil, title: nil)
    }
    
    func update(image: UIImage?, title: String?) {
        posterImageView.image = image
        titleLabel.text = title
    }
}
