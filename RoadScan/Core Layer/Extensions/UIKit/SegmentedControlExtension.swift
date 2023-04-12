//
//  SegmentedControlExtension.swift
//  InRoad
//
//  Created by Dinmukhamed on 19.02.2023.
//

import Foundation
import UIKit
extension UIImage{
    class func getSegRect(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}
extension UISegmentedControl{
   
    func removeBorder(){
        let background = UIImage.getSegRect(color: UIColor.white.cgColor,
                                            andSize: self.bounds.size)
        self.setBackgroundImage (background,
                                 for: .normal,
                                 barMetrics: .default)
        self.setBackgroundImage (background,
                                 for: .selected,
                                 barMetrics: .default)
        self.setBackgroundImage (background,
                                 for: .highlighted,
                                 barMetrics: .default)
        
        let deviderLine = UIImage.getSegRect(
                                 color: UIColor.white.cgColor,
                                 andSize: CGSize(width: 1.0, height: 5))
        
        self.setDividerImage(    deviderLine,
                                 forLeftSegmentState: .selected,
                                 rightSegmentState: .normal,
                                 barMetrics: .default)
    }
}
