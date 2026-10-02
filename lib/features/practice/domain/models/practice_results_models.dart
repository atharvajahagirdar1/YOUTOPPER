import 'package:flutter/material.dart';
import 'practice_session_models.dart';

enum AnswerStatus { correct, incorrect, skipped }

class AttentionConcept {
  final String id;
  final String questionLabel; 
  final String title;
  final String description;
  final String actionLabel;
  final IconData actionIcon;

  const AttentionConcept({
    required this.id,
    required this.questionLabel,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.actionIcon,
  });
}

class SuccessfulConcept {
  final String id;
  final IconData icon;
  final String title;
  final String rightLabel;
  final String description;

  const SuccessfulConcept({
    required this.id,
    required this.icon,
    required this.title,
    required this.rightLabel,
    required this.description,
  });
}

class PracticeResult {
  final PracticeSession session;
  final int correctCount;
  final int incorrectCount;
  final int skippedCount;
  final String pacePerQuestion;
  final String diagnosticTakeaway;
  final Map<int, AnswerStatus> questionStatuses; 
  
  final List<AttentionConcept> attentionConcepts;
  final List<SuccessfulConcept> successfulConcepts;

  const PracticeResult({
    required this.session,
    required this.correctCount,
    required this.incorrectCount,
    required this.skippedCount,
    required this.pacePerQuestion,
    required this.diagnosticTakeaway,
    required this.questionStatuses,
    required this.attentionConcepts,
    required this.successfulConcepts,
  });
  
  int get totalQuestions => session.totalQuestions;
  double get accuracy => totalQuestions > 0 ? (correctCount / totalQuestions) : 0.0;
}
