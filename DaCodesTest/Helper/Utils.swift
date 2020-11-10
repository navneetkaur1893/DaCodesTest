//
//  Utils.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import Foundation

class Utils {
    static func isTestCaseRunning() -> Bool {
        if NSClassFromString("XCTest") != nil || ProcessInfo.processInfo.arguments.contains("isTestMode") {
            return true
        } else {
            return false
        }
    }
}
