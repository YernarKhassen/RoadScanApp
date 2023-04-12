import UIKit

protocol OnBoardingCollectionViewCellDelegate: AnyObject {
    func cell(_ cell: UICollectionViewCell, nextButtonDidTap button: UIButton)
}

final class OnBoardingCollectionViewCell : UICollectionViewCell{
    // MARK: - Properties
    weak var delegate: OnBoardingCollectionViewCellDelegate?
    
    //MARK: - Views
    private lazy var imageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .top
        
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 253, green: 253, blue: 254, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .onboardingWhiteBlue
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    @objc
    private func nextButtonDidTap(_ sender: UIButton) {
        delegate?.cell(self, nextButtonDidTap: sender)
    }
    
    func setup() {
        setupViews()
        makeConstraints()
    }
    
    func setupViews() {
        [imageView, textLabel, nextButton].forEach{
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2)
        }
        
        textLabel.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom).inset(32)
            make.leading.trailing.equalToSuperview().inset(32.0)
            make.height.equalTo(UIScreen.main.bounds.height/4)
        }
        
        nextButton.snp.makeConstraints{ make in
            make.height.equalTo(UIScreen.main.bounds.height/16)
            make.top.equalTo(textLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    public func configure(with viewModel:OnBoardingCollectionViewCellViewModelProtocol) {
        textLabel.attributedText = viewModel.text
        imageView.image = UIImage(named: viewModel.imageText)
        nextButton.setAttributedTitle(viewModel.buttonText, for: .normal)
    }
}
