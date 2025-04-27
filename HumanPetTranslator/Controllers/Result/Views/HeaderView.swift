import UIKit

final class HeaderView: UIView {
    
    private lazy var resultLabel: UILabel = {
        $0.text = "Result"
        $0.textAlignment = .center
        $0.font = .konKhmerSleokchher(size: 32)
        $0.textColor = K.Colors.mainTextColor
        return $0
    }(UILabel())
    
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
    
    var onCloseTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HeaderView {
    func setupConstraints() {
        [resultLabel, cirlceView].forEach {
            addSubview($0)
        }
        
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
    
    @objc func handleCircleTap() {
        onCloseTapped?()
    }
} 
