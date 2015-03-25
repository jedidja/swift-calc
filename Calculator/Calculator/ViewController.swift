import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        println("digit = \(digit)")
    }
    
    //TODO: This is also bad.
    @IBAction func makeDecimal() {
        
        // Can only have one decimal per number
        if find(display.text!, ".") != nil {
            return;
        }
        
        if (userIsInTheMiddleOfTypingANumber) {
            display.text = display.text! + "."
        }
        else {
            // If the number is less than zero, allow
            // the user to enter the decimal itself.
            display.text = "."
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    //TODO: Wowwww this is bad.
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if (userIsInTheMiddleOfTypingANumber) {
            enter()
        }
        
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "÷": performOperation { $1 / $0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double) -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false;
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}
