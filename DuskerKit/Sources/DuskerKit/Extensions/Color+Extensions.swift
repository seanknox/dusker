import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@available(iOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension Color {
    static let primaryBackground = Color("PrimaryBackground")
    static let accentColor = Color("AccentColor")
    static let textLight = Color("TextLight")
    static let textDark = Color("TextDark")
    
    #if canImport(UIKit)
    func toUIColor() -> UIColor {
        UIColor(self)
    }
    #elseif canImport(AppKit)
    @available(macOS 11.0, *)
    func toNSColor() -> NSColor {
        NSColor(self)
    }
    #endif
} 