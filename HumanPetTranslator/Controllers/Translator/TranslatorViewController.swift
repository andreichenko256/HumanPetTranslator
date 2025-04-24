import UIKit

class TranslatorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        view = TranslatorView(frame: .zero)
    }
}

@available(iOS 17.0, *)
#Preview {
    TranslatorViewController()
}
