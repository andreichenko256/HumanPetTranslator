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
}
