//
//  Task_SorterUITests.swift
//  Task SorterUITests
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import XCTest

class Task_SorterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSetupFull() {
        
        let app = XCUIApplication()
        app.otherElements.containingType(.StaticText, identifier:"Tasks").element.tap()
        
        let addTaskButton = app.buttons["Add Task"]
        addTaskButton.tap()
        
        let typeYourFirstTaskHereTextField = app.textFields["Type your first task here..."]
        typeYourFirstTaskHereTextField.tap()
        typeYourFirstTaskHereTextField.typeText("medium")
        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        
        let addAnotherTaskTextField = app.textFields["Add another task..."]
        addAnotherTaskTextField.tap()
        addAnotherTaskTextField.typeText("large")
        nextButton.tap()
        
        let largeButton = app.buttons["large"]
        largeButton.tap()
        addTaskButton.tap()
        addAnotherTaskTextField.tap()
        addAnotherTaskTextField.typeText("small")
        nextButton.tap()
        
        let mediumButton = app.buttons["medium"]
        mediumButton.tap()
        addTaskButton.tap()
        addAnotherTaskTextField.tap()
        addAnotherTaskTextField.typeText("tiny")
        nextButton.tap()
        mediumButton.tap()
        app.buttons["small"].tap()
        addTaskButton.tap()
        addAnotherTaskTextField.tap()
        addAnotherTaskTextField.typeText("bigger than small")
        nextButton.tap()
        mediumButton.tap()
        app.buttons["bigger than small"].tap()
        addTaskButton.tap()
        addAnotherTaskTextField.tap()
        addAnotherTaskTextField.typeText("less than large")
        nextButton.tap()
        app.buttons["less than large"].tap()
        largeButton.tap()
        addTaskButton.tap()
        addAnotherTaskTextField.tap()
        addAnotherTaskTextField.typeText("largest")
        nextButton.tap()
        
        let largestButton = app.buttons["largest"]
        largestButton.tap()
        largestButton.tap()
        
    }
    
    func testSetupSmall() {
        
        let app = XCUIApplication()
        let addTaskButton = app.buttons["Add Task"]
        addTaskButton.tap()
        
        let typeYourFirstTaskHereTextField = app.textFields["Type your first task here..."]
        typeYourFirstTaskHereTextField.tap()
        typeYourFirstTaskHereTextField.typeText("medium")
        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        
        let addAnotherTaskTextField = app.textFields["Add another task..."]
        addAnotherTaskTextField.tap()
        addAnotherTaskTextField.typeText("large")
        nextButton.tap()
        app.buttons["large"].tap()
        addTaskButton.tap()
        addAnotherTaskTextField.tap()
        addAnotherTaskTextField.typeText("small")
        nextButton.tap()
        app.buttons["medium"].tap()
        
    }
    
    
}
