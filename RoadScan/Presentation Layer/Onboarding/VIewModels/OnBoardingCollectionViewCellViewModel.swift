import Foundation

protocol OnBoardingCollectionViewCellViewModelProtocol {
    var text: NSAttributedString? { get }
    var imageText: String { get }
    var buttonText: NSAttributedString? { get }
}

struct OnBoardingCollectionViewCellViewModel: OnBoardingCollectionViewCellViewModelProtocol {
    
    typealias Row = OnBoardingViewController.Section.Row
    
    //MARK: - Proprties
    let row: Row
    
    //MARK: - OnBoardingCollectionViewCellViewModelProtocol
    var text: NSAttributedString? {
        var text = ""
        switch row {
        case .first:
            text = OnboardingConstants.firstOnboardingText
            return Typography.headlineFirst(text: text, color: .white, textAlignment: .center).styled
        case .second:
            text = OnboardingConstants.secondOnboardingText
            return Typography.headlineSecond(text: text, color: .white, textAlignment: .center).styled
        case .third:
            text = OnboardingConstants.thirdOnboardingText
            return Typography.headlineSecond(text: text, color: .white, textAlignment: .center).styled
        }
    }
    
    var imageText: String {
        switch row {
        case .first:
            return RSASsets.firstOnboardingImage
        case .second:
            return RSASsets.secondOnboardingImage
        case .third:
            return RSASsets.thirdOnboardingImage
        }
    }
    
    var buttonText: NSAttributedString? {
        var text = ""
        switch row {
        case .first, .second:
            text = OnboardingConstants.nextButtonText
        case .third:
            text = OnboardingConstants.allowButtonText
        }
        
        return Typography.buttonMedium(text: text, color: .white).styled
    }
}
