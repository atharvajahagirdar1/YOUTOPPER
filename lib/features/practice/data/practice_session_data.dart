import 'package:flutter/material.dart';
import '../domain/models/practice_session_models.dart';

final PracticeSession demoPracticeSession = PracticeSession(
  id: 'ps_1',
  subject: 'DBMS',
  chapter: 'CHAPTER 3',
  topic: 'RELATIONAL THEORY',
  title: 'Database Normalization',
  totalQuestions: 8,
  questions: [
    PracticeQuestion(
      id: 'q_3',
      number: 3,
      type: QuestionType.singleCorrect,
      text: 'Which attribute uniquely identifies each student record without ambiguity?',
      visualData: FunctionalDependencyVisual(
        headerIcon: Icons.account_tree_outlined,
        headerTitle: 'FUNCTIONAL DEPENDENCY MODEL',
        pillText: 'FD: X → Y',
        determinant: VisualModelNode(title: 'Student_ID', role: 'DETERMINANT'),
        dependent: VisualModelNode(title: 'Student_Name', role: 'DEPENDENT'),
        relationshipText: 'DETERMINES (→)',
        footerText: '1:1 Determinant Mapping · Superkey Candidate',
      ),
      options: [
        PracticeOption(
          id: 'opt_a',
          label: 'A',
          title: 'Student_ID',
          subtitle: 'Primary Unique Key',
        ),
        PracticeOption(
          id: 'opt_b',
          label: 'B',
          title: 'Student_Name',
          subtitle: 'May produce collisions',
        ),
        PracticeOption(
          id: 'opt_c',
          label: 'C',
          title: 'Department',
          subtitle: '1:N Category group',
        ),
        PracticeOption(
          id: 'opt_d',
          label: 'D',
          title: 'None of these',
          subtitle: 'Null hypothesis',
        ),
      ],
      correctAnswerId: 'opt_a',
      feedback: QuestionFeedback(
        title: 'Correct Understanding',
        description: 'Student_ID is atomic, invariant, and uniquely isolates each student tuple.',
        isCorrect: true,
        visualElements: [
          FeedbackVisualElement(
            icon: Icons.fingerprint,
            title: 'Student_ID',
            subtitle: 'P-KEY · Cardinality 1.0',
          ),
          FeedbackVisualElement(
            icon: Icons.layers_outlined,
            title: 'Student_Name',
            subtitle: 'Duplicates Expected',
          ),
        ],
        whyThisHolds: 'Because Student_ID is guaranteed unique across all academic departments, while multiple individuals can share identical full names, making Student_Name non-injective.',
      ),
    ),
  ],
);
