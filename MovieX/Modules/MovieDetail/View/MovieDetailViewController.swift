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
    
    @IBOutlet weak var posterImageView: UIImageView!
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
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var prodCompaniesLabel: UILabel!
    @IBOutlet weak var prodCountriesLabel: UILabel!
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
        if let posterPath = detail.posterPath {
            posterImageView.load(urlString: EndPoint.poster(path: posterPath).url.absoluteString)
        }
        
        self.titleLabel.text = detail.title
        self.overviewTextField.text = detail.overview
        self.adultLabel.text = "Adult: \(detail.adult ?? false)"
        self.budgetLabel.text = "Budget: \(detail.budget ?? 0) USD"
        self.homepageLabel.text = "Homepage: \(detail.homepage ?? "")"
        self.originalLanguageLabel.text = "Original Language: \(detail.originalLanguage ?? "")"
        self.releaseDateLabel.text = "Release Date: \(detail.relaseDate ?? "")"
        self.runtimeLabel.text = "Runtime: \(detail.runtime ?? 0) mins"
        self.statusLabel.text = "Status: \(detail.status ?? "")"
        self.revenueLabel.text = "Revenue: \(detail.revenue ?? 0) USD"
        
        var genr = ""
        var count = 0
        if let genres = detail.genres {
            for genre in genres {
                count += 1
                
                genr = genr + "\(genre.name ?? "")"
                if count < genres.count {genr += ", "}
            }
        }
        self.genresLabel.text = "Genres: \(genr)"
        
        var companies = ""
        count = 0
        if let prodCompanies = detail.prodCompanies {
            for company in prodCompanies {
                count += 1

                companies = companies + "\(company.name ?? "")"
                if count < prodCompanies.count {companies += ", "}
            }
        }
        self.prodCompaniesLabel.text = "Prod Companies: \(companies)"
        
        var countries = ""
        count = 0
        if let prodCountries = detail.prodCountries {
            for country in prodCountries {
                count += 1

                countries = countries + "\(country.name ?? "")"
                if count < prodCountries.count {countries += ", "}
            }
        }
        self.prodCountriesLabel.text = "Prod Countries: \(countries)"
        
        self.voteAvgLabel.text = "Vote average: \(detail.voteAvg ?? 0.0)"
        self.voteCountLabel.text = "Vote count: \(detail.voteCount ?? 0)"
    }
}



