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
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func startOverpressed(_ sender: UIButton) {
        startNewGame()
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
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default) { _ in
            self.startNewRound()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = Int.random(in: 1...100)
        round += 1
        
        updateLabels()
    }
    
    private func startNewGame() {
        round = 0
        score = 0
        
        startNewRound()
    }
    
    private func updateLabels() {
        targetLabel.text = String(targetValue)
        slider.value = Float(currentValue)
        roundLabel.text = String(round)
        scoreLabel.text = String(score)
    }
}
