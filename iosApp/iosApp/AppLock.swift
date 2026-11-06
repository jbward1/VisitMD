import LocalAuthentication
import Observation

@MainActor
@Observable
final class AppLock {
    private(set) var isUnlocked = false
    private(set) var errorMessage: String?

    func unlock() async {
        let context = LAContext()
        var policyError: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &policyError) else {
            errorMessage = "Face ID isn't set up on this iPhone."
            return
        }
        do {
            isUnlocked = try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Unlock your patient notes."
            )
            errorMessage = nil
        } catch LAError.userCancel, LAError.appCancel, LAError.systemCancel {
            errorMessage = nil
        } catch {
            errorMessage = "Face ID didn't recognise you. Try again."
        }
    }

    func lock() {
        isUnlocked = false
    }
}
