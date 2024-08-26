class AppStringFormat {
  // 12:35:53 처럼
  static String durationFormat(Duration duration) {
    if (duration == null) {
      return '0:00:00';
    }
    // 시간 부분
    String hours = duration.inHours.toString();

    // 분 부분, 두 자리로 맞추기 위해 padLeft 사용
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');

    // 초 부분, 두 자리로 맞추기 위해 padLeft 사용
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }
}
