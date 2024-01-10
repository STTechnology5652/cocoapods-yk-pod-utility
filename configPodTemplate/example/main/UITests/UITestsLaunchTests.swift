//
//  YKRPC_POD_NAME_ExampleUITestsLaunchTests.swift
//  YKRPC_POD_NAME_ExampleUITests
//
//  Created by YKPRC_AUTHOR_NAME on YKPRC_CREATE_DATE.
//

import XCTest

final class YKRPC_POD_NAME_ExampleUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}