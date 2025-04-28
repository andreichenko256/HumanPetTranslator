import UIKit

final class TopContainerView: UIView {
    
    var arrowSwapButtonTapped: (() -> Void)?

    lazy var leftLabel: UILabel = {
        $0.text = "HUMAN"
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textColor = K.Colors.mainTextColor
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var rightLabel: UILabel = {
        $0.text = "PET"
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textColor = K.Colors.mainTextColor
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var arrowSwapButton: UIButton = {
        $0.setImage(UIImage(named: "arrow_swap"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(handleArrowSwapButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TopContainerView {
    func setupUI() {
        [leftLabel, arrowSwapButton, rightLabel].forEach {
            self.addSubview($0)
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
    
    @objc func handleArrowSwapButtonTapped() {
        arrowSwapButtonTapped?()
    }
}
