//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Une textview te permet d'être sur plusieurs ligne. On pourrait imaginer faire un saut de ligne à chaque nouvelle opération ?
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let displayChangedNotification = Notification.Name(rawValue: "DisplayChanged")
        NotificationCenter.default.addObserver(self, selector: #selector(displayChanged), name: displayChangedNotification, object: nil)
    }
    
    @objc func displayChanged() {
        if textView.text == "0" {
            textView.text = ""
        }
        
        // pas très claire
        if calculator.expressionHaveResult {
            textView.text.append(calculator.elements[calculator.elements.count - 2])
            textView.text.append(calculator.elements.last!)
        } else {
            textView.text.append(calculator.elements.last!.last!)
        }
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        // pourquoi cette vérif ?
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        // mettre un commentaire pour expliquer qu'on clear l'affichage pour refaire un nouveau calcul
        if calculator.expressionHaveResult {
            calculator.inputString = ""
        }
        
        calculator.inputString.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            // pourquoi ne pas laisser le model ajouter le + ?
            // le controller ferait juste : calcultor.addAddition()
            // à voir si c'est vraiment pertinent
            calculator.inputString.append(" + ")
        } else {
            // à voir si il faut mettre en anglais ou pas ?
            // faire une fonction pour cette affichage d'alert afin d'avoir le code qu'une seule fois au lieu de 4
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.inputString.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.inputString.append(" x ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            calculator.inputString.append(" / ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        calculator.result()
    }
}
