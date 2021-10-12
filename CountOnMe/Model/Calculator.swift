//
//  Calculator.swift
//  CountOnMe
//
//  Created by Taoufiq Germoud on 25/08/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    /// input that user enter using the keyboard
    var inputString: String = "" {
        didSet {
            refresh()
        }
    }
    
    ///  elements of inputstring after being splited
    var elements: [String] {
        return inputString.split(separator: " ").map { "\($0)" }
    }
    
    /// Error check computed variables
    var expressionIsComplete: Bool {
        
        if inputString.firstIndex(of: "/") != nil && expressionHasResult && elements.last == "0" {
            return false
        } else {
            return elements.count >= 3
        }
    }
    
    /// checks if an operator already exists
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    /// Checks if the inputString has an "=" symbol
    var expressionHasResult: Bool {
            return inputString.firstIndex(of: "=") != nil
    }
    
    /// sends a notification to update the display
    func refresh() {
        let notificationName = Notification.Name(rawValue: "DisplayChanged")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
    
    /// adds + sign to inputString
    func addAddition() {
        inputString.append(" + ")
    }
    
    func addSubstraction() {
        inputString.append(" - ")
    }
    
    func addMultiplication() {
        inputString.append(" x ")
    }
    
    func addDivision() {
        inputString.append(" / ")
    }
    
    func result() {
        
        /// Create local copy of operations
        var operationsToReduce = elements
        
        /// Iterate over operations while an operand still here
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
                default: return
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert(result, at: 0)
        }
        
        inputString.append(" = \(operationsToReduce.first!)")
        
        print(elements)
    }
}
