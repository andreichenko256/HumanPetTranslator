import UIKit
import SnapKit

class CustomTabBarController: UIViewController {
    
    enum Tab: Int {
        case translator
        case clicker
    }
    
    private var selectedTab: Tab = .translator {
        didSet {
            updateSelection()
            updateViewController()
        }
    }
    
    private var buttons: [Tab: UIButton] = [:]
    private var currentViewController: UIViewController?
    
    private lazy var contentView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView(frame: .zero))
    
    lazy var containerView: UIView = {
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView(frame: .zero))

    private lazy var buttonContainerView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        return $0
    }(UIView(frame: .zero))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContentView()
        view.addSubview(containerView)
        setupConstraints()
        setupButtons()
        updateViewController()
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

private extension CustomTabBarController {
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.height.equalTo(82)
            $0.width.equalTo(216)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    func setupButtons() {
        containerView.addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let translatorButton = createButton(
            title: "Translator",
            image: UIImage(named: "translator"),
            for: .translator
        )
        let clickerButton = createButton(
            title: "Clicker",
            image: UIImage(named: "clicker"),
            for: .clicker
        )
        
        buttons[.translator] = translatorButton
        buttons[.clicker] = clickerButton
        
        [translatorButton, clickerButton].forEach {
            buttonContainerView.addSubview($0)
        }

        translatorButton.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(buttonContainerView.snp.centerX)
        }

        clickerButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(buttonContainerView.snp.centerX)
        }
        
        updateSelection()
    }
    
    func createButton(title: String, image: UIImage?, for tab: Tab) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = tab.rawValue
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.isUserInteractionEnabled = false
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.image = image
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }

        let label = UILabel()
        label.text = title
        label.font = .konKhmerSleokchher(size: 12)
        label.textColor = UIColor(red: 41/255, green: 45/255, blue: 50/255, alpha: 1)
        
        [imageView, label].forEach({ stack.addArrangedSubview($0) })
        
        button.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let tab = Tab(rawValue: sender.tag) else { return }
        selectedTab = tab
    }
    
    func updateSelection() {
        buttons.forEach { tab, button in
            let isSelected = tab == selectedTab
            let fontOpacity: CGFloat = isSelected ? 1 : 0.6
            button.subviews.forEach { subview in
                if let stack = subview as? UIStackView {
                    stack.arrangedSubviews.forEach { view in
                        if let imageView = view as? UIImageView {
                            imageView.layer.opacity = Float(fontOpacity)
                        } else if let label = view as? UILabel {
                            label.layer.opacity = Float(fontOpacity)
                        }
                    }
                }
            }
        }
    }
    
    func updateViewController() {
        // Remove current view controller
        currentViewController?.willMove(toParent: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()
        
        // Create and add new view controller
        let newViewController: UIViewController
        switch selectedTab {
        case .translator:
            newViewController = TranslatorViewController()
        case .clicker:
            newViewController = ClickerViewController()
        }
        
        addChild(newViewController)
        contentView.addSubview(newViewController.view)
        newViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        newViewController.didMove(toParent: self)
        
        currentViewController = newViewController
    }
}
