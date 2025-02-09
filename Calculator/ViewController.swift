//
//  ViewController.swift
//  Calculator
//
//  Created by Мустафа Натур on 07.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var outPutLabel: UILabel!
    enum Operations:String {
        case plus = "+"
        case minus = "-"
        case devision = "/"
        case multiply = "X"
        case NULL = "NULL"
        case equally = "="
    }
    
    @IBAction func ToFirstViewController(_ segue: UIStoryboardSegue) {
        guard let sourceVC = segue.source as? SecondViewController else {
            return
        }
        colorButton.backgroundColor = sourceVC.colorButton.backgroundColor!
    }

    var currentNumber:String = ""
    var firstNumber:String = ""
    var secondNumber:String = ""
    var operation:Operations = .NULL
    var result:String = ""
    var maxNumberCount = 9
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outPutLabel.text = "0"
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        sender.dim()
        if (currentNumber == "0") {
            currentNumber = ""
        }
        if (currentNumber.count < maxNumberCount) {
            currentNumber+="\(sender.tag)"
            
            outPutLabel.text = currentNumber
        }
    }
    
    @IBAction func zeroButtonPressed(_ sender: UIButton) {
        sender.dim()
        if currentNumber.count<=maxNumberCount {
            if (Int(currentNumber) != 0) {
                currentNumber+="\(sender.tag)"
                outPutLabel.text = currentNumber
            }
        } else {
            currentNumber = "0"
            outPutLabel.text = currentNumber
        }
    }
    
    @IBAction func dotbuttonPressed(_ sender: UIButton) {
        sender.dim()
        if !currentNumber.contains(".") && !currentNumber.isEmpty {
            currentNumber+="."
            outPutLabel.text = currentNumber
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        sender.dim()
        resetAll()
        outPutLabel.text = currentNumber
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        sender.dim()
        guard !currentNumber.isEmpty else {
            return
        }
        
        currentNumber.removeLast()
        outPutLabel.text = currentNumber
    }
    
    @IBAction func divisionButtonPressed(_ sender: UIButton) {
        sender.dim()
        witchOperation(.devision)
    }
    @IBAction func multiplyButtonPressed(_ sender: UIButton) {
        sender.dim()
        witchOperation(.multiply)
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        sender.dim()
        witchOperation(.minus)
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        sender.dim()
        witchOperation(.plus)
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        sender.dim()
        secondNumber = currentNumber
        if (secondNumber.count != 0 && firstNumber.count != 0) {
            result = calculate(operation)
            let clearResult = cleanResult(result)
            outPutLabel.text = clearResult
            operation = .NULL
            currentNumber = result
        }

    }
    
    @IBAction func changeSignButton(_ sender: UIButton) {
        sender.dim()
        if let number = Int(currentNumber) {
            currentNumber = String(number * -1)
        }
        outPutLabel.text = currentNumber
    }
    
    func calculate(_ operation: Operations) -> String {
        if let f = Double(firstNumber) , let s = Double(secondNumber)  {
            if (operation == .plus) {
                result = "\(f + s)"
            } else if (operation == .minus) {
                result = "\(f - s)"
            } else if (operation == .devision) {
                if(s==0){
                    result = ""
                }
                else {
                    result = "\(f/s)"
                }
               
            } else if (operation == .multiply) {
                result = "\(f*s)"
                print(result.count, result)
            }
        }
        return result
    }
    
    func cleanResult(_ result:String) -> String {
        var newResult = result
        if(result==""){ return result}
        if (result[result.index(before: result.endIndex)] == "0") {
            let index = result.firstIndex(of:".") ?? result.endIndex
            newResult = String(result[..<index])
        }
        
        if (newResult.count > 9) {
            let miss = newResult.count - 9
            let index = newResult.index(newResult.startIndex, offsetBy: 9)
            newResult = String(newResult[..<index]) + "E\(miss)"
        }
        
        return newResult
    }
    
    func resetAll() {
        currentNumber = "0"
        firstNumber = ""
        secondNumber = ""
        operation = .NULL
        result = ""
    }
    
    func witchOperation(_ operationNew: Operations) {
        if (!currentNumber.isEmpty || !firstNumber.isEmpty) {
            if (operation == .NULL) {
                firstNumber = currentNumber
                currentNumber = ""
            }
            operation = operationNew
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondScreen" {
            if let secondVC = segue.destination as? SecondViewController {
                secondVC.newColor = colorButton.backgroundColor!
            }
        }
    }
}

