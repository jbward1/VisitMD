import SwiftUI

@main
struct iOSApp: App {
    @State private var appLock = AppLock()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            Group {
                if appLock.isUnlocked {
                    PatientsView(appLock: appLock)
                } else {
                    UnlockView(appLock: appLock)
                }
            }
            .overlay {
                // Only unlocked content needs hiding; the Face ID prompt also makes the scene inactive.
                if appLock.isUnlocked && scenePhase != .active {
                    PrivacyCover()
                }
            }
            .preferredColorScheme(.light)
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .background {
                appLock.lock()
            }
        }
    }
}
