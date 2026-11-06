import SwiftUI

enum Theme {
    static let ink = Color(hex: 0x111111)
    static let secondary = Color(hex: 0x5C5C5C)
    static let hairline = Color(hex: 0xE6E6E6)
    static let accent = Color(hex: 0xD9381E)

    /// Small uppercase monospaced label used for section headers and metadata.
    static func label(_ size: CGFloat = 11) -> Font {
        .system(size: size, weight: .medium, design: .monospaced)
    }
}

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

struct SectionHeader: View {
    let title: String
    var color: Color = Theme.ink

    var body: some View {
        Text(title)
            .font(Theme.label())
            .tracking(0.9)
            .textCase(.uppercase)
            .foregroundStyle(color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
            .overlay(alignment: .bottom) {
                Rectangle().fill(color).frame(height: 1)
            }
            .accessibilityAddTraits(.isHeader)
    }
}
