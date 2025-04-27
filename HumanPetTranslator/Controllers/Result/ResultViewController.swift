import UIKit

class ResultViewController: UIViewController {
    
    
    lazy var resultView: ResultView = {
        $0.delegate = self
        return $0
    }(ResultView())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = resultView
    }
}

extension ResultViewController: ResultViewDelegate {
    func didTapCloseButton() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
