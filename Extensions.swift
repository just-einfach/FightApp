import UIKit

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
     static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
     static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
     static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
     static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
     static let flipside = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
       static let aquaBlue = UIColor(red:0.00, green:0.50, blue:1.00, alpha:1.0)
       static let snow = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
       static let tungsten = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
       static let strawberry = UIColor(red:0.999, green:0.184, blue:0.572, alpha:1.0)
       static let blackTranslucent = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.1)
       static let black = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)
       static let red = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)
       static let groupTable = UIColor(red:0.92, green:0.92, blue:0.95, alpha:1.0)
       
       static let lime = UIColor(red:0.00, green:1.00, blue:0.00, alpha:1.0)
       static let lemon = UIColor(red:1.00, green:1.00, blue:0.00, alpha:1.0)
       static let summerSky = UIColor(red:0.00, green:0.68, blue:1.00, alpha:1.0)
       
}

