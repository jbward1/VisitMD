package com.ward.medscribe

import kotlin.test.Test
import kotlin.test.assertEquals

class PatientTest {

    private fun patient(visitCount: Int = 1, openTodoCount: Int = 0) = Patient(
        id = "1",
        name = "Maria Lopez",
        visitCount = visitCount,
        lastVisitLabel = "Mon 2 Nov",
        openTodoCount = openTodoCount,
    )

    @Test
    fun visitSummaryUsesSingularForOneVisit() {
        assertEquals("1 visit · last Mon 2 Nov", patient(visitCount = 1).visitSummary)
    }

    @Test
    fun visitSummaryUsesPluralForSeveralVisits() {
        assertEquals("3 visits · last Mon 2 Nov", patient(visitCount = 3).visitSummary)
    }

    @Test
    fun todoLabelShowsOpenCount() {
        assertEquals("2 to-do", patient(openTodoCount = 2).todoLabel)
    }

    @Test
    fun unnamedRecordingSummaryShowsTimeAndLength() {
        val recording = UnnamedRecording(id = "r1", recordedAtLabel = "today 08:30", durationMinutes = 6)
        assertEquals("Recorded today 08:30 · 6 min", recording.summary)
    }
}
