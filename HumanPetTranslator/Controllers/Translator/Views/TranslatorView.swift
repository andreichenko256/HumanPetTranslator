import UIKit
import AVFAudio
import Gifu

final class TranslatorView: BaseView {
    
    private var isCatButtonActive = false
    private var isDogButtonActive = true
    
    private lazy var waveGifImaveView: GIFImageView = {
        $0.animate(withGIFNamed: "wave")
        return $0
    }(GIFImageView())
    
    private lazy var translatorLabel: UILabel = {
        $0.text = "Translator"
        $0.textColor = K.Colors.mainTextColor
        $0.font = .konKhmerSleokchher(size: 32)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var catButton: UIButton = {
        $0.layer.cornerRadius = 8
        $0.setImage(UIImage(named: "cat"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        $0.backgroundColor = K.Colors.catBackground
        $0.imageView?.contentMode = .scaleAspectFit
        $0.adjustsImageWhenHighlighted = false
        $0.alpha = 0.6
        $0.addTarget(self, action: #selector(handleCatButtonTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var dogButton: UIButton = {
        $0.layer.cornerRadius = 8
        $0.setImage(UIImage(named: "dog"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        $0.backgroundColor = K.Colors.dogBackground
        $0.imageView?.contentMode = .scaleAspectFit
        $0.alpha = 1
        $0.adjustsImageWhenHighlighted = false
        $0.addTarget(self, action: #selector(handleDogButtonTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var topContainerView: UIView = {
        return $0
    }(UIView(frame: .zero))
    
    private lazy var bottomContainerView: UIView = {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 14.3
        return $0
    }(UIView(frame: .zero))
    
    private lazy var micContainerView: UIView = {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(micContainerTapped))
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView(frame: .zero))
    
    private lazy var processTranslationLabel: UILabel = {
        $0.text = "Process of translation..."
        $0.textColor = K.Colors.mainTextColor
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var leftLabel: UILabel = {
        $0.text = "HUMAN"
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textColor = K.Colors.mainTextColor
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var rightLabel: UILabel = {
        $0.text = "PET"
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textColor = K.Colors.mainTextColor
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var arrowSwapButton: UIButton = {
        $0.setImage(UIImage(named: "arrow_swap"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(arrowSwappButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var speakLabel: UILabel = {
        $0.text = "Start Speak"
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textColor = K.Colors.mainTextColor
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var verticalStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 12
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .white
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private lazy var micImageView: UIImageView = {
        $0.image = UIImage(named: "mic")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private lazy var mainImageView: UIImageView = {
        $0.image = UIImage(named: "dog")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TranslatorView {
    
    func setupConstraints() {
        [translatorLabel, topContainerView, bottomContainerView, mainImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        translatorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
        }
        
        topContainerView.snp.makeConstraints {
            $0.height.equalTo(61)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(translatorLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        bottomContainerView.snp.makeConstraints {
            $0.bottom.equalTo(mainImageView.snp.top).inset(-51)
            $0.leading.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().offset(-35)
        }
        
        mainImageView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(184)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-134)
        })
        
        setupTopContainer()
        setupBottomContainer()
        setupVerticalStack()
    }
    
    func setupVerticalStack() {
        let paddedCat = wrappedWithPadding(catButton, insets: UIEdgeInsets(top: 12,
                                                                           left: 12,
                                                                           bottom: 0,
                                                                           right: 12))
        let paddedDog = wrappedWithPadding(dogButton, insets: UIEdgeInsets(top: 0,
                                                                           left: 12,
                                                                           bottom: 12,
                                                                           right: 12))
        
        verticalStack.addArrangedSubview(paddedCat)
        verticalStack.addArrangedSubview(paddedDog)
    }
    
    func wrappedWithPadding(_ view: UIView, insets: UIEdgeInsets) -> UIView {
        let container = UIView()
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(
                UIEdgeInsets(
                    top: insets.top,
                    left: insets.left + 6.5,
                    bottom: insets.bottom,
                    right: insets.right + 6.5
                )
            )
        }
        return container
    }
    
    func setupBottomContainer() {
        [micContainerView, verticalStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            bottomContainerView.addSubview($0)
        }
        
        
        micContainerView.snp.makeConstraints {
            $0.height.equalTo(176)
            $0.width.equalTo(178)
            $0.leading.top.bottom.equalToSuperview()
        }
        
        [micImageView, speakLabel].forEach{
            micContainerView.addSubview($0)
        }
        
        micImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(47.5)
            $0.trailing.equalToSuperview().offset(-54)
            $0.leading.equalToSuperview().offset(54)
            $0.bottom.equalToSuperview().offset(-62)
        }
        
        speakLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(micImageView.snp.bottom).inset(-24)
        }
        
        verticalStack.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview()
            $0.leading.equalTo(micContainerView.snp.trailing).inset(-35)
        }
    }
    
    func setupTopContainer() {
        [leftLabel, arrowSwapButton, rightLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            topContainerView.addSubview($0)
        }
        
        leftLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(arrowSwapButton.snp.leading).offset(-8)
        }
        
        arrowSwapButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        rightLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(arrowSwapButton.snp.trailing).offset(8)
        }
    }
    
    @objc func handleCatButtonTap() {
        guard !isCatButtonActive else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.mainImageView.alpha = 0
            self.dogButton.alpha = 0.6
        }) { _ in
            self.mainImageView.image = UIImage(named: "cat")
            
            UIView.animate(withDuration: 0.2) {
                self.catButton.alpha = 1
                self.mainImageView.alpha = 1
            }
        }
        
        isCatButtonActive.toggle()
        isDogButtonActive.toggle()
    }
    
    @objc func handleDogButtonTap() {
        guard !isDogButtonActive else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.mainImageView.alpha = 0
            self.catButton.alpha = 0.6
        }) { _ in
            self.mainImageView.image = UIImage(named: "dog")
            
            UIView.animate(withDuration: 0.2) {
                self.dogButton.alpha = 1
                self.mainImageView.alpha = 1
            }
        }
        
        isDogButtonActive.toggle()
        isCatButtonActive.toggle()
    }
    
    @objc func micContainerTapped() {
        animateBounce(for: micContainerView)
        AVAudioApplication.requestRecordPermission { granted in
            DispatchQueue.main.async {
                if granted {
                    self.startRecordingUI()
                } else {
                    self.showMicrophoneAccessAlert()
                }
            }
        }
    }
    
    private func animateBounce(for view: UIView) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                view.transform = .identity
            }
        })
    }
    
    @objc func arrowSwappButtonTapped() {
        UIView.transition(with: topContainerView, duration: 0.3, options: [.transitionFlipFromTop], animations: {
            let tempText = self.leftLabel.text
            self.leftLabel.text = self.rightLabel.text
            self.rightLabel.text = tempText
        }, completion: nil)
    }
    
    private func startRecordingUI() {
        micImageView.isHidden = true
        waveGifImaveView.isHidden = false
        speakLabel.text = "Recording..."
        micContainerView.addSubview(waveGifImaveView)
        
        waveGifImaveView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(7.5)
            $0.trailing.equalToSuperview().offset(-7.5)
            $0.top.equalToSuperview().offset(19)
            $0.bottom.equalToSuperview().offset(-62)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5)  { [self] in
            stopRecordingUI()
        }
    }
    
    private func stopRecordingUI() {
        print("recording stopped")
        self.addSubview(processTranslationLabel)
        
        processTranslationLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-411)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        translatorLabel.isHidden = true
        topContainerView.isHidden = true
        bottomContainerView.isHidden = true
        processTranslationLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            let resultVC = ResultViewController()
            
            if let navigationController = self.window?.rootViewController as? UINavigationController {
                navigationController.isNavigationBarHidden = true
                navigationController.pushViewController(resultVC, animated: true)
            } else {
                print("Error: UINavigationController not found.")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                speakLabel.text = "Start Speak"
                micImageView.isHidden = false
                waveGifImaveView.isHidden = true
                translatorLabel.isHidden = false
                topContainerView.isHidden = false
                bottomContainerView.isHidden = false
                processTranslationLabel.isHidden = true
            }
        }

    }
}

extension TranslatorView {
    private func showMicrophoneAccessAlert() {
        let alert = UIAlertController(
            title: "Enable Microphone Access",
            message:
            """
            Please allow access to your mircophone to use the app’s
            features
            """,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let viewController = self.window?.rootViewController {
            viewController.present(alert, animated: true)
        }
    }
    
    func doTranslationProcess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
        }
    }
}
