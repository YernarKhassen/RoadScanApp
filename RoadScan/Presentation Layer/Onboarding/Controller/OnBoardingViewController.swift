import UIKit
import SnapKit

final class OnBoardingViewController: UIViewController{
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(cellClass: OnBoardingCollectionViewCell.self)
        
        return cv
    }()
    
    //MARK: - Properties
    private var viewModel = OnBoardingVewModel()
    var sections: [Section] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Methods
    func setup() {
        setupViews()
        configureCollectionView()
        setupColors()
        makeConstraints()
        setupSections()
    }
    
    func setupViews() {
        [collectionView].forEach{
            view.addSubview($0)
        }
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupColors() {
        collectionView.backgroundColor = .mainBlue
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func setupSections() {
        sections = viewModel.setupSections()
    }
}

//MARK: - OnBoardingCollectionViewCellDelegate

extension OnBoardingViewController: OnBoardingCollectionViewCellDelegate {
    func cell(_ cell: UICollectionViewCell, nextButtonDidTap button: UIButton) {
        guard let index = collectionView.indexPath(for: cell) else { return }
        
        let row = sections[index.section].rows[index.row]
        switch row {
        case .first, .second:
            viewModel.changeItemIndex(collectionView, index)
        case .third:
            let tabbar = MainBuilder.build()
            tabbar.modalPresentationStyle = .fullScreen
            navigationController?.present(tabbar, animated: true)
        }
    }
}




