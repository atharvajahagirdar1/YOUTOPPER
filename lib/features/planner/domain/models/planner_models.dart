enum SessionModality {
  learn,
  practice,
  revision
}

class PlannerSession {
  final String id;
  final String title;
  final String subject;
  final String chapter;
  final String details; // e.g., "1NF to 3NF decompositions"
  final int durationMinutes;
  final SessionModality modality;
  final DateTime scheduledTime;
  final bool isCompleted;

  const PlannerSession({
    required this.id,
    required this.title,
    required this.subject,
    required this.chapter,
    required this.details,
    required this.durationMinutes,
    required this.modality,
    required this.scheduledTime,
    this.isCompleted = false,
  });
}

class UpcomingDay {
  final DateTime date;
  final String title;
  final String details;
  final int totalDuration;
  final SessionModality primaryModality;

  const UpcomingDay({
    required this.date,
    required this.title,
    required this.details,
    required this.totalDuration,
    required this.primaryModality,
  });
}

class WorkloadDay {
  final String dayLabel; // M, T, W, T, F, S, S
  final double hours;
  final bool isToday;

  const WorkloadDay({
    required this.dayLabel,
    required this.hours,
    this.isToday = false,
  });
}
