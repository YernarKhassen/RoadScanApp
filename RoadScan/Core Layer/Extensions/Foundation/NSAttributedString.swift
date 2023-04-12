import UIKit

extension NSAttributedString {
    public convenience init(
        _ string: String,
        _ color: UIColor = .black,
        _ font: UIFont = UIFont.systemFont(ofSize: 14),
        _ alignment: NSTextAlignment = .left,
        _ lineHeight: CGFloat? = nil,
        _ url: URL? = nil
    ) {
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = .byWordWrapping
        var attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle,
            .font: font
        ]
        if let url = url {
            attrs[.link] = url
        }
        self.init(string: string, attributes: attrs)
    }
}

