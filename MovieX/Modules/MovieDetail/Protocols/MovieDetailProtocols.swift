//
//  MovieDetailProtocols.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/13.
//

import Foundation
import UIKit

protocol ViewToPresenterMovieDetailProtocol: class {
    var view: PresenterToViewMovieDetailProtocol? {get set}
    var interactor: PresenterToInteractorMovieDetailProtocol? {get set}
    var router: PresenterToRouterMovieDetailProtocol? {get set}
    func startFetchingMovieDetail(id: Int)
}

protocol PresenterToViewMovieDetailProtocol: class {
    func showMovieDetail(detail: MovieDetail)
    func showError()
}

protocol PresenterToRouterMovieDetailProtocol: class {
    static func createModule()-> MovieDetailViewController
}

protocol PresenterToInteractorMovieDetailProtocol: class {
    var presenter:InteractorToPresenterMovieDetailProtocol? {get set}
    func fetchMovieDetail(id: Int)
}

protocol InteractorToPresenterMovieDetailProtocol: class {
    func noticeFetchedSuccess(detail: MovieDetail)
    func noticeFetchFailed()
}
