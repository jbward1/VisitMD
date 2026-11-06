import SwiftUI

struct UnlockView: View {
    let appLock: AppLock

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Rectangle()
                    .fill(Theme.accent)
                    .frame(width: 16, height: 16)
                    .accessibilityHidden(true)
                Text("MedScribe")
                    .font(.system(size: 44, weight: .bold))
                    .tracking(-1.5)
                Text("Visit notes, written for you. Private to this phone.")
                    .font(.system(size: 18))
                    .foregroundStyle(Theme.secondary)
                    .frame(maxWidth: 260, alignment: .leading)
            }

            Spacer()

            VStack(spacing: 20) {
                Image(systemName: "faceid")
                    .font(.system(size: 88, weight: .ultraLight))
                    .accessibilityHidden(true)
                Text("Face ID required")
                    .font(Theme.label(12))
                    .tracking(1)
                    .textCase(.uppercase)
                    .foregroundStyle(Theme.secondary)
            }
            .frame(maxWidth: .infinity)

            Spacer()

            VStack(alignment: .leading, spacing: 20) {
                if let message = appLock.errorMessage {
                    Text(message)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Theme.accent)
                }
                Button {
                    Task { await appLock.unlock() }
                } label: {
                    Text("Unlock with Face ID")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .foregroundStyle(.white)
                        .background(Theme.ink)
                }
                .buttonStyle(.plain)
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "lock")
                        .font(.system(size: 13, weight: .medium))
                        .accessibilityHidden(true)
                    Text("Audio, transcripts and summaries are made and stored only on this device. Nothing is uploaded.")
                        .font(.system(size: 13))
                }
                .foregroundStyle(Theme.secondary)
            }
        }
        .padding(.horizontal, 28)
        .padding(.top, 40)
        .padding(.bottom, 16)
        .foregroundStyle(Theme.ink)
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    UnlockView(appLock: AppLock())
}
