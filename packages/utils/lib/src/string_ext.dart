extension StringExt on String {
  String toTitleCase() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return split(' ')
        .map(
          (e) => e[0].toUpperCase() + e.substring(1).toLowerCase(),
        )
        .join(' ');
  }
}
