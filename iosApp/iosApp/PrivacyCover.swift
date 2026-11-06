import SwiftUI

/// Shown over unlocked content whenever the app isn't active, so the app switcher snapshot holds no patient data.
struct PrivacyCover: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Rectangle()
                .fill(Theme.accent)
                .frame(width: 16, height: 16)
            Text("MedScribe")
                .font(.system(size: 44, weight: .bold))
                .tracking(-1.5)
                .foregroundStyle(Theme.ink)
            Spacer()
        }
        .padding(.horizontal, 28)
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.white.ignoresSafeArea())
        .accessibilityHidden(true)
    }
}
