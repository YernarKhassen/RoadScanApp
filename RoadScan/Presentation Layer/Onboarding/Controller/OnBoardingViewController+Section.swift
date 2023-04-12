extension OnBoardingViewController {
    struct Section {
        enum Section {
            case onboarding
        }
        
        enum Row {
            case first
            case second
            case third
        }
        
        let section: Section
        var rows: [Row]
    }
}
