//
//  Colors.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI
import UIKit

// MARK: - Public Constants
public extension UIColor {

    static let mainColor = colorFromAsset(.mainColor)
    static let buttonColor = colorFromAsset(.buttonColor)
    static let playButtonColor = colorFromAsset(.playButtonColor)
    static let whiteButton = colorFromAsset(.whitebutton)
    static let connectColor = colorFromAsset(.connectcolor)
    static let customRed = colorFromAsset(.customred)

    /// UIColor to SwiftUI Color
    var asColor: Color { Color(self) }
}

// MARK: - Private Methods
private extension UIColor {
    
    static func colorFromAsset(_ assetColorIdentifier: AssetColorIdentifier) -> UIColor {
        guard let color = UIColor(named: assetColorIdentifier.rawValue, in: nil, compatibleWith: nil) else {
            fatalError("Verify the color name and be sure it's contained in Assets")
        }
        return color
    }
    
    // MARK: - Private Enum
    enum AssetColorIdentifier: String {
        case mainColor = "mainColor"
        case buttonColor = "buttonColor"
        case playButtonColor = "playButtonColor"
        case whitebutton = "whitebutton"
        case connectcolor = "connectcolor"
        case customred = "customred"
    }
}

