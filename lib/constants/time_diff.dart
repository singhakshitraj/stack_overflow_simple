class DateTimeDifference {
  String getDiff(String prev, DateTime after) {
    final DateTime previous = DateTime.parse(prev);
    if (after.difference(previous).inSeconds < 60) {
      return 'A Few Seconds Ago';
    } else if (after.difference(previous).inMinutes < 60) {
      return 'Posted ${after.difference(previous).inMinutes} Minutes Ago';
    } else if (after.difference(previous).inHours < 24) {
      return 'Posted ${after.difference(previous).inHours} Hours Ago';
    } else {
      return 'Posted ${after.difference(previous).inDays} Days Ago';
    }
  }
}
