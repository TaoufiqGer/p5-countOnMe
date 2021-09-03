//
//  Calculator.swift
//  CountOnMe
//
//  Created by Taoufiq Germoud on 25/08/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    var inputString: String = "" {
        didSet {
            refresh()
        }
    }
    
    var elements: [String] {
        return inputString.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        // tu peux stocker les différents opérateur dans un tableau. Ca sera peut être mieux pour travailler dessus.

        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        // attention code similaire à expressionIsCorrect. A voir si on ne peut pas mutualiser
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveResult: Bool {
        return inputString.firstIndex(of: "=") != nil
    }
    
    func refresh() {
        let notificationName = Notification.Name(rawValue: "DisplayChanged")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
    
    
    // A voir quand tu feras tes tests mais de ce que je vois tu as un problème de priorité.
    // Si tu fait 1 + 2 * 3 ça va te donner 9 alors que la bonne réponse c'est 7
    func result() {
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right // si right == 0 il se passe quoi ? --> à voir dans les tests
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        inputString.append(" = \(operationsToReduce.first!)")
    }
}
