//
//  ViewController.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import UIKit

class CategoryListViewController: UITableViewController {
    
    private let listTitle = "MovieX"
    private let headerTitle = "Select a movie category"
    private let category = [MovieListCategory.popular.value, MovieListCategory.topRated.value, MovieListCategory.nowPlaying.value, MovieListCategory.upcoming.value]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.title = self.listTitle
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        
        let textLabel = cell.textLabel
        textLabel?.text = self.category[indexPath.row]
        textLabel?.font =  UIFont.boldSystemFont(ofSize: 17.0)
        textLabel?.textColor = .darkGray
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieListVC = MovieListRouter.createModule()
        movieListVC.movieListCategory = getMovieListCategory(row: indexPath.row)
        self.navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    private func getMovieListCategory(row: Int) -> MovieListCategory {
        switch row {
        case 0:
            return .popular
        case 1:
            return .topRated
        case 2:
            return .nowPlaying
        case 3:
            return .upcoming
        default:
            return .popular
        }
    }
}
