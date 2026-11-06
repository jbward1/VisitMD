# Run from the repo root. iOS targets need macOS with Xcode.

PROJECT := iosApp/iosApp.xcodeproj
SCHEME  ?= iosApp
# App Store Connect API key for `make testflight` (kept out of git).
-include testflight.env
ASC_KEY_PATH ?= $(HOME)/.appstoreconnect/private_keys/AuthKey_$(ASC_KEY_ID).p8
# Build numbers must increase with every upload; a timestamp always does.
ifndef BUILD_NUMBER
BUILD_NUMBER := $(shell date +%Y%m%d.%H%M)
endif
ARCHIVE := build/ios/MedScribe.xcarchive
EXPORT_DIR := build/ios/export
ASC_AUTH = -allowProvisioningUpdates \
	-authenticationKeyPath "$(ASC_KEY_PATH)" \
	-authenticationKeyID $(ASC_KEY_ID) \
	-authenticationKeyIssuerID $(ASC_ISSUER_ID)

# Readable output if xcbeautify is installed (`brew install xcbeautify`), raw xcodebuild otherwise.
FORMAT := $(shell command -v xcbeautify >/dev/null 2>&1 && echo "| xcbeautify")

.PHONY: test-kotlin testflight

## Shared Kotlin: patient model, stub repository and search tests (iOS simulator target).
test-kotlin:
	./gradlew :sharedLogic:iosSimulatorArm64Test

## Release: run the Kotlin tests, archive a Release build and upload it to TestFlight.
testflight: test-kotlin
	@test -n "$(ASC_KEY_ID)" -a -n "$(ASC_ISSUER_ID)" || { echo "Set ASC_KEY_ID and ASC_ISSUER_ID in testflight.env (see testflight.env.example)."; exit 1; }
	@test -f "$(ASC_KEY_PATH)" || { echo "App Store Connect API key not found at $(ASC_KEY_PATH)."; exit 1; }
	rm -rf $(ARCHIVE) $(EXPORT_DIR)
	set -o pipefail; xcodebuild archive \
		-project $(PROJECT) \
		-scheme $(SCHEME) \
		-configuration Release \
		-destination 'generic/platform=iOS' \
		-archivePath $(ARCHIVE) \
		CURRENT_PROJECT_VERSION=$(BUILD_NUMBER) \
		$(ASC_AUTH) \
		$(FORMAT)
	set -o pipefail; xcodebuild -exportArchive \
		-archivePath $(ARCHIVE) \
		-exportPath $(EXPORT_DIR) \
		-exportOptionsPlist iosApp/ExportOptions.plist \
		$(ASC_AUTH) \
		$(FORMAT)
	@echo "Uploaded build $(BUILD_NUMBER). It shows up under TestFlight in App Store Connect once Apple finishes processing (usually 5-30 minutes)."
