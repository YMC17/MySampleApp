//
//  UIImageView+Extension.swift
//  TestApp
//
//  Created by MOUNICA CHOWDARY  YELISETTI on 2018-08-23.
//  Copyright © 2018 MOUNICA CHOWDARY  YELISETTI. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
