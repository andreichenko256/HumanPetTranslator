import UIKit

final class SettingsTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsTableView {
    func setupTableView() {
        self.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        self.isScrollEnabled = false
        self.separatorStyle = .none
        self.backgroundColor = .clear
    }
}
