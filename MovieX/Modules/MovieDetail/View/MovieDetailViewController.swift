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
    var detail: MovieDetail?
    var presenter:ViewToPresenterMovieDetailProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextField: UITextView!
    @IBOutlet weak var adultLabel: UILabel!
    
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
        self.detail = detail
        self.setupUI(detail: detail)
    }
    
    func showError() {
        print("Error in fetching movie detail!")
    }
}

extension MovieDetailViewController {
    
    private func setupUI(detail: MovieDetail) {
        self.titleLabel.text = detail.title
        self.overviewTextField.text = detail.overview
        self.adultLabel.text = "Adult: \(detail.adult!)"
    }
}



