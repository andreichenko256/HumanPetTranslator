import UIKit

protocol ResultViewDelegate: AnyObject {
    func didTapCloseButton()
    func didTapRepeat()
}

final class ResultView: BaseView {
    weak var delegate: ResultViewDelegate?
    
    var isCat: Bool = false {
        didSet {
            updateBasedOnHuman()
        }
    }
    
    var isHuman: Bool = true {
        didSet {
            updateBasedOnHuman()
        }
    }
    
    private lazy var headerView: HeaderView = {
        $0.onCloseTapped = { [weak self] in
            self?.delegate?.didTapCloseButton()
        }
        return $0
    }(HeaderView())
    
    private lazy var dialogueView = DialogueView()
    
    lazy var petView = PetView()
 
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
        [headerView, dialogueView, petView].forEach {
            addSubview($0)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
        }
        
        dialogueView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(49)
            $0.trailing.equalToSuperview().offset(-50)
            $0.top.equalTo(headerView.snp.bottom).inset(-91)
            $0.height.equalTo(142)
        }
        
        petView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(184)
            $0.top.equalTo(headerView.snp.bottom).inset(-358)
        }
    }
    
    func updateBasedOnHuman() {
        if isHuman {
            dialogueView.poligonImageView.isHidden = true
            dialogueView.dialogueLabel.text = "Repeat"
            dialogueView.snp.remakeConstraints {
                $0.leading.equalToSuperview().offset(49)
                $0.trailing.equalToSuperview().offset(-50)
                $0.height.equalTo(54)
                $0.bottom.equalTo(petView.snp.top).inset(-125)
            }
            
            dialogueView.dialogueLabel.snp.remakeConstraints({
                $0.trailing.equalToSuperview().offset(-111.5)
                $0.centerY.equalToSuperview()

            })
            
            dialogueView.addSubview(dialogueView.repeatCircleImageView)
            dialogueView.repeatCircleImageView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(dialogueView.dialogueLabel.snp.leading).inset(-10)
                $0.width.height.equalTo(16)
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDialogueViewTapped))
            dialogueView.addGestureRecognizer(tapGesture)
            if isCat {
                AudioPlayerHelper.shared.playSound(named: "meow")
            } else {
                AudioPlayerHelper.shared.playSound(named: "bark")
            }
        }

    }
    
    @objc func handleDialogueViewTapped() {
        delegate?.didTapRepeat()
    }
}
