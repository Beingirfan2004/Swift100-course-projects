//
//  ViewController.swift
//  Project2
//
//  Created by Irfan Khan on 08/02/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionNo = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .label
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()

    }
    
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        questionNo += 1
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: nil, action: nil)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title : String
        
        if sender.tag == correctAnswer{
            score += 1
            title = "Correct"
        } else {
            score -= 1
            title = "Wrong that's the flag of \(countries[sender.tag].uppercased())"
        }
        
        let alert : UIAlertController

        if questionNo >= 10{
            alert = UIAlertController(title: title, message: "Your total score is \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
            score = 0
            questionNo = 1
        } else {
            alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        
        present(alert, animated: true)
        
    }
    
}

