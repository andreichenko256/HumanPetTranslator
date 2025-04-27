import UIKit

class AlertHelper {
    static func showAlert(title: String, message: String, on viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            completion?()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        viewController.present(alert, animated: true)
    }
}
