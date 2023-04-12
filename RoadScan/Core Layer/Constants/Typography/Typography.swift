import UIKit

public enum Typography {
    case headlineFirst(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case headlineSecond(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case headlineThird(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case bodyFirstRegular(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case bodySecondRegular(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case buttonMedium(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    
    public var styled: NSAttributedString {
        switch self {
        case let .headlineFirst(text, color, textAlignment, url):
            guard let font = TypographyFonts.hedlineFirst else {return NSAttributedString()}
            return NSAttributedString(text, color, font, textAlignment, 43, url)
        case let .headlineSecond(text, color, textAlignment, url):
            guard let font = TypographyFonts.hedlineSecond else {return NSAttributedString()}
            return NSAttributedString(text, color, font, textAlignment, 29, url)
        case let .headlineThird(text, color, textAlignment, url):
            guard let font = TypographyFonts.hedlineThird else {return NSAttributedString()}
            return NSAttributedString(text, color, font, textAlignment, 18, url)
        case .bodyFirstRegular(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            guard let font = TypographyFonts.bodyFirstRegular else {return NSAttributedString()}
            return NSAttributedString(text, color, font, textAlignment, 22.4, url)
        case .bodySecondRegular(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            guard let font = TypographyFonts.bodySecondRegular else {return NSAttributedString()}
            return NSAttributedString(text, color, font, textAlignment, 16.8, url)
        case .buttonMedium(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            guard let font = TypographyFonts.buttonMedium else {return NSAttributedString()}
            return NSAttributedString(text, color, font, textAlignment, 20.8, url)
        }
    }
}


