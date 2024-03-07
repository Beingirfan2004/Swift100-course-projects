//
//  CustomAlertVC.swift
//  Challenge3
//
//  Created by Irfan Khan on 07/03/24.
//

import UIKit

class CustomAlertVC: UIViewController {
    let alertContainerView = UIView()
    let alertView = UIView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let button = UIButton()
    
    var alertTitle: String
    var alertMessage: String
    var buttonTitle: String
    var handler: (() -> Void)?
    
    init(alertTitle: String, alertMessage: String, buttonTitle: String, handler: @escaping () -> Void) {
        
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.buttonTitle = buttonTitle
        self.handler = handler
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    private func configure() {
        self.view = alertContainerView
        alertContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        alertView.backgroundColor = .adaptiveLight
        alertView.layer.cornerRadius = 40
        alertView.clipsToBounds = true
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertContainerView.addSubview(alertView)
        
        titleLabel.text = alertTitle
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        titleLabel.textColor = .adaptiveDark
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        messageLabel.text = alertMessage
        messageLabel.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        messageLabel.textColor = UIColor(named: "MessageColor")
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        alertView.addSubview(messageLabel)
        
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.adaptiveLight, for: .normal)
        button.backgroundColor = .adaptiveDark
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        alertView.addSubview(button)

        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: alertContainerView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: alertContainerView.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 400),
            alertView.heightAnchor.constraint(equalToConstant: 380),
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            
            button.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: button.topAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 30),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -30)
            
            
        ])
        
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: handler)
    }
}
