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
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var voteAvgLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
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
        self.adultLabel.text = "Adult: \(detail.adult ?? false)"
        self.budgetLabel.text = "Budget: \(detail.budget ?? 0) USD"
        self.homepageLabel.text = "Homepage: \(detail.homepage ?? "")"
        self.originalLanguageLabel.text = "Original Language: \(detail.originalLanguage ?? "")"
        self.releaseDateLabel.text = "Release Date: \(detail.relaseDate ?? "")"
        self.runtimeLabel.text = "Runtime: \(detail.runtime ?? 0) mins"
        self.statusLabel.text = "Status: \(detail.status ?? "")"
        self.statusLabel.text = "Revenue: \(detail.revenue ?? 0) USD"
    }
}



