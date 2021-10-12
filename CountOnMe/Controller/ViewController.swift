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
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let displayChangedNotification = Notification.Name(rawValue: "DisplayChanged")
        NotificationCenter.default.addObserver(self, selector: #selector(displayChanged), name: displayChangedNotification, object: nil)
    }
    
    // Updates the display
    @objc func displayChanged() {
        if textView.text == "0" {
            textView.text = ""
        }
        
        if calculator.expressionHasResult {
            textView.text.append(calculator.elements[calculator.elements.count - 2])
            textView.text.append(calculator.elements.last ?? "")
        } else {
            if let lastCharacter = calculator.elements.last?.last {
                textView.text.append(lastCharacter)
            }
        }
        
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        /*guard let numberText = sender.title(for: .normal) else {
            return
        }*/
        
        let numberText = sender.title(for: .normal)!
        // clear display for a new operation
        if calculator.expressionHasResult {
            calculator.inputString = ""
        }
        
        calculator.inputString.append(numberText)
    }
    
    /// add addition sign in the model
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.addAddition()
        } else {

            let alertVC = UIAlertController(title: "Error!", message: "An operator is already entered!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// add substraction sign in the model
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.addSubstraction()
        } else {
            let alertVC = UIAlertController(title: "Error!", message: "An operator is already entered!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// add multiplication sign in the model
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.addMultiplication()
        } else {
            let alertVC = UIAlertController(title: "Error!", message: "An operator is already entered!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// add division sign in the model
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.addDivision()
        } else {
            let alertVC = UIAlertController(title: "Error!", message: "An operator is already entered!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    /// verify if the expression is correct then procede to calculation
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsComplete else {
            let alertVC = UIAlertController(title: "Error!", message: "Enter a correct expression!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
            
        }
        calculator.result()
    }
    
    /// clear the display and set inputring in the model to 0
    @IBAction func tappedACButton(_ sender: UIButton) {
        textView.text = "0"
        calculator.inputString = "0"
    }
}
