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
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
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
    
    func result() {
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            
            let result: String
            switch operand {
            case "+": result = String(Int(left + right))
            case "-": result = String(Int(left - right))
            case "x": result = String(Int(left * right))
            case "/": result = String(left / right)
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert(result, at: 0)
        }
        
        inputString.append(" = \(operationsToReduce.first!)")
        
        print(elements)
    }
}
