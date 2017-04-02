//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Daniel Santos on 3/31/17.
//  Copyright © 2017 Daniel Santos. All rights reserved.
//

import UIKit
import AVFoundation


class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    var currentOpeartion = Operation.empty
        var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case divide = "/"
        case multiply = "x"
        case substract = "-"
        case add = "+"
        case empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.counterLabel.text = ""
        
        let path = Bundle.main.path(forResource: "btn-clicked", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        self.counterLabel.text = runningNumber
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        self.playSound()
        if currentOpeartion != Operation.empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOpeartion == .multiply {
                    self.result = "\(Double(self.leftValStr)! * Double(self.rightValStr)!)"
                } else if currentOpeartion == .divide {
                    self.result = "\(Double(self.leftValStr)! / Double(self.rightValStr)!)"
                } else if currentOpeartion == .substract {
                    self.result = "\(Double(self.leftValStr)! - Double(self.rightValStr)!)"
                } else if currentOpeartion == .add  {
                    self.result = "\(Double(self.leftValStr)! + Double(self.rightValStr)!)"
                }
                
                leftValStr = result
                self.counterLabel.text = result
            }
            
            currentOpeartion = operation
        } else {
            // This is the first time
            leftValStr = runningNumber
            runningNumber = ""
            currentOpeartion = operation
        }
    }
    
    func clearAll() {
        self.currentOpeartion = .empty
        self.leftValStr = ""
        self.rightValStr = ""
        self.runningNumber = ""
        self.result = ""
        self.counterLabel.text = ""
    }
    
    @IBAction func dividePressed(sender: AnyObject) {
        self.processOperation(operation: .divide)
    }
    
    @IBAction func multiplyPressed(sender: AnyObject) {
        self.processOperation(operation: .multiply)
    }
    
    @IBAction func substractPressed(sender: AnyObject) {
        self.processOperation(operation: .substract)
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        self.processOperation(operation: .add)
    }
    
    @IBAction func equalPressed(sender: AnyObject) {
        self.processOperation(operation: currentOpeartion)
    }
    
    @IBAction func clearAll(sender: UITapGestureRecognizer) {
        if sender.state == .recognized {
            self.clearAll()
        }
    }
    
    @IBAction func clearPressed() {
        self.clearAll()
    }
    
}





























