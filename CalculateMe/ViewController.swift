//
//  ViewController.swift
//  CalculateMe
//
//  Created by Vy Nguyen on 8/1/17.
//  Copyright © 2017 Vy Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    var currentOperator: Operator = Operator.Nothing
    var calcState: CalcState = CalcState.enteringNum
    var firstValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func numberClicked (_ sender: UIButton) {
        updateDisplay(number: String(sender.tag))
    }
    
    func updateDisplay (number: String) {
        if calcState == CalcState.newNumStarted { // Starting a num
            if let num = displayLabel.text {
                if num != "" {
                    firstValue = num
                }
            }
            calcState = CalcState.enteringNum
            displayLabel.text = number
        } else if calcState == CalcState.enteringNum { // Continuing a num
            displayLabel.text = displayLabel.text! + number
        } 
    }
    
    @IBAction func operatorClicked (_ sender: UIButton) {
        calcState = CalcState.newNumStarted
        if let num = displayLabel.text {
            if num != "" {
                firstValue = num
                displayLabel.text = ""
            }
        }
        switch sender.tag {
            case 10:
                currentOperator = Operator.Times
            case 11:
                currentOperator = Operator.Subtract
            case 12:
                currentOperator = Operator.Divide
            case 13:
                currentOperator = Operator.Add
            default:
                return
        }
    }
    
    @IBAction func equalsClicked (_ sender: UIButton) {
        calculateSum()
    }
    
    func calculateSum () {
        if firstValue.isEmpty {
            return
        }
        var result = ""
        
        if currentOperator == Operator.Times {
            result = "\(Double(firstValue)! * Double(displayLabel.text!)!)"
        } else if currentOperator == Operator.Divide {
            result = "\(Double(firstValue)! / Double(displayLabel.text!)!)"
        } else if currentOperator == Operator.Subtract {
            result = "\(Double(firstValue)! - Double(displayLabel.text!)!)"
        } else if currentOperator == Operator.Add {
            result = "\(Double(firstValue)! + Double(displayLabel.text!)!)"
        }
        
        displayLabel.text = result
        calcState = CalcState.newNumStarted
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

