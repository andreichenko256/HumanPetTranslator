import UIKit

class ResultView: BaseView {
    
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
    
    private lazy var dialogueBubbleView: UIView = {
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 4
        return $0
    }(UIView())
    
    private lazy var dialogueLabel: UILabel = {
        $0.backgroundColor = K.Colors.resultDialogueBubbleBackground
        $0.text = "Example example example"
        $0.textAlignment = .center
        $0.font = .konKhmerSleokchher(size: 12)
        $0.textColor = K.Colors.mainTextColor
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
        return $0
    }(UILabel())
    
    private lazy var poligonImageView: UIImageView = {
        $0.image = UIImage(named: "polygon")
        return $0
    }(UIImageView())
    
    private lazy var petImageView: UIImageView = {
        $0.image = UIImage(named: "cat")
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

private extension ResultView {
    func setupConstraints() {

        [headerContainer, dialogueBubbleView].forEach({
            self.addSubview($0)
        })
        
        headerContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
        }
        setupHeaderContainer()
        
        dialogueBubbleView.snp.makeConstraints {
            $0.height.equalTo(142)
            $0.leading.equalToSuperview().offset(49)
            $0.trailing.equalToSuperview().offset(-50)
            $0.top.equalTo(headerContainer.snp.bottom).inset(-91)
        }
        setupDialogueBubbleView()
        
        petImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(184)
            $0.top.equalTo(poligonImageView.snp.bottom).inset(-19.38)
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
        [dialogueLabel, poligonImageView, petImageView].forEach({
            dialogueBubbleView.addSubview($0)
        })
        
        dialogueLabel.snp.makeConstraints {
            $0.height.equalTo(142)
            $0.leading.trailing.equalToSuperview()
        }
        
        poligonImageView.snp.makeConstraints {
            $0.top.equalTo(dialogueLabel.snp.top).inset(98)
            $0.trailing.equalToSuperview().offset(-3.72)
            $0.leading.equalToSuperview().offset(193)
            $0.height.equalTo(170)
        }
        
        dialogueBubbleView.sendSubviewToBack(poligonImageView)
    }
}

private extension ResultView {
    @objc func handleCircleTap() {
        if let navigationController = self.window?.rootViewController as? UINavigationController{
            navigationController.popViewController(animated: true)
        }
    }
}
