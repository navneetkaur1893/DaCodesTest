//
//  APIServiceFactory.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import Foundation

import Foundation

class APIServiceFactory {
    private static var isTesting: Bool {
        return Utils.isTestCaseRunning()
    }
    static var moviesAPIService: MoviesAPIServiceRepresentable {
        if isTesting {
            return MockServiceCalls.shared
        }
        return ServiceCalls.shared
    }
}
