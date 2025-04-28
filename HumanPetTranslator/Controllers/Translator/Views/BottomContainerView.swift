import UIKit
import AVFAudio
import Gifu

final class BottomContainerView: UIView {
    
    var dogButtonTapped: (() -> Void)?
    var catButtonTapped: (() -> Void)?
    var micContainerTapped: (() -> Void)?
    
    lazy var catButton: UIButton = {
        $0.layer.cornerRadius = 8
        $0.setImage(UIImage(named: "cat"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        $0.backgroundColor = K.Colors.catBackground
        $0.imageView?.contentMode = .scaleAspectFit
        $0.adjustsImageWhenHighlighted = false
        $0.alpha = 0.6
        $0.addTarget(self, action: #selector(handleCatButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var dogButton: UIButton = {
        $0.layer.cornerRadius = 8
        $0.setImage(UIImage(named: "dog"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        $0.backgroundColor = K.Colors.dogBackground
        $0.imageView?.contentMode = .scaleAspectFit
        $0.alpha = 1
        $0.adjustsImageWhenHighlighted = false
        $0.addTarget(self, action: #selector(handleDogButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var micContainerView: UIView = {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMicContainerTapped))
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView(frame: .zero))
    
    private lazy var verticalStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 12
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .white
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    lazy var micImageView: UIImageView = {
        $0.image = UIImage(named: "mic")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    lazy var speakLabel: UILabel = {
        $0.text = "Start Speak"
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textColor = K.Colors.mainTextColor
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var waveGifImaveView: GIFImageView = {
        $0.animate(withGIFNamed: "wave")
        $0.isHidden = true
        return $0
    }(GIFImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BottomContainerView {
    
    func setupUI() {
        [micContainerView, verticalStack, waveGifImaveView].forEach {
            self.addSubview($0)
        }
        
        micContainerView.snp.makeConstraints {
            $0.height.equalTo(176)
            $0.width.equalTo(178)
            $0.leading.top.bottom.equalToSuperview()
        }
        
        [micImageView, speakLabel, waveGifImaveView].forEach{
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
        setupVerticalStack()
        
        waveGifImaveView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(7.5)
            $0.trailing.equalToSuperview().offset(-7.5)
            $0.top.equalToSuperview().offset(19)
            $0.bottom.equalToSuperview().offset(-62)
        }
        
        setupShadow()
    }
    
    
    func setupShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 14.3
    }
    
    @objc func handleMicContainerTapped() {
        micContainerTapped?()
        animateBounce(for: micContainerView)
    }
    
    func animateBounce(for view: UIView) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                view.transform = .identity
            }
        })
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
    
    @objc func handleDogButtonTapped() {
        dogButtonTapped?()
    }
    
    @objc func handleCatButtonTapped() {
        catButtonTapped?()
    }
}


