//
//  calculatorBrain.swift
//  Calculator
//
//  Created by Era Chaudhary on 3/15/15.
//  Copyright (c) 2015 Era Chaudhary. All rights reserved.
//

import Foundation
class calculatorBrain{
    private enum Op:Printable{
        
        case operand(Double)
        case unaryOperation(String, Double -> Double)
        case binaryOperation(String, (Double,Double)->Double)
    
    var description:String{
        get{
            switch self{
        
            case .operand(let operand):
                return("\(operand)")
            case .binaryOperation(let symbol, _):
                return symbol
            case .unaryOperation(let symbol, _ ):
                return symbol
            }
            
        }
        
    }
    
    }
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    init(){
    
        knownOps["×"] = Op.binaryOperation("×",*)
        knownOps["÷"] = Op.binaryOperation("÷"){$1 / $0}
        knownOps["+"] = Op.binaryOperation("+",+)
        knownOps["−"] = Op.binaryOperation("−"){$1 - $0}
        knownOps["√"] = Op.unaryOperation("√",sqrt)
        
        
    }
    
    private  func evaluate(ops:[Op])->(result:Double?, remainingOps:[Op]){
        if !ops.isEmpty{
            var remainingOps = ops
            let op  = remainingOps.removeLast()
            switch op
            {
            case .operand(let operand):
                return (operand,remainingOps)
            case .unaryOperation(_ ,let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                   return(operation(operand),operandEvaluation.remainingOps)
                }
            case .binaryOperation(_,let operation):
            let op1Evaluation = evaluate(remainingOps)
            if let operand1 = op1Evaluation.result{
            let op2Evaluation = evaluate(op1Evaluation.remainingOps)
            if let operand2 = op2Evaluation.result{
                return(operation(operand1,operand2),op2Evaluation.remainingOps)
                }
                }
            }
            
        }
        
        return (nil,ops)

        
    }
    
    func evaluate()->Double?{
        let (result,remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) leftover")
        return result
        
        
    }
    
    
    func pushOperand(operand:Double)->Double?{
        opStack.append(Op.operand(operand))
        return evaluate()
        
    }
    
    func performOperation(symbol:String)->Double?{
        if let operation = knownOps[symbol]{
        opStack.append(operation)
        }
        return evaluate()
    }
    
    
}
    

    
