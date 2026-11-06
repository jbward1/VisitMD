package com.ward.medscribe

interface PatientRepository {
    fun patients(): List<Patient>
    fun unnamedRecordings(): List<UnnamedRecording>
}

class StubPatientRepository : PatientRepository {
    override fun patients(): List<Patient> = listOf(
        Patient(id = "p1", name = "Maria Lopez", visitCount = 3, lastVisitLabel = "today", openTodoCount = 3),
        Patient(id = "p2", name = "James Okafor", visitCount = 1, lastVisitLabel = "today", openTodoCount = 3),
        Patient(id = "p3", name = "Ana Silva", visitCount = 2, lastVisitLabel = "Mon 2 Nov", openTodoCount = 2),
        Patient(id = "p4", name = "Robert Chen", visitCount = 4, lastVisitLabel = "Mon 2 Nov", openTodoCount = 1),
    )

    override fun unnamedRecordings(): List<UnnamedRecording> = listOf(
        UnnamedRecording(id = "r1", recordedAtLabel = "today 08:30", durationMinutes = 6),
    )
}
