import UIKit

class ResultView: BaseView {
    weak var delegate: ResultViewDelegate?
    
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
}

protocol ResultViewDelegate: AnyObject {
    func didTapCloseButton()
}
