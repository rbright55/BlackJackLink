//
//  Extensions.swift
//  Blackjack
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Ryan Bright. All rights reserved.
//

import Foundation
import UIKit
import SmartDeviceLink

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
