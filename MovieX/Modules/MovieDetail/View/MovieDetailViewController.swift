//
//  MovieDetailViewController.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/13.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {
    
    private let detailTitle = "Detail"
    var id: Int?
    
    var presenter:ViewToPresenterMovieDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = detailTitle
        self.setNavigationBarBackCloseButton()
        
        if let id = self.id {
            self.presenter?.startFetchingMovieDetail(id: id)
        }
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


