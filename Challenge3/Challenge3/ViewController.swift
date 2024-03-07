//
//  ViewController.swift
//  Challenge3
//
//  Created by Irfan Khan on 01/03/24.
//

import UIKit

class ViewController: UIViewController {
    var chancesLabel = UILabel()
    var scoreLabel = UILabel()
    let hintLabel = UILabel()
    let guessStack = UIStackView()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var letterButtons = [UIButton]()
    var characterLabels = [UILabel]()
    var wordsAndHints = [String]()
    let alphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
                    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var isCorrect: Bool = false
    var questionCounter = 0
    var level = 1 {
        didSet{
            loadLevel()
        }
    }
    var word: String = "" {
        didSet{
            createWordLabels()
        }
    }
    var hint: String = "" {
        didSet{
            hintLabel.text = hint
        }
    }
    var chances = 7 {
        didSet{
            chancesLabel.text = "CHANCES: \(chances)"
        }
    }
    var score = 0 {
        didSet{
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    
    override func loadView() {
        configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
    
    
    private func configure() {
        configureUIElements()
    }
    
    
    @objc func checkCharacter(_ sender: UIButton) {
        let title = sender.titleLabel?.text
        for (index, letter) in word.enumerated() {
            if String(letter) == title {
                characterLabels[index].text = title
                isCorrect = true
            }
        }
        if !isCorrect {
            chances -= 1
        }
        if chances == 0 {
            let alert = CustomAlertVC(alertTitle: "Try Again!", alertMessage: "You are out of chances. Want to try again?", buttonTitle: "New Word") {
                [weak self] in
                guard let self else { return }
                self.resetLabels()
                self.newWord()
                chances = 7
                if score > 0 {
                    score -= 1
                }
            }
            
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            present(alert, animated: true)
        }
        isCorrect = false
        
        if isWordCompleted() {
            resetLabels()
            questionCounter += 1
            if questionCounter != 10 {
                wordsAndHints.remove(at: 0)
                newWord()
                score += 1
            } else {
                if level < 3{
                    let alert = CustomAlertVC(alertTitle: "Well Done!" , alertMessage: "Congratulations.\nYou Completed the game!", buttonTitle: "RESTART") {
                        [weak self] in
                        guard let self else { return }
                        level = 1
                        questionCounter = 0
                    }
                    alert.modalPresentationStyle = .overFullScreen
                    alert.modalTransitionStyle = .crossDissolve
                    present(alert, animated: true)
                    score = 0
                } else {
                    let alert = CustomAlertVC(alertTitle: "Awesome Job!" , alertMessage: "Are you ready for the next level?", buttonTitle: "Let's Go") {
                        [weak self] in
                        guard let self else { return }
                        level += 1
                        questionCounter = 0
                    }
                    
                    alert.modalPresentationStyle = .overFullScreen
                    alert.modalTransitionStyle = .crossDissolve
                    present(alert, animated: true)
                    score += 1
                }
            }
            chances = 7
        }
    }
    
    
    func resetLabels() {
        for label in characterLabels {
            label.removeFromSuperview()
        }
        characterLabels.removeAll()
    }
    
    func isWordCompleted() -> Bool {
        for label in characterLabels {
            if label.text == "?" {
                return false
            }
        }
        return true
    }
    
    
    func newWord() {
        wordsAndHints.shuffle()
        let parts = wordsAndHints[0].components(separatedBy: ":")
        hint = parts[1]
        word = parts[0]
    }
    
    
    func loadLevel() {
        if let fileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            guard let stringFile = try? String(contentsOf: fileURL) else { return }
            
            wordsAndHints = stringFile.components(separatedBy: "\n")
            wordsAndHints.shuffle()
            let parts = wordsAndHints[0].components(separatedBy: ":")
            hint = parts[1]
            word = parts[0]
        }
    }
    
    
    
    
    func configureUIElements() {
        let view = UIView()
        self.view = view
        view.backgroundColor = UIColor.adaptiveBackground
        
        chancesLabel.text = "CHANCES: \(chances)"
        chancesLabel.font = UIFont.systemFont(ofSize: 42, weight: .semibold)
        chancesLabel.textColor = UIColor(named: "TextColor")
        chancesLabel.textAlignment = .center
        chancesLabel.layer.cornerRadius = 30
        chancesLabel.clipsToBounds = true
        chancesLabel.backgroundColor = UIColor.adaptiveLight
        chancesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chancesLabel)
        
        scoreLabel.text = "SCORE: \(score)"
        scoreLabel.font = UIFont.systemFont(ofSize: 42, weight: .semibold)
        scoreLabel.textColor = UIColor(named: "TextColor")
        scoreLabel.textAlignment = .center
        scoreLabel.layer.cornerRadius = 30
        scoreLabel.clipsToBounds = true
        scoreLabel.backgroundColor = UIColor.adaptiveLight
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)
        
        hintLabel.text = hint
        hintLabel.textColor = UIColor(named: "TextColor")
        hintLabel.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        hintLabel.numberOfLines = 0
        hintLabel.textAlignment = .center
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hintLabel)
        
        NSLayoutConstraint.activate([
            chancesLabel.heightAnchor.constraint(equalToConstant: 80),
            chancesLabel.widthAnchor.constraint(equalToConstant: 270),
            chancesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            chancesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            scoreLabel.heightAnchor.constraint(equalToConstant: 80),
            scoreLabel.widthAnchor.constraint(equalToConstant: 270),
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            hintLabel.topAnchor.constraint(equalTo: chancesLabel.bottomAnchor, constant: 60),
            hintLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            hintLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])
        
                
        let rows = 5
        let columns = 6
        
        
        for i in 0..<rows {
            let buttonPadding = (screenWidth - 900) / 2
            let x: CGFloat = (CGFloat(i) * 20) + (CGFloat(i) * 130)
            
            for j in 0..<columns {
                let y: CGFloat = (CGFloat(j) * 20) + (CGFloat(j) * 130 + buttonPadding)
                if i == 4 {
                    if j == 2 || j == 3 {
                        alphabetButton(x: x, y: y)
                        continue

                    } else {
                        continue
                    }
                }
                alphabetButton(x: x, y: y)
            }
        }
        for (index,button) in letterButtons.enumerated() {
            button.setTitle( alphabets[index], for: .normal)
        }
    }
    
    
    func alphabetButton(x: CGFloat, y: CGFloat) {
        let letterButton = UIButton(type: .system)
        letterButton.setTitleColor(.buttonText, for: .normal)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 100, weight: .semibold)
        letterButton.backgroundColor = .adaptiveDark
        letterButton.layer.cornerRadius = 25
        letterButton.clipsToBounds = true
        letterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(letterButton)
        letterButton.addTarget(self, action: #selector(checkCharacter), for: .touchUpInside)
        
        letterButtons.append(letterButton)
         
        NSLayoutConstraint.activate([
            letterButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: x - 200),
            letterButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: y),
            letterButton.widthAnchor.constraint(equalToConstant: 130),
            letterButton.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    
    func createWordLabels() {
        var width: CGFloat = 100
        var height: CGFloat = 100
        let wordCount = CGFloat(word.count)
        
        if wordCount > 8 {
            width = 80
            height = 80
        }
        
        let padding = (screenWidth - (wordCount * width) - ((wordCount - 1) * 10)) / 2
        let internalPadding: CGFloat = 10
        
        for (index, _) in word.enumerated() {
            let characterLabel = UILabel()
            characterLabel.text = "?"
            characterLabel.font = UIFont.systemFont(ofSize: 60, weight: .semibold)
            characterLabel.textColor = .label
            characterLabel.backgroundColor = .tertiarySystemBackground
            characterLabel.layer.cornerRadius = width / 5
            characterLabel.clipsToBounds = true
            characterLabel.textAlignment = .center
            characterLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(characterLabel)
            
            characterLabels.append(characterLabel)
                        
            NSLayoutConstraint.activate([
                characterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding + (CGFloat(index) * internalPadding) + (CGFloat(index) * width)),
                characterLabel.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 40),
                characterLabel.heightAnchor.constraint(equalToConstant: height),
                characterLabel.widthAnchor.constraint(equalToConstant: width)
            ])
            
        }

    }

}

