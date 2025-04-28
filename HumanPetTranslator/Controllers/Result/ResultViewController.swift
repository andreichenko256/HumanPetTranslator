import UIKit

final class ResultViewController: UIViewController {
    
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
    
    func updateHumanStatus(isHuman: Bool) {
        resultView.isHuman = isHuman
    }
}

extension ResultViewController: ResultViewDelegate {
    func didTapRepeat() {
        if resultView.isCat {
            AudioPlayerHelper.shared.playSound(named: "meow")
        } else {
            AudioPlayerHelper.shared.playSound(named: "bark")
        }
    }
    
    func didTapCloseButton() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
