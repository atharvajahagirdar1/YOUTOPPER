import 'package:flutter/material.dart';

class RevisionData {
  final PrimaryRevisionTask primaryTask;
  final List<SecondaryRevisionTask> alsoDue;
  final List<SecondaryRevisionTask> upcoming;
  final List<SecondaryRevisionTask> history;

  const RevisionData({
    required this.primaryTask,
    required this.alsoDue,
    required this.upcoming,
    required this.history,
  });
}

class PrimaryRevisionTask {
  final String priorityText;
  final String intervalText;
  final String subject;
  final String estimatedTime;
  final String title;
  final String description;
  final String retentionPercentage;
  final List<CadenceStep> cadenceSteps;
  final List<RevisionTag> tags;

  const PrimaryRevisionTask({
    required this.priorityText,
    required this.intervalText,
    required this.subject,
    required this.estimatedTime,
    required this.title,
    required this.description,
    required this.retentionPercentage,
    required this.cadenceSteps,
    required this.tags,
  });
}

class CadenceStep {
  final String label;
  final bool isCompleted;
  final bool isCurrent;
  final bool isFuture;

  const CadenceStep({
    required this.label,
    this.isCompleted = false,
    this.isCurrent = false,
    this.isFuture = false,
  });
}

class RevisionTag {
  final IconData icon;
  final String label;

  const RevisionTag({
    required this.icon,
    required this.label,
  });
}

class SecondaryRevisionTask {
  final String title;
  final String subtitle;
  final String? timeInfo;
  final String? dayText;
  final IconData? iconData;
  final Color? iconColor;

  const SecondaryRevisionTask({
    required this.title,
    required this.subtitle,
    this.timeInfo,
    this.dayText,
    this.iconData,
    this.iconColor,
  });
}
