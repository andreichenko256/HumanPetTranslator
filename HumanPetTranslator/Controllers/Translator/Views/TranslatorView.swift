import UIKit

protocol TranslatorViewDelegate: AnyObject {
    func didTapDogButton()
    func didTapCatButton()
    func didMicContainerTapped()
    func didArrowSwapButtonTapped()
}

final class TranslatorView: BaseView {
    
    weak var delegate: TranslatorViewDelegate?
    
    lazy var translatorLabel: UILabel = {
        $0.text = "Translator"
        $0.textColor = K.Colors.mainTextColor
        $0.font = .konKhmerSleokchher(size: 32)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var processTranslationLabel: UILabel = {
        $0.text = "Process of translation..."
        $0.textColor = K.Colors.mainTextColor
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textAlignment = .center
        $0.isHidden = true
        return $0
    }(UILabel())
    
    lazy var topContainerView: TopContainerView = {
        $0.arrowSwapButtonTapped = { [weak self] in
            self?.delegate?.didArrowSwapButtonTapped()
        }
        return $0
    }(TopContainerView())
    
    lazy var bottomContainerView: BottomContainerView  = {
        $0.dogButtonTapped = { [weak self] in
            self?.delegate?.didTapDogButton()
        }
        $0.catButtonTapped = { [weak self] in
            self?.delegate?.didTapCatButton()
        }
        $0.micContainerTapped = { [weak self] in
            self?.delegate?.didMicContainerTapped()
        }
        
        return $0
    }(BottomContainerView())
    
    lazy var mainImageView: UIImageView = {
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
        [translatorLabel, topContainerView, bottomContainerView, mainImageView, processTranslationLabel].forEach {
            self.addSubview($0)
        }
        
        translatorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(80)
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
        
        processTranslationLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-411)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
    }
}
