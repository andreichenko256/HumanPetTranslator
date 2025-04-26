import UIKit

final class ClickerView: BaseView {
    
    private lazy var settingLabel: UILabel = {
        $0.textColor = K.Colors.mainTextColor
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ClickerView {
    
}
