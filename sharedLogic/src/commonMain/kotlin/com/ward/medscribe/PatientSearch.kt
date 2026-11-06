package com.ward.medscribe

/** Patients whose name contains [query] (case-insensitive), sorted A–Z; a blank query matches everyone. */
fun searchPatients(patients: List<Patient>, query: String): List<Patient> {
    val needle = query.trim()
    return patients
        .filter { needle.isEmpty() || it.name.contains(needle, ignoreCase = true) }
        .sortedBy { it.name.lowercase() }
}
