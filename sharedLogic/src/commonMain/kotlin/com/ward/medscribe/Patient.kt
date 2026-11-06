package com.ward.medscribe

data class Patient(
    val id: String,
    val name: String,
    val visitCount: Int,
    val lastVisitLabel: String,
    val openTodoCount: Int,
) {
    val visitSummary: String
        get() = "$visitCount ${if (visitCount == 1) "visit" else "visits"} · last $lastVisitLabel"

    val todoLabel: String
        get() = "$openTodoCount to-do"
}

data class UnnamedRecording(
    val id: String,
    val recordedAtLabel: String,
    val durationMinutes: Int,
) {
    val summary: String
        get() = "Recorded $recordedAtLabel · $durationMinutes min"
}
