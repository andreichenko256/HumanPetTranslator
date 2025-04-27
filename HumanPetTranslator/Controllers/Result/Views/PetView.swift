import UIKit

final class PetView: UIImageView {
    
    var petName: String?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        image = UIImage(named: petName ?? "cat")
        contentMode = .scaleAspectFit
    }
}
