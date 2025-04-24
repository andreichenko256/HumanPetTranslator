import UIKit
import Foundation

struct K {
    static var mainGradientLayer: CAGradientLayer = {
        $0.colors = [
            UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1.0).cgColor,
            UIColor(red: 201/255, green: 255/255, blue: 224/255, alpha: 1.0).cgColor
        ]
        return $0
    }(CAGradientLayer())
}
