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
    
    /// elements of inputstring after being splited
    var elements: [String] {
        return inputString.split(separator: " ").map { "\($0)" }
    }
    
    /// checks that the expression is mathematically correct no division by zero
    var denominatorIsZero: Bool {
        var elementsArray = elements
        while let index = elementsArray.firstIndex(of: "/") {
            if elements[index + 1] == "0" {
                return true
            } else {
                elementsArray.remove(at: index)
            }
        }
        return false
    }
    
    /// Checks if the previous entered character is an operator
    var lastElementIsOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    /// Checks if the inputString has an "=" sign
    var expressionHasEqualSign: Bool {
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
    
    /// This function is called to perform the computation
    func result() {
        
        /// Create local copy of elements
        var operationsToReduce = elements
        
        /// Iterate over elements
        while operationsToReduce.count > 1 {
            
            var result: String
            
            /// index of first multiplication sign in elements
            let firstMultiplicationIndex = operationsToReduce.firstIndex(of: "x")
            /// index of dirst division sign
            let firstDivisionIndex = operationsToReduce.firstIndex(of: "/")
            /// index of operand by default is the second element
            var operandIndex = 1
            
            /// if operationsToReduce contains both a multiplication and a division operations
            if firstDivisionIndex != nil && firstMultiplicationIndex != nil {
                operandIndex = firstDivisionIndex! < firstMultiplicationIndex! ? firstDivisionIndex! : firstMultiplicationIndex!
            /// if operationsToReduce don't contain a division operation
            } else if firstDivisionIndex == nil {
                operandIndex = firstMultiplicationIndex ?? 1
            /// if operationstoreduce contains a division operation
            } else {
                operandIndex = firstDivisionIndex!
            }
            
            /// index of element befor operand
            let leftIndex = operandIndex - 1
            /// index of element after operand
            let rightIndex = operandIndex + 1
            /// element befor operand
            let left = Double(operationsToReduce[leftIndex])!
            /// the operand + - x /
            let operand = operationsToReduce[operandIndex]
            /// element after the operand
            let right = Double(operationsToReduce[rightIndex])!
            
            switch operand {
                case "+": result = String(Double(left + right).clean)
                case "-": result = String(Double(left - right).clean)
                case "x": result = String(Double(left * right).clean)
                case "/":
                    /// division by zero
                    if right == 0 {
                        result = " = Math Error"
                    } else {
                        /// return a result with three digits presision after the floating point
                        result = String((round(1000*(left / right))/1000).clean)
                    }
                default: return /// if the user enters a non existed operand which is impossible to reproduce
            }
            /// reduce the elements once the calculations are done
            operationsToReduce.removeSubrange(leftIndex...rightIndex)
            /// insert the result to replace the previous part of operation
            operationsToReduce.insert(result, at: leftIndex)
        }
        /// add the result to inputString so it can be updated in the display with the notification
        inputString.append(" = \(operationsToReduce.first!)")
    }
}

extension Double {
    /// This property cleans a double variable to get rid of the part after the floating point in case if the value is an integer
    ///  example 2.0 will be 2
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
