const _ellipsis = '...';

String trimEllipsis(String input, {required int maxChars}) {
  if (input.length > maxChars) {
    return input.substring(0, maxChars - _ellipsis.length) + _ellipsis;
  }
  return input;
}
