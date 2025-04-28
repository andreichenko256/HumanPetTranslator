import UIKit

final class DialogueView: UIView {
    
    lazy var repeatCircleImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "repeat_circle")
        return $0
    }(UIImageView())
    
    lazy var dialogueBubbleView: UIView = {
        $0.backgroundColor = K.Colors.resultDialogueBubbleBackground
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
    lazy var dialogueLabel: UILabel = {
        $0.text = K.petPhrases.randomElement()
        $0.textAlignment = .center
        $0.font = .konKhmerSleokchher(size: 12)
        $0.textColor = K.Colors.mainTextColor
        $0.layer.masksToBounds = true
        return $0
    }(UILabel())
    
    lazy var poligonImageView: UIImageView = {
        $0.image = UIImage(named: "polygon")
        $0.isUserInteractionEnabled = false
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension DialogueView {
    func setupConstraints() {
        [dialogueBubbleView, poligonImageView].forEach {
            addSubview($0)
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
        
        bringSubviewToFront(dialogueBubbleView)
    }
    
    func setupDialogueBubbleView() {
        dialogueBubbleView.addSubview(dialogueLabel)
        
        dialogueLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(22)
        }
    }
} 
