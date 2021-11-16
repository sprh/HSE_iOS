//
//  MyLogger3.swift
//  MyLogger3
//
//  Created by Софья Тимохина on 13.11.2021.
//

import Foundation

public struct MyLogger3 {
    public static func log(_ message: String) {
        print("MyLogger3 from pod (\(Date())): \(message)")
    }
}
