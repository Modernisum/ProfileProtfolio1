import 'dart:async';
import 'dart:isolate';

class ParallelOperations {
  /// Executes multiple tasks in parallel and returns their results
  static Future<List<T>> executeParallel<T>({
    required List<Future<T> Function()> tasks,
    int maxConcurrent = 4,
  }) async {
    final results = <T>[];
    final chunks = <List<Future<T> Function()>>[];
    
    // Split tasks into chunks based on maxConcurrent
    for (var i = 0; i < tasks.length; i += maxConcurrent) {
      chunks.add(tasks.sublist(i, 
        i + maxConcurrent > tasks.length ? tasks.length : i + maxConcurrent));
    }

    // Execute chunks sequentially but tasks within chunks in parallel
    for (final chunk in chunks) {
      final chunkResults = await Future.wait(
        chunk.map((task) => task()),
      );
      results.addAll(chunkResults);
    }

    return results;
  }

  /// Executes a heavy computation in a separate isolate
  static Future<T> computeInIsolate<T, P>({
    required T Function(P) computation,
    required P parameter,
  }) async {
    return await Isolate.run(() => computation(parameter));
  }

  /// Executes multiple heavy computations in parallel using isolates
  static Future<List<T>> computeParallel<T, P>({
    required T Function(P) computation,
    required List<P> parameters,
    int maxConcurrent = 4,
  }) async {
    final results = <T>[];
    final chunks = <List<P>>[];
    
    // Split parameters into chunks
    for (var i = 0; i < parameters.length; i += maxConcurrent) {
      chunks.add(parameters.sublist(i, 
        i + maxConcurrent > parameters.length ? parameters.length : i + maxConcurrent));
    }

    // Execute chunks sequentially but computations within chunks in parallel
    for (final chunk in chunks) {
      final chunkResults = await Future.wait(
        chunk.map((param) => computeInIsolate(
          computation: computation,
          parameter: param,
        )),
      );
      results.addAll(chunkResults);
    }

    return results;
  }

  /// Executes a task with timeout
  static Future<T> withTimeout<T>({
    required Future<T> Function() task,
    required Duration timeout,
    T? defaultValue,
  }) async {
    try {
      return await task().timeout(timeout);
    } on TimeoutException {
      if (defaultValue != null) {
        return defaultValue;
      }
      rethrow;
    }
  }
} 