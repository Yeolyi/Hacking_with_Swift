//
//  ViewController.swift
//  Project2
//
//  Created by SEONG YEOL YI on 2022/01/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)."
        } else {
            title = "Wrong"
            score -= 1
            message = "Wrong! That's the flag of \(countries[sender.tag])"
        }
        solvedNum += 1
        if self.solvedNum == 5 {
            let ac = UIAlertController(title: "Your final score: \(self.score)", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(ac, animated: true)
            return
        }
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in self.askQuestion() } ))
        present(ac, animated: true)
    }
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var correctAnswer = 0
    var score = 0
    var solvedNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askQuestion()
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = .random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()), \(score)"
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }

}

