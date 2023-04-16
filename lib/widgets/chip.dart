class chip {
  final String label;
  var index = 0;

  chip({
    required this.label,
    required this.index,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is chip && runtimeType == other.runtimeType && label == other.label;

  @override
  int get hashCode => label.hashCode;
}
