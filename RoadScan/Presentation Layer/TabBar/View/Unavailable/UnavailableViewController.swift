import UIKit
import SnapKit

final class UnavailableViewController: UIViewController {
    
    //MARK: - UI
    private lazy var warningImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
        configure()
    }
    
    private func setupViews() {
        [warningImageView, textLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        warningImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height/4.5)
        }
        textLabel.snp.makeConstraints {
            $0.top.equalTo(warningImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func configure() {
        let warningImage = UIImage(named: RSASsets.warningImage)
        warningImageView.image = UIImage(named: RSASsets.warningImage)
        textLabel.attributedText = Typography.headlineSecond(text: OnboardingConstants.unavailable).styled
    }
}
