import 'package:flutter/material.dart';

enum QuestionType {
  singleCorrect,
  multipleCorrect,
}

class PracticeOption {
  final String id;
  final String label;
  final String title;
  final String? subtitle;

  const PracticeOption({
    required this.id,
    required this.label,
    required this.title,
    this.subtitle,
  });
}

class VisualModelNode {
  final String title;
  final String role;
  
  const VisualModelNode({required this.title, required this.role});
}

class FunctionalDependencyVisual {
  final IconData headerIcon;
  final String headerTitle;
  final String pillText;
  
  final VisualModelNode determinant;
  final VisualModelNode dependent;
  final String relationshipText;
  
  final String footerText;
  
  const FunctionalDependencyVisual({
    required this.headerIcon,
    required this.headerTitle,
    required this.pillText,
    required this.determinant,
    required this.dependent,
    required this.relationshipText,
    required this.footerText,
  });
}

class FeedbackVisualElement {
  final IconData icon;
  final String title;
  final String subtitle;
  
  const FeedbackVisualElement({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class QuestionFeedback {
  final String title;
  final String description;
  final List<FeedbackVisualElement>? visualElements;
  final String? whyThisHolds;
  final bool isCorrect;
  
  const QuestionFeedback({
    required this.title,
    required this.description,
    this.visualElements,
    this.whyThisHolds,
    required this.isCorrect,
  });
}

class PracticeQuestion {
  final String id;
  final int number;
  final QuestionType type;
  final String text;
  final List<PracticeOption> options;
  final String correctAnswerId;
  final dynamic visualData; 
  final QuestionFeedback? feedback;

  const PracticeQuestion({
    required this.id,
    required this.number,
    required this.type,
    required this.text,
    required this.options,
    required this.correctAnswerId,
    this.visualData,
    this.feedback,
  });
}

class PracticeSession {
  final String id;
  final String subject;
  final String chapter;
  final String topic;
  final String title;
  final int totalQuestions;
  final List<PracticeQuestion> questions;

  const PracticeSession({
    required this.id,
    required this.subject,
    required this.chapter,
    required this.topic,
    required this.title,
    required this.totalQuestions,
    required this.questions,
  });
}
