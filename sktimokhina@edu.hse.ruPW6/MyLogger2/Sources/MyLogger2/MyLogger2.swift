import Foundation

public struct MyLogger2 {
    public static func log(_ message: String) {
        print("MyLogger2 from swift package (\(Date())): \(message)")
    }
}
