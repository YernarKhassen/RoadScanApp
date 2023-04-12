//
//  SettingsViewController.swift
//  InRoad
//
//  Created by Dinmukhamed on 18.02.2023.
//

import UIKit

final class SettingsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let settings = ["Режим пользования",
                    "Тип автомобиля",
                    "Изменить город",
                    "Выбрать язык приложения"]
    private lazy var  tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    let feedbackButton: UIButton = {
        
        let feedbackButton = UIButton()
        feedbackButton.backgroundColor = .mainBlue
        feedbackButton.layer.cornerRadius = 16
        feedbackButton.setTitle("Написать отзыв", for: .normal)
        feedbackButton.titleLabel?.font = UIFont(name: "Stolzl-Medium", size: 16)
        feedbackButton.addTarget(self, action: #selector(toFeedback), for: .touchUpInside)
        
        return feedbackButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    private func setup(){
        initilize()
        makeConstraints()
    }
    private func makeConstraints(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        feedbackButton.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(352)
            make.centerX.equalToSuperview()
            
            make.top.equalToSuperview().inset(661)
        }
        
    }
    
    private func initilize(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(feedbackButton)
    }
    @objc func toFeedback(){
        navigationController?.pushViewController(FeedbackViewController(), animated: true)
    }
    
}

extension SettingsViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
        cell.label.text = settings[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 64
        }
    
}

