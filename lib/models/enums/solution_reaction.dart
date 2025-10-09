enum SolutionReaction {
  none(0),
  like(1),
  dislike(2);

  final int value;

  const SolutionReaction(this.value);

  factory SolutionReaction.fromInt(int intValue) {
    return SolutionReaction.values.firstWhere(
      (e) => e.value == intValue,
      orElse: () => SolutionReaction.none,
    );
  }
}
