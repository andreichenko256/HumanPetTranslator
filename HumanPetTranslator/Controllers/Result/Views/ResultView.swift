import UIKit

class ResultView: BaseView {
    
    private var isStateChanged = false
    
    private lazy var repeatCircleImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "repeat_circle")
        return $0
    }(UIImageView())
    
    private lazy var headerContainer: UIView = {
        return $0
    }(UIView())
    
    private lazy var cirlceView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCircleTap))
        $0.addGestureRecognizer(tapGestureRecognizer)
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    private lazy var closeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "close")
        return $0
    }(UIImageView())
    
    private lazy var resultLabel: UILabel = {
        $0.text = "Result"
        $0.textAlignment = .center
        $0.font = .konKhmerSleokchher(size: 32)
        $0.textColor = K.Colors.mainTextColor
        return $0
    }(UILabel())
    
    private lazy var dialogueContainer: UIView = {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 4
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleRepeatTap))
        $0.addGestureRecognizer(tapGestureRecognizer)
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    private lazy var dialogueBubbleView: UIView = {
        $0.backgroundColor = K.Colors.resultDialogueBubbleBackground
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
    private lazy var dialogueLabel: UILabel = {
        $0.text = "Example example example"
        $0.textAlignment = .center
        $0.font = .konKhmerSleokchher(size: 12)
        $0.textColor = K.Colors.mainTextColor
        $0.layer.masksToBounds = true
        $0.isUserInteractionEnabled = false
        return $0
    }(UILabel())
    
    private lazy var poligonImageView: UIImageView = {
        $0.image = UIImage(named: "polygon")
        $0.isUserInteractionEnabled = false
        return $0
    }(UIImageView())
    
    private lazy var petImageView: UIImageView = {
        $0.image = UIImage(named: "cat")
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            poligonImageView.isHidden = true
            dialogueLabel.text = "Repeat"
            
            dialogueContainer.snp.remakeConstraints {
                $0.leading.equalToSuperview().offset(49)
                $0.trailing.equalToSuperview().offset(-50)
                $0.bottom.equalTo(petImageView.snp.top).inset(-125)
                $0.height.equalTo(54)
            }
            
            dialogueContainer.addSubview(repeatCircleImageView)
            repeatCircleImageView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(111.5)
                $0.trailing.equalTo(dialogueLabel.snp.leading).inset(10)
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(16)
            }
            
            dialogueLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-111.5)
            }
            
            isStateChanged = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ResultView {
    
    func setupConstraints() {

        [headerContainer, dialogueContainer, petImageView].forEach({
            self.addSubview($0)
        })
        
        headerContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
        }
        setupHeaderContainer()
        
        dialogueContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(49)
            $0.trailing.equalToSuperview().offset(-50)
            $0.top.equalTo(headerContainer.snp.bottom).inset(-91)
            $0.height.equalTo(142)
        }
        setupDialogueContainer()
        
        petImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(184)
            $0.top.equalTo(headerContainer.snp.bottom).inset(-358)
        }
    }
    
    func setupHeaderContainer() {
        [resultLabel, cirlceView].forEach({
            headerContainer.addSubview($0)
        })
        
        resultLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        cirlceView.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        setupCircleView()
    }
    
    func setupCircleView() {
        cirlceView.addSubview(closeImageView)
        
        closeImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(28)
        }
    }
    
    func setupDialogueBubbleView() {
        [dialogueLabel].forEach({
            dialogueBubbleView.addSubview($0)
        })
        
        dialogueLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(22)
        }

    }
    
    func setupDialogueContainer() {
        [dialogueBubbleView, poligonImageView].forEach {
            dialogueContainer.addSubview($0)
        }
        
        dialogueBubbleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview()
        }
        setupDialogueBubbleView()
        
        poligonImageView.snp.makeConstraints {
            $0.top.equalTo(dialogueBubbleView.snp.top).inset(98)
            $0.trailing.equalToSuperview().offset(-3.72)
            $0.leading.equalToSuperview().offset(193)
            $0.height.equalTo(170)
        }
        dialogueContainer.bringSubviewToFront(dialogueBubbleView)
    }
}

private extension ResultView {
    @objc func handleCircleTap() {
        if let navigationController = self.window?.rootViewController as? UINavigationController{
            navigationController.popViewController(animated: true)
        }
    }
    
    @objc func handleRepeatTap() {
        if isStateChanged {
            poligonImageView.isHidden = false
            dialogueLabel.text = "Example example example"
            repeatCircleImageView.removeFromSuperview()
            dialogueContainer.snp.remakeConstraints {
                $0.leading.equalToSuperview().offset(49)
                $0.trailing.equalToSuperview().offset(-50)
                $0.top.equalTo(headerContainer.snp.bottom).inset(-91)
                $0.height.equalTo(142)
            }
            
            dialogueLabel.snp.remakeConstraints {
                $0.centerX.centerY.equalToSuperview()
                $0.height.equalTo(22)
            }


            self.isStateChanged = false
        }
    }
}
