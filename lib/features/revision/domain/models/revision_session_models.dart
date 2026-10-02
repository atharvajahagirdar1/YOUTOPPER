

class RevisionSessionData {
  final int currentConceptIndex;
  final int totalConcepts;
  final String subject;
  final String chapter;
  final String lastReviewed;
  final String conceptTitle;
  final String description;

  final RecallAnchorData recallAnchor;
  final TableAnchorData? tableAnchor;
  final UniversalRuleData? universalRule;
  final RecognitionCheckData? recognitionCheck;
  
  final String nextConceptTitle;

  const RevisionSessionData({
    required this.currentConceptIndex,
    required this.totalConcepts,
    required this.subject,
    required this.chapter,
    required this.lastReviewed,
    required this.conceptTitle,
    required this.description,
    required this.recallAnchor,
    this.tableAnchor,
    this.universalRule,
    this.recognitionCheck,
    required this.nextConceptTitle,
  });
}

class RecallAnchorData {
  final String flowTime;
  final String question;
  final String determinantText;
  final String determinantSub;
  final String dependentTextHidden;
  final String dependentTextRevealed;
  final String dependentSub;
  final String relationText;

  const RecallAnchorData({
    required this.flowTime,
    required this.question,
    required this.determinantText,
    required this.determinantSub,
    required this.dependentTextHidden,
    required this.dependentTextRevealed,
    required this.dependentSub,
    required this.relationText,
  });
}

class TableAnchorData {
  final String title;
  final String tupleCount;
  final List<String> headers;
  final List<List<String>> rows;
  final String note;

  const TableAnchorData({
    required this.title,
    required this.tupleCount,
    required this.headers,
    required this.rows,
    required this.note,
  });
}

class UniversalRuleData {
  final String title;
  final String equation;
  final String text;
  final String leftSub;
  final String rightSub;

  const UniversalRuleData({
    required this.title,
    required this.equation,
    required this.text,
    required this.leftSub,
    required this.rightSub,
  });
}

class RecognitionCheckData {
  final String question;
  final List<RecognitionOption> options;
  final String feedback;

  const RecognitionCheckData({
    required this.question,
    required this.options,
    required this.feedback,
  });
}

class RecognitionOption {
  final String id;
  final String text;
  final bool isCorrect;
  final String? badge;

  const RecognitionOption({
    required this.id,
    required this.text,
    required this.isCorrect,
    this.badge,
  });
}
