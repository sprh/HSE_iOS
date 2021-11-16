//
//  MyLogger4.swift
//  MyLogger4
//
//  Created by Vladislav on 13.11.2021.
//

import Foundation

// MARK: - MyLogger4

/// _MyLogger4_ is a basic logging struct.
public struct MyLogger4 {
    /// Prints the log message.
    public static func log(_ s: String) {
        print("MyLogger4 from carthage (\(Date())): \(s)")
    }
}
