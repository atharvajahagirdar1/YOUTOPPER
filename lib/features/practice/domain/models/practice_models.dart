import 'package:flutter/material.dart';

class PracticeFilter {
  final String id;
  final String label;
  final int count;

  const PracticeFilter({
    required this.id,
    required this.label,
    this.count = 0,
  });
}

class PracticeStep {
  final String label;
  final IconData icon;

  const PracticeStep({
    required this.label,
    required this.icon,
  });
}

class PracticeSet {
  final String id;
  final String subject;
  final String chapter;
  final String title;
  final String? description;
  final int questionCount;
  final int estimatedMinutes;
  final String difficulty; // Easy, Medium, Hard, Medium Depth
  final bool isRecommended;
  final bool isInProgress;
  final int? progressStep;
  final int? totalSteps;
  final String? progressSubtitle;
  
  final List<PracticeStep>? overviewSteps;
  final IconData? topicIcon;

  const PracticeSet({
    required this.id,
    required this.subject,
    required this.chapter,
    required this.title,
    this.description,
    required this.questionCount,
    required this.estimatedMinutes,
    required this.difficulty,
    this.isRecommended = false,
    this.isInProgress = false,
    this.progressStep,
    this.totalSteps,
    this.progressSubtitle,
    this.overviewSteps,
    this.topicIcon,
  });
}

class PracticeHubData {
  final int totalSetsReady;
  final PracticeSet? recommendedSet;
  final PracticeSet? inProgressSet;
  final List<PracticeSet> topicSets;
  final List<PracticeFilter> filters;

  const PracticeHubData({
    required this.totalSetsReady,
    this.recommendedSet,
    this.inProgressSet,
    required this.topicSets,
    required this.filters,
  });
}
