//
//  HomeNavigationTileButton.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-21.
//

import UIKit

@IBDesignable
class HomeNavigationTileButton: UIButton {

    @IBInspectable var homeNavigationTileButton: Bool = false {
        didSet {
            if homeNavigationTileButton {
                layer.cornerRadius = 10.0
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if homeNavigationTileButton {
            layer.cornerRadius = 10.0
        }
    }

}
