import UIKit

class ClickerViewController: UIViewController  {
    
    private let settingsItems = [
        "Rate Us", "Share App",
        "Contact Us", "Restore Purchases",
        "Privacy Policy", "Terms of Use",
    ]
    
    var clickerView: ClickerView! {
        return view as? ClickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickerView.tableView.dataSource = self
        clickerView.tableView.delegate = self
    }
    
    override func loadView() {
        view = ClickerView()
    }
}

extension ClickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
        cell.configure(text: settingsItems[indexPath.row])
        
        
        cell.onContainerTap = { [weak self] in
            self?.handleCellTap(at: indexPath)
        }
        return cell
    }
    
    private func handleCellTap(at indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                // Handle "Rate Us"
                if let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID?action=write-review") {
                    UIApplication.shared.open(url)
                }
            case 1:
                // Handle "Share App"
                let items: [Any] = ["Check out this app!", URL(string: "https://app-url.com")!]
                let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                present(activityController, animated: true)
            case 2:
                // Handle "Contact Us"
                if let url = URL(string: "mailto:support@company.com") {
                    UIApplication.shared.open(url)
                }
            case 3:
                // Handle "Restore Purchases"
                print("Restore Purchases tapped")
            case 4:
                // Handle "Privacy Policy"
                if let url = URL(string: "https://url.com/privacy-policy") {
                    UIApplication.shared.open(url)
                }
            case 5:
                // Handle "Terms of Use"
                if let url = URL(string: "https://app-url.com/terms-of-use") {
                    UIApplication.shared.open(url)
                }
            default:
                break
            }
        
    }
    
}
