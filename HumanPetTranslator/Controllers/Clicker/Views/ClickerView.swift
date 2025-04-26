import UIKit

final class ClickerView: BaseView {
    
    lazy var tableView: SettingsTableView = {
        return $0
    }(SettingsTableView(frame: .zero, style: .plain))
    
    private lazy var settingsLabel: UILabel = {
        $0.textColor = K.Colors.mainTextColor
        $0.textAlignment = .center
        $0.font = .konKhmerSleokchher(size: 32)
        $0.text = "Settings"
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ClickerView {
    func setupConstraints() {
        [settingsLabel, tableView].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        settingsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(12)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(settingsLabel.snp.bottom).inset(-12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
