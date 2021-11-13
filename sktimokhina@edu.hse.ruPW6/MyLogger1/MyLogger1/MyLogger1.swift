//
//  MyLogger1.swift
//  MyLogger1
//
//  Created by Софья Тимохина on 13.11.2021.
//

import Foundation

public final class MyLogger1 {
    public static func log(_ message: String) {
        print("MyLogger1 from framework (\(Date())): \(message)")
    }
}
