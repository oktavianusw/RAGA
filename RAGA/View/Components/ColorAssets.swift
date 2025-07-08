import SwiftUI

// MARK: - Hex Color Initializer
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - App Color Palette
extension Color {
    static let appGreen = Color(hex: "#1E3923")
    static let appCream = Color(hex: "#F5F2DB")
    static let appBlue = Color(hex: "#6BB1D9")
    static let appRed = Color(hex: "#C42E31")
    
    static let zone1 = Color(hex: "#9ED46E")
    static let zone2 = Color(hex: "#F1D302")
    static let zone3 = Color(hex: "#F09D3C")
    static let zone4 = Color(hex: "#EC6B4D")
    static let zone5 = Color(hex: "#D92B3A")
    
    static let zoneColors: [Color] = [.zone1, .zone2, .zone3, .zone4, .zone5]
}
