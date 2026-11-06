import Observation
import SharedLogic

@Observable
final class PatientsViewModel {
    var query = ""
    let unnamedRecordings: [UnnamedRecording]
    private let allPatients: [Patient]

    init(repository: PatientRepository = StubPatientRepository()) {
        allPatients = repository.patients()
        unnamedRecordings = repository.unnamedRecordings()
    }

    var patientCount: Int { allPatients.count }

    var patients: [Patient] {
        PatientSearchKt.searchPatients(patients: allPatients, query: query)
    }
}
