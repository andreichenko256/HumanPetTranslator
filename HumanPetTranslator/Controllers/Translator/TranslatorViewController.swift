import UIKit
import AVFAudio

class TranslatorViewController: UIViewController {
    
    var isHuman: Bool = true
    var isCat: Bool = false
    
    
    lazy var translatorView: TranslatorView = {
        $0.delegate = self
        return $0
    }(TranslatorView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = translatorView
    }
}

private extension TranslatorViewController {
    func startRecordingUI() {
        let bottomContainerAccess = translatorView.bottomContainerView
        bottomContainerAccess.micImageView.isHidden = true
        bottomContainerAccess.waveGifImaveView.isHidden = false
        bottomContainerAccess.speakLabel.text = "Recording..."
        bottomContainerAccess.waveGifImaveView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            stopRecordingUI()
        }
        
    }
    
    func showMicrophoneAccessAlert() {
        AlertHelper.showAlert(title: "Enable Microphone Access",
                              message: """
                                    Please allow access to your microphone to use the app’s
                                    features
                                    """,
                              on: self) {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }
    }
    
    func stopRecordingUI() {
        translatorView.translatorLabel.isHidden = true
        translatorView.topContainerView.isHidden = true
        translatorView.bottomContainerView.isHidden = true
        translatorView.processTranslationLabel.isHidden = false
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            let resultVC = ResultViewController()
            resultVC.resultView.petView.image = translatorView.mainImageView.image
            resultVC.updateHumanStatus(isHuman: isHuman)
            resultVC.resultView.isCat = isCat
            
            if let navigationController = self.navigationController {
                navigationController.isNavigationBarHidden = true
                navigationController.pushViewController(resultVC, animated: true)
            } else {
                print("Error: UINavigationController not found.")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                translatorView.bottomContainerView.speakLabel.text = "Start Speak"
                translatorView.bottomContainerView.micImageView.isHidden = false
                translatorView.bottomContainerView.waveGifImaveView.isHidden = true
                translatorView.translatorLabel.isHidden = false
                translatorView.topContainerView.isHidden = false
                translatorView.bottomContainerView.isHidden = false
                translatorView.processTranslationLabel.isHidden = true
            }
        }
    }
}

extension TranslatorViewController: TranslatorViewDelegate {
    func didArrowSwapButtonTapped() {
        UIView.transition(with: translatorView.topContainerView, duration: 0.3, options: [.transitionFlipFromTop], animations: { [self] in
            let tempText = translatorView.topContainerView.leftLabel.text
            translatorView.topContainerView.leftLabel.text = translatorView.topContainerView.rightLabel.text
            translatorView.topContainerView.rightLabel.text = tempText
        }, completion: nil)
        
        isHuman.toggle()
    }
    
    func didMicContainerTapped() {
        PermissionHelper.requestMicrophonePermission { granted in
            if granted {
                self.startRecordingUI()
            } else {
                self.showMicrophoneAccessAlert()
            }
        }
    }
    
    func didTapDogButton() {
        
        UIView.animate(withDuration: 0.2, animations: { [self] in
            translatorView.mainImageView.alpha = 0
            translatorView.bottomContainerView.catButton.alpha = 0.6
        }) { [self] _ in
            translatorView.mainImageView.image = UIImage(named: "dog")
            
            UIView.animate(withDuration: 0.2) { [self] in
                translatorView.bottomContainerView.dogButton.alpha = 1
                translatorView.mainImageView.alpha = 1
            }
        }
        isCat = false
    }
    
    func didTapCatButton() {
        UIView.animate(withDuration: 0.2, animations: { [self] in
            translatorView.mainImageView.alpha = 0
            translatorView.bottomContainerView.dogButton.alpha = 0.6
        }) { [self] _ in
            translatorView.mainImageView.image = UIImage(named: "cat")
            
            UIView.animate(withDuration: 0.2) { [self] in
                translatorView.bottomContainerView.catButton.alpha = 1
                translatorView.mainImageView.alpha = 1
            }
        }
        isCat = true
    }
}
