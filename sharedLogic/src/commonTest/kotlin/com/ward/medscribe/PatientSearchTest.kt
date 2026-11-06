package com.ward.medscribe

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

class PatientSearchTest {

    private val patients = listOf(
        Patient(id = "1", name = "Robert Chen", visitCount = 1, lastVisitLabel = "today", openTodoCount = 0),
        Patient(id = "2", name = "ana silva", visitCount = 1, lastVisitLabel = "today", openTodoCount = 0),
        Patient(id = "3", name = "Maria Lopez", visitCount = 1, lastVisitLabel = "today", openTodoCount = 0),
    )

    private fun names(result: List<Patient>) = result.map { it.name }

    @Test
    fun blankQueryReturnsEveryoneSortedAToZIgnoringCase() {
        assertEquals(listOf("ana silva", "Maria Lopez", "Robert Chen"), names(searchPatients(patients, "")))
    }

    @Test
    fun matchesAnyPartOfTheNameIgnoringCase() {
        assertEquals(listOf("Maria Lopez"), names(searchPatients(patients, "LOP")))
    }

    @Test
    fun ignoresSurroundingWhitespace() {
        assertEquals(listOf("Robert Chen"), names(searchPatients(patients, "  chen ")))
    }

    @Test
    fun returnsNothingWhenNoNameMatches() {
        assertTrue(searchPatients(patients, "Okafor").isEmpty())
    }
}
