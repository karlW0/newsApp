//
//  Theme.swift
//  News
//
//  Created by Ivan Depolo on 30/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import UIKit

class Theme {
    
    class Fonts {
        class func title( size: CGFloat ) -> UIFont {
            return UIFont(name: "AvenirNextCondensed-DemiBold", size: size)!
        }
        class func content( size: CGFloat ) -> UIFont {
            return UIFont(name: "AvenirNextCondensed-Regular", size: size)!
        }
    }
    
    class Color {
        class var lessBrightText: UIColor {
            return UIColor(red: 111/255.0, green: 112/255.0, blue: 113/255.0, alpha: 1)
        }
        class var brighterText: UIColor {
            return UIColor(red: 188/255.0, green: 188/255.0, blue: 188/255.0, alpha: 1)
        }
    }
    
}
