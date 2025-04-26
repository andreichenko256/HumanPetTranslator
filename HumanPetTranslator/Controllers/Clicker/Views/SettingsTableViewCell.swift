import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = K.Colors.cellColorBackground
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView(frame: .zero))
    
    private lazy var settingNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .konKhmerSleokchher(size: 16)
        $0.textColor = K.Colors.mainTextColor
        return $0
    }(UILabel())
    
    private lazy var arrowImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "arrow_right")
        return $0
    }(UIImageView())
    
    var onContainerTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        contentView.addSubview(containerView)

        containerView.snp.makeConstraints({
            $0.height.equalTo(50)
            $0.top.equalTo(contentView.snp.top)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-14)
        })
        
        [settingNameLabel, arrowImageView].forEach({
            containerView.addSubview($0)
        })
        
        settingNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-14)
            $0.trailing.equalToSuperview().offset(-52)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.bottom.equalToSuperview().offset(-13)
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalTo(settingNameLabel.snp.trailing).inset(-12)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func containerViewTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.containerView.alpha = 0.7
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.containerView.alpha = 1.0
            }
        }
        
        onContainerTap?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
     func configure(text: String) {
        settingNameLabel.text = text
    }
}

