//
//  CalculatorTests.swift
//  Calculator
//
//  Created by Ayush Goyal on 22/05/24.
//

import XCTest
@testable import Calculator
final class CalculatorTests: XCTestCase {
    
    var sut : ViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name : "Main", bundle : nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func test_numberButtonPressed_initialEmpty() throws{
        let button = UIButton()
        button.tag = 1
        sut.numberButtonPressed(button)
        XCTAssertEqual(sut.outPutLabel.text, "1")
    }
    
    func test_numberButtonPressed_initialNotEmpty_lessThan9digits()throws{
        
        let button = UIButton()
        button.tag = 1
        sut.currentNumber = "24"
        sut.numberButtonPressed(button)
        XCTAssertEqual(sut.outPutLabel.text, "241")
    }
    
    func test_numberButtonPressed_initialNotEmpty_notLessThan9digits()throws{
        
        let button = UIButton()
        button.tag = 1
        sut.currentNumber = "123456789"
        sut.outPutLabel.text = sut.currentNumber
        sut.numberButtonPressed(button)
        XCTAssertEqual(sut.outPutLabel.text, "123456789")
    }
    
    func test_numberButtonPressed_initialZero() throws{
        
        let button = UIButton()
        button.tag = 1
        sut.currentNumber = "0"
        sut.numberButtonPressed(button)
        XCTAssertEqual(sut.outPutLabel.text, "1")
    }
    
    func test_zeroButtonPressed_initialNotEmpty_lessThan9digits()throws{
        
        let button = UIButton()
        button.tag = 0
        sut.currentNumber = "24"
        sut.zeroButtonPressed(button)
        XCTAssertEqual(sut.outPutLabel.text, "240")
    }
    
    func test_zeroButtonPressed_initialNotEmpty_notLessThan9digits()throws{
        
        let button = UIButton()
        button.tag = 0
        sut.currentNumber = "1234567890"
        sut.outPutLabel.text = sut.currentNumber
        sut.zeroButtonPressed(button)
        XCTAssertEqual(sut.outPutLabel.text, "0")
    }
    
    func test_dotButtonPressed_doesNotContainDot() throws {
        let button = UIButton()
        sut.currentNumber = "123"
        sut.outPutLabel.text = "123"
        sut.dotbuttonPressed(button)
        XCTAssertEqual(sut.outPutLabel.text, "123.")
    }
    
    func test_dotButtonPressed_containsDot() throws {
        let button = UIButton()
        sut.currentNumber = "123.45"
        sut.outPutLabel.text = "123.45"
        sut.dotbuttonPressed(button)
        XCTAssertEqual(sut.outPutLabel.text, "123.45")
    }
    
    func testClearButton() throws {
        let button = UIButton()
        sut.clearButtonPressed(button)
        XCTAssertEqual(sut.currentNumber, "0")
        XCTAssertEqual(sut.firstNumber,"")
        XCTAssertEqual(sut.secondNumber,"")
        XCTAssertEqual(sut.operation, .NULL)
        XCTAssertEqual(sut.result,"")
    }
    
    func test_divideByZero(){
        let button = UIButton()
        sut.currentNumber = "1"
        sut.divisionButtonPressed(button)
        sut.currentNumber = "0"
        let button2 = UIButton()
        sut.answerButtonPressed(button2)
        XCTAssertEqual(sut.outPutLabel.text,"")
    }
    
    func test_overflow(){
        let mulButton = UIButton()
        sut.currentNumber = "100000"
        sut.multiplyButtonPressed(mulButton)
        sut.currentNumber = "100000"
        let answerButton = UIButton()
        sut.answerButtonPressed(answerButton)
        XCTAssertEqual(sut.outPutLabel.text, "100000000E2")
    }
    
    func test_changeSignature(){
        let button = UIButton()
        sut.currentNumber = "1"
        sut.changeSignButton(button)
        XCTAssertEqual(sut.outPutLabel.text, "-1")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
