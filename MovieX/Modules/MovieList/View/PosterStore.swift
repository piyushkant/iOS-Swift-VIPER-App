//
//  PosterStore.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import UIKit

public enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

public enum ImageError: Error {
    case imageCreationError
}

class PosterStore {
    let imageStore = ImageStore()
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
            
                // Couldn't create an image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ImageError.imageCreationError)
                }
        }
        return .success(image)
    }
    
    func fetchImage(for movie: Movie, completion: @escaping (ImageResult) -> Void) {
        let key = String(describing: movie.id!)
                
        if let image = imageStore.image(forKey: key) {
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
        } else {
            OperationQueue.main.addOperation {
                let noImage = UIImage(named: "poster")!
                completion(.success(noImage))
            }
        }
        
        if let posterPath = movie.posterPath {
            let request = URLRequest(url: EndPoint.poster(path: posterPath).url)
                        
            let task = session.dataTask(with: request) {
                (data, response, error) -> Void in
                
                let result = self.processImageRequest(data: data, error: error)
                
                if case let .success(image) = result {
                    self.imageStore.setImage(image, forKey: key)
                }
                
                OperationQueue.main.addOperation {
                    completion(result)
                }
            }
            task.resume()
        }
    }
}
