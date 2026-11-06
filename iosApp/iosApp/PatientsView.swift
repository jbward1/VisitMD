import SharedLogic
import SwiftUI

struct PatientsView: View {
    let appLock: AppLock
    @State private var model = PatientsViewModel()
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    if !model.unnamedRecordings.isEmpty {
                        needsNameSection
                    }
                    allPatientsSection
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 28)
            }
            .scrollDismissesKeyboard(.immediately)
            if !isSearchFocused {
                BottomBar()
            }
        }
        .foregroundStyle(Theme.ink)
        .background(Color.white.ignoresSafeArea())
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Patients")
                        .font(.system(size: 40, weight: .bold))
                        .tracking(-1.4)
                        .accessibilityAddTraits(.isHeader)
                    Text("\(model.patientCount) patients · A–Z")
                        .font(Theme.label(12))
                        .tracking(1)
                        .textCase(.uppercase)
                        .foregroundStyle(Theme.secondary)
                }
                Spacer()
                Button {
                    appLock.lock()
                } label: {
                    Image(systemName: "lock")
                        .font(.system(size: 17, weight: .medium))
                        .frame(width: 44, height: 44)
                        .overlay(Rectangle().stroke(Theme.ink, lineWidth: 1.5))
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Lock app")
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Find a patient")
                    .font(Theme.label())
                    .tracking(0.9)
                    .textCase(.uppercase)
                    .foregroundStyle(Theme.secondary)
                    .accessibilityHidden(true)
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 17, weight: .medium))
                        .accessibilityHidden(true)
                    TextField("Patient name", text: $model.query)
                        .font(.system(size: 18))
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                        .focused($isSearchFocused)
                        .accessibilityLabel("Find a patient")
                }
                .padding(.bottom, 8)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Theme.ink).frame(height: 2)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
    }

    private var needsNameSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeader(title: "Needs a name", color: Theme.accent)
            ForEach(model.unnamedRecordings, id: \.self) { recording in
                Row(title: "No name heard", subtitle: recording.summary, titleColor: Theme.secondary) {
                    Text("Add name")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Theme.accent)
                }
            }
        }
    }

    private var allPatientsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeader(title: "All patients")
            if model.patients.isEmpty {
                Text("No patients match “\(model.query.trimmingCharacters(in: .whitespaces))”.")
                    .font(.system(size: 15))
                    .foregroundStyle(Theme.secondary)
                    .padding(.vertical, 20)
            }
            ForEach(model.patients, id: \.self) { patient in
                Row(title: patient.name, subtitle: patient.visitSummary) {
                    Text(patient.todoLabel)
                        .font(.system(size: 14))
                }
            }
        }
    }
}

private struct Row<Trailing: View>: View {
    let title: String
    let subtitle: String
    var titleColor: Color = Theme.ink
    @ViewBuilder let trailing: Trailing

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .tracking(-0.2)
                    .foregroundStyle(titleColor)
                Text(subtitle)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(Theme.secondary)
            }
            Spacer()
            trailing
        }
        .frame(minHeight: 64)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Theme.hairline).frame(height: 1)
        }
        .accessibilityElement(children: .combine)
    }
}

private struct BottomBar: View {
    var body: some View {
        HStack {
            tab(title: "Patients", systemImage: "person", isActive: true)
            Button {
                // Recording isn't built yet.
            } label: {
                Circle()
                    .fill(Theme.accent)
                    .frame(width: 72, height: 72)
                    .overlay(Circle().fill(.white).frame(width: 24, height: 24))
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Start recording")
            tab(title: "To-do", systemImage: "checklist", isActive: false)
        }
        .padding(.horizontal, 24)
        .padding(.top, 12)
        .padding(.bottom, 4)
        .overlay(alignment: .top) {
            Rectangle().fill(Theme.hairline).frame(height: 1)
        }
    }

    private func tab(title: String, systemImage: String, isActive: Bool) -> some View {
        VStack(spacing: 4) {
            Image(systemName: systemImage)
                .font(.system(size: 20, weight: isActive ? .semibold : .regular))
            Text(title)
                .font(.system(size: 13, weight: isActive ? .bold : .medium))
        }
        .foregroundStyle(isActive ? Theme.ink : Theme.secondary)
        .frame(maxWidth: .infinity, minHeight: 52)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isActive ? [.isButton, .isSelected] : .isButton)
    }
}

#Preview {
    PatientsView(appLock: AppLock())
}
