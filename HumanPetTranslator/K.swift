import UIKit
import Foundation

struct K {
    static var mainGradientLayer: CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1.0).cgColor,
            UIColor(red: 201/255, green: 255/255, blue: 224/255, alpha: 1.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }
    
    struct Colors {
        static let catBackground = UIColor(red: 209/255, green: 231/255, blue: 252/255, alpha: 1.0)
        static let dogBackground = UIColor(red: 236/255, green: 251/255, blue: 199/255, alpha: 1.0)
        static let mainTextColor: UIColor = UIColor(red: 41/255, green: 45/255, blue: 50/255, alpha: 1.0)
        static let cellColorBackground: UIColor = UIColor(red: 214/255, green: 220/255, blue: 255/255, alpha: 1.0)
        
    }
}


