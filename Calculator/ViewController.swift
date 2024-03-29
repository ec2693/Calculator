//
//  ViewController.swift
//  Calculator
//
//  Created by Era Chaudhary on 3/12/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    var brain = calculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping{
        display.text = display.text! + digit
        }
        else{
            display.text = digit
            userIsTyping=true
        }
    }
    
    
    @IBAction func enter() {
        
       userIsTyping = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }
        else{
            displayValue = 0
        }
        }
    
      var displayValue:Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        set{
            display.text = "\(newValue)"
            userIsTyping=false
            
        }
    }

    
    
    
    @IBAction func operate(sender: UIButton) {
       if(userIsTyping){
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }
            else{
                displayValue = 0
            }

            
        }
        
            }
    

        
        
        
}



