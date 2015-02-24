//
//  ViewController.swift
//  Calculator
//
//  Created by Sachin Palewar on 2/12/15.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!

    var isFirstDigit = true
    var operand1: Double = 0
    var operation = "="

    var displayValue: Double {
        get {
            //notice use of ! twice in below line. If you get that, then you have truely understood optionals :-)
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set {
            // Notice how we are using a Property Setter to perform additional tasks while 
            //setting value for the property
            displayLabel.text  = "\(newValue)"
            isFirstDigit = true
            operation = "="

        }
    }

    //This single IBAction function is tied to all the digit buttons
    @IBAction func appendDigit(sender: UIButton) {

        let digit = sender.currentTitle!
        //Notice use of ternery operator in below line which results in a single line code
        //instead of usual if-else multiple lines
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

