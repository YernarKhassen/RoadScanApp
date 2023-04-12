import UIKit
import Foundation

protocol OnBoardingVewModelProtocol {
    func setupSections() -> [OnBoardingViewController.Section]
    func changeItemIndex(_ collectionView: UICollectionView, _ index: IndexPath)
}

final class OnBoardingVewModel: OnBoardingVewModelProtocol {
    func setupSections() -> [OnBoardingViewController.Section] {
        var sections: [OnBoardingViewController.Section] = [.init(section: .onboarding, rows: [.first, .second, .third])]
        
        return sections
    }
    
    func changeItemIndex(_ collectionView: UICollectionView, _ index: IndexPath) {
        collectionView.scrollToItem(at: IndexPath(row: index.row+1, section: 0), at: .right, animated: true)
    }
}
