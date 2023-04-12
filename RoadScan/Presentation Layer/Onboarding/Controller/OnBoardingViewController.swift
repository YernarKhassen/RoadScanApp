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
    var sections: [Section] = [.init(section: .onboarding, rows: [.first, .second, .third])]
    
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
}

//MARK: - OnBoardingCollectionViewCellDelegate

extension OnBoardingViewController: OnBoardingCollectionViewCellDelegate {
    func cell(_ cell: UICollectionViewCell, nextButtonDidTap button: UIButton) {
        guard let index = collectionView.indexPath(for: cell)?.row else { return }
        if (index < 2) {
            collectionView.scrollToItem(at: IndexPath(row: index+1, section: 0), at: .right, animated: true)
        } else {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}




