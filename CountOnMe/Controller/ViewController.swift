//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculator = Calculator()
    
    /// View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let displayChangedNotification = Notification.Name(rawValue: "DisplayChanged")
        NotificationCenter.default.addObserver(self, selector: #selector(displayChanged), name: displayChangedNotification, object: nil)
    }
    
    /// Updates the display
    @objc func displayChanged() {
        if textView.text == "0" {
            textView.text = ""
        }
        
        if calculator.expressionHasEqualSign {
            textView.text.append(calculator.elements[calculator.elements.count - 2])
            textView.text.append(calculator.elements.last ?? "")
        } else {
            if let lastCharacter = calculator.elements.last?.last {
                textView.text.append(lastCharacter)
            }
        }
        
    }
    
    /// View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        let numberText = sender.title(for: .normal)!
        // clear display for a new operation
        if calculator.expressionHasEqualSign {
            calculator.inputString = ""
        }
        calculator.inputString.append(numberText)
    }
    
    /// add addition sign in the model
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.lastElementIsOperator {
            calculator.addAddition()
        } else {

            let alertVC = UIAlertController(title: "Error!", message: "An operator is already entered!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// add substraction sign in the model
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.lastElementIsOperator {
            calculator.addSubstraction()
        } else {
            let alertVC = UIAlertController(title: "Error!", message: "An operator is already entered!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// add multiplication sign in the model
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculator.lastElementIsOperator {
            calculator.addMultiplication()
        } else {
            let alertVC = UIAlertController(title: "Error!", message: "An operator is already entered!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// add division sign in the model
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculator.lastElementIsOperator {
            calculator.addDivision()
        } else {
            let alertVC = UIAlertController(title: "Error!", message: "An operator is already entered!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// verify if the expression is correct with no successive operands then procede to calculation
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.lastElementIsOperator else {
            let alertVC = UIAlertController(title: "Error!", message: "Enter a correct expression!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
            
        }
        /// division by zero handel
        if calculator.denominatorIsZero {
            let alertVC = UIAlertController(title: "Math Error!", message: "Division by zero is not allowed!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        calculator.result()
    }
    
    /// clear the display and set inputString in the model to 0
    @IBAction func tappedACButton(_ sender: UIButton) {
        textView.text = "0"
        calculator.inputString = "0"
    }
}
