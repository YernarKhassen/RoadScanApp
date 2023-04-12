//
//  EndFeedbackViewController.swift
//  InRoad
//
//  Created by Dinmukhamed on 23.02.2023.
//

import UIKit

final class EndFeedbackViewController: UIViewController {

    var label = UILabel()
    var backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialize()
        
    }
    private func initialize() {
        
        view.addSubview(label)
        label.text = "Спасибо!                                     Ваш отзыв успешно отправлен"
        label.textColor = UIColor(red: 0.204, green: 0.204, blue: 0.204, alpha: 1)
        label.font = UIFont(name: "Stolzl-Regular", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(19)
        }

        view.addSubview(backButton)
        backButton.backgroundColor = .mainBlue
        backButton.layer.cornerRadius = 16
        backButton.setTitle("Вернуться к карте", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Stolzl-Medium", size: 16)
        backButton.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(352)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(152)
        }
    }


}
