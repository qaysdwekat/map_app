import 'dart:developer' as log;
import 'dart:math';


mixin Retrier {

  //Execute retries running the passed function until the maxAttempt count
  //is reached or the function is returned.
  Future<T> execute<T>(int maxAttempt, T Function() fn) {
    var backoff = (int attempt) async => _backoff(attempt);

    Future<T> retry(int attempt, backoff) async {
      try {
        if (attempt == maxAttempt) {
          throw 'Failed';
        }
        return fn();
      } on ConnectionException {
        var _ = await backoff(attempt);
        return retry(++attempt, backoff);
      } on DeadlineException {
        var _ = await backoff(attempt);
        return retry(++attempt, backoff);
      } catch (e) {
        rethrow;
      }
    }

    return retry(0, backoff);
  }

  Future<bool> _backoff(int attempt) {
    var rand = Random();
    var jitter = rand.nextInt(100);
    //delay time to wait before next retry in milliseconds
    var delay = 100 * pow(1.7, attempt) + jitter;

    try {
      log.log('attempt: $attempt sleeping for $delay ms');
      return Future.delayed(Duration(milliseconds: delay.round()), () => true);
    } catch (e) {
      return Future.value(false);
    }
  }
}

class DeadlineException {
  DeadlineException({required String message, required String code});
}

class ConnectionException {
  ConnectionException({required String? message, required String? code});
}
