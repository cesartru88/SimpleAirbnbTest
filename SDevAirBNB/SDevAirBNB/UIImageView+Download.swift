//
//  UIImageView+Download.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 24/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

extension UIImageView{

    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill, Callback:@escaping(_ isReady : Bool) ->Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
                Callback(true)
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill, Callback:@escaping(_ isReady : Bool) -> Void) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode) { (ready) in
            Callback(true)
        }
    }


}
