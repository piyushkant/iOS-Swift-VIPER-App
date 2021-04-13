//
//  MovieDetailViewController.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/13.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {
    
    var presenter:ViewToPresenterMovieDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailViewController: PresenterToViewMovieDetailProtocol {
    func showMovieDetail(detail: MovieDetail) {
        print("showMovieDetail", detail)
    }
    
    func showError() {
        print("Error in fetching movie detail!")
    }
}
