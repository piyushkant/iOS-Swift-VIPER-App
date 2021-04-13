//
//  UIImageView+Extension.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/13.
//

import SwiftUI

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(urlString: String) {
        
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
