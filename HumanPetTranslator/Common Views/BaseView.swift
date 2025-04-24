import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first(where: { $0 is CAGradientLayer })?.frame = bounds
    }
    
}

private extension BaseView {
    func setupView() {
        let gradient = K.mainGradientLayer
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
