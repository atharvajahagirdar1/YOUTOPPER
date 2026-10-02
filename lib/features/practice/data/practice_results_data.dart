import 'package:flutter/material.dart';
import '../domain/models/practice_results_models.dart';
import 'practice_session_data.dart'; // To get demoPracticeSession

final PracticeResult demoPracticeResult = PracticeResult(
  session: demoPracticeSession,
  correctCount: 6,
  incorrectCount: 2,
  skippedCount: 0,
  pacePerQuestion: '1m 18s',
  diagnosticTakeaway: 'Strong conceptual grasp of schema keys. Targeted drill on 2 decomposition questions will cement 3NF mastery.',
  questionStatuses: {
    1: AnswerStatus.correct,
    2: AnswerStatus.correct,
    3: AnswerStatus.correct,
    4: AnswerStatus.incorrect,
    5: AnswerStatus.correct,
    6: AnswerStatus.incorrect,
    7: AnswerStatus.correct,
    8: AnswerStatus.correct,
  },
  attentionConcepts: [
    AttentionConcept(
      id: 'ac_1',
      questionLabel: 'Q4 Revisit',
      title: 'Decomposition Anomalies',
      description: 'Distinguishing lossless join conditions from functional dependency preservation across schemas.',
      actionLabel: 'Review in Notes',
      actionIcon: Icons.menu_book,
    ),
    AttentionConcept(
      id: 'ac_2',
      questionLabel: 'Q6 Revisit',
      title: 'Lossless Decomposition',
      description: 'Verifying intersection attributes constitute a superkey of at least one sub-relation (R1 ∩ R2 → R1).',
      actionLabel: 'Practice 2 Focused Qs',
      actionIcon: Icons.tune,
    ),
  ],
  successfulConcepts: [
    SuccessfulConcept(
      id: 'sc_1',
      icon: Icons.account_tree_outlined,
      title: 'Functional Dependencies',
      rightLabel: '3/3 (100%)',
      description: 'Deterministic mapping and arrow notation were applied correctly with zero ambiguity.',
    ),
    SuccessfulConcept(
      id: 'sc_2',
      icon: Icons.view_column_outlined,
      title: 'Normal Forms (1NF & 2NF)',
      rightLabel: 'Mastered',
      description: 'Accurately spotted duplicate tuple collisions and candidate key requirements across multi-valued tables.',
    ),
    SuccessfulConcept(
      id: 'sc_3',
      icon: Icons.vpn_key_outlined,
      title: 'Identifying Candidate Keys',
      rightLabel: 'Flawless',
      description: 'Flawlessly distinguished prime vs. non-prime attributes in composite closure tests.',
    ),
  ],
);
