//
//  ViewController.swift
//  Bullseye-iOS13
//
//  Created by Dennis Nesanoff on 01.05.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var currentValue = 15
    var targetValue = 0
    var round = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        showAlert()
    }
    
    func showAlert() {
        let difference = abs(targetValue - currentValue)
        
        let points: Int
        let title: String
        
        if difference == 0 {
            points = 200
            title = "Perfect!"
        } else if difference == 1 {
            points = 150
            title = "You almost had it!"
        } else if difference < 10 {
            points = 100 - difference
            title = "Pretty good!"
        } else {
            points = 100 - difference
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You scored \(points) points" +
        "\nThe value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        startNewRound()
    }
    
    private func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        round += 1
        
        updateLabels()
    }
    
    private func updateLabels() {
        targetLabel.text = String(targetValue)
        slider.value = Float(currentValue)
        roundLabel.text = String(round)
        scoreLabel.text = String(score)
    }
}
