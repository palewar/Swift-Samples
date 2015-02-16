//
//  ViewController.swift
//  Calculator
//
//  Created by Sachin Palewar on 2/12/15.
//  Copyright (c) 2015 SwiftWala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!

    var isFirstDigit = true
    var operand1: Double = 0
    var operation = "="

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set {
            displayLabel.text = "\(newValue)"
            isFirstDigit = true
            operation = "="

        }
    }

    @IBAction func appendDigit(sender: UIButton) {

        let digit = sender.currentTitle!

        displayLabel.text = isFirstDigit ? digit : displayLabel.text! + digit
        isFirstDigit = false
    }

    @IBAction func clearDisplay(sender: AnyObject) {
        displayValue = 0
           }

    @IBAction func saveOperand(sender: UIButton) {
        operation = sender.currentTitle!
        operand1 = displayValue
        isFirstDigit = true
    }

    @IBAction func calculate(sender: AnyObject) {
        switch operation {
        case "÷":displayValue = operand1 / displayValue
        case "×":displayValue *= operand1
        case "+":displayValue += operand1
        case "−":displayValue = operand1 - displayValue
        default:break
        }
    }


}

