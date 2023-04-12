//
//  FeedbackViewController.swift
//  InRoad
//
//  Created by Dinmukhamed on 23.02.2023.
//

import UIKit

final class FeedbackViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        initialize()
        makeConstraints()
    }
    
    private lazy var label: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Оставьте отзыв, чтобы повлиять на качество дорог в республике"
        label.textColor = UIColor(red: 0.204, green: 0.204, blue: 0.204, alpha: 1)
        label.font = UIFont(name: "Stolzl-Regular", size: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        
        let nameTextField = UITextField()
        nameTextField.layer.cornerRadius = 16
        nameTextField.layer.borderColor = UIColor(red: 0.938, green: 0.938, blue: 0.938, alpha: 1).cgColor
        nameTextField.layer.borderWidth = 2
        nameTextField.placeholder = "      Ваше имя"
        
        return nameTextField
    }()
    private lazy var numberTextField: UITextField = {
        
        let numberTextField = UITextField()
        numberTextField.layer.cornerRadius = 16
        numberTextField.layer.borderColor = UIColor(red: 0.938, green: 0.938, blue: 0.938, alpha: 1).cgColor
        numberTextField.layer.borderWidth = 2
        numberTextField.backgroundColor = .white
        numberTextField.placeholder = "      Номер Телефона"
        
        return numberTextField
    }()
    private lazy var mailTextField: UITextField = {
        
        let mailTextField = UITextField()
        mailTextField.layer.cornerRadius = 16
        mailTextField.backgroundColor = .white
        mailTextField.layer.borderColor = UIColor(red: 0.938, green: 0.938, blue: 0.938, alpha: 1).cgColor
        mailTextField.layer.borderWidth = 2
        mailTextField.placeholder = "      Электронная почта"
        
        return mailTextField
    }()
    private lazy var messegeTextField: UITextField = {
        
        let messegeTextField = UITextField()
        messegeTextField.layer.cornerRadius = 16
        messegeTextField.backgroundColor = .white
        messegeTextField.layer.borderColor = UIColor(red: 0.938, green: 0.938, blue: 0.938, alpha: 1).cgColor
        messegeTextField.layer.borderWidth = 2
        messegeTextField.placeholder = "      Сообщение"
        
        return messegeTextField
        
    }()
    private lazy var sendFeedback: UIButton = {
        
        let sendFeedbackButton = UIButton()
        sendFeedbackButton.backgroundColor = .mainBlue
        sendFeedbackButton.layer.cornerRadius = 16
        sendFeedbackButton.setTitle("Отправить отзыв", for: .normal)
        sendFeedbackButton.titleLabel?.font = UIFont(name: "Stolzl-Medium", size: 16)
        sendFeedbackButton.addTarget(self, action: #selector(feedBack), for: .touchUpInside)
        
        return sendFeedbackButton
    }()
    
    private func makeConstraints(){
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(19)
        }
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(352)
            make.height.equalTo(54)
            make.top.equalTo(label.snp.bottom).offset(26)
        }
        numberTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(352)
            make.height.equalTo(54)
            make.top.equalTo(nameTextField.snp.bottom).offset(14)
        }
        mailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(352)
            make.height.equalTo(54)
            make.top.equalTo(numberTextField.snp.bottom).offset(14)
        }
        messegeTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(352)
            make.height.equalTo(110)
            make.top.equalTo(mailTextField.snp.bottom).offset(14)
        }
        sendFeedback.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(352)
            make.centerX.equalToSuperview()
            make.top.equalTo(messegeTextField.snp.bottom).offset(26)
        }
        
    }
    private func initialize(){
        
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(nameTextField)
        view.addSubview(numberTextField)
        view.addSubview(mailTextField)
        view.addSubview(messegeTextField)
        view.addSubview(sendFeedback)
    }
    
    @objc func feedBack(){
        navigationController?.popToRootViewController(animated: true)
        let tab = self.tabBarController
        tab?.selectedIndex = 0
    }
}
