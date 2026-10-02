import '../domain/models/planner_models.dart';

final DateTime _today = DateTime(2024, 9, 24, 9, 0); // Fake today: Sep 24

final PlannerSession demoNextUpSession = PlannerSession(
  id: '1',
  title: 'Database Normalization',
  subject: 'DBMS',
  chapter: 'CHAPTER 3',
  details: '1NF to 3NF decompositions',
  durationMinutes: 25,
  modality: SessionModality.learn,
  scheduledTime: DateTime(_today.year, _today.month, _today.day, 9, 0),
);

final List<PlannerSession> demoTodaysSchedule = [
  demoNextUpSession,
  PlannerSession(
    id: '2',
    title: 'Binary Search Trees',
    subject: 'Data Structures',
    chapter: 'Ch 5',
    details: '8 question set',
    durationMinutes: 35,
    modality: SessionModality.practice,
    scheduledTime: DateTime(_today.year, _today.month, _today.day, 11, 30),
  ),
  PlannerSession(
    id: '3',
    title: 'Functional Dependencies & Keys',
    subject: 'DBMS',
    chapter: '',
    details: 'Spaced recall interval · 3rd verification',
    durationMinutes: 15,
    modality: SessionModality.revision,
    scheduledTime: DateTime(_today.year, _today.month, _today.day, 18, 0),
  ),
];

final List<WorkloadDay> demoWorkload = [
  const WorkloadDay(dayLabel: 'M', hours: 2.0),
  const WorkloadDay(dayLabel: 'T', hours: 1.0),
  const WorkloadDay(dayLabel: 'W', hours: 2.2, isToday: true),
  const WorkloadDay(dayLabel: 'T', hours: 3.0),
  const WorkloadDay(dayLabel: 'F', hours: 1.0),
  const WorkloadDay(dayLabel: 'S', hours: 0.0), // represented as '-'
  const WorkloadDay(dayLabel: 'S', hours: 2.0),
];

final List<UpcomingDay> demoComingUp = [
  UpcomingDay(
    date: DateTime(_today.year, _today.month, 25),
    title: 'Operating Systems · Process Sch...',
    details: 'Round-robin & Preemption',
    totalDuration: 45,
    primaryModality: SessionModality.learn,
  ),
  UpcomingDay(
    date: DateTime(_today.year, _today.month, 26),
    title: 'DBMS · Unit Test Practice',
    details: 'SQL Queries & Integrity',
    totalDuration: 30,
    primaryModality: SessionModality.practice,
  ),
  UpcomingDay(
    date: DateTime(_today.year, _today.month, 27),
    title: 'Data Structures · Trees Revision',
    details: 'AVL balance factor recall',
    totalDuration: 20,
    primaryModality: SessionModality.revision,
  ),
];
