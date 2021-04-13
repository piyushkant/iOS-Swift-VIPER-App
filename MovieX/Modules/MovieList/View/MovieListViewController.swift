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
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "movieCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieTableViewCell
        cell.accessoryType = .disclosureIndicator
       
        let movie = movieArray[indexPath.row]
        
        cell.update(image: UIImage(named: "empty"), title: movie.title, date: movie.relaseDate)
        
        posterStore.fetchImage(for: movie, completion: { (result) -> Void in
            guard let _ = self.movieArray.firstIndex(of: movie),
                case let .success(image) = result else {
                    return
            }
            
  
            cell.update(image: image, title: movie.title, date: movie.relaseDate)
        })
        
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(image: nil, title: nil, date: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(image: nil, title: nil, date: nil)
    }

    func update(image: UIImage?, title: String?, date: String?) {
        posterImageView.image = image
        titleLabel.text = title
        dateLabel.text = date
    }
}
