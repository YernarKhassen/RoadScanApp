//
//  SettingsCell.swift
//  InRoad
//
//  Created by Dinmukhamed on 20.02.2023.
//

import Foundation
import UIKit
import SnapKit

final class SettingsCell: UITableViewCell {
    

    let label = UILabel()
    let button = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension SettingsCell{
    

    private func initialize(){
    
        self.addSubview(label)
        label.font = UIFont(name: "Stolzl-Regular", size: 16)
        label.textColor = UIColor(red: 0.204, green: 0.204, blue: 0.204, alpha: 1)
        label.snp.makeConstraints{ maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().inset(19)
        }
        self.addSubview(button)
        button.setBackgroundImage(UIImage(named: "Vector"), for: .normal)
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.right.equalToSuperview().inset(19)
        }
    }
    
    
}
