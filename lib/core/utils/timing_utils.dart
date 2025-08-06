extension FutureMinDuration<T> on Future<T> {
  Future<T> withMinDuration(Duration duration) async {
    final results = await Future.wait([this, Future.delayed(duration)]);
    return results.first;
  }
}
