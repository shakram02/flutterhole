import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutterhole_web/features/entities/logging_entities.dart';
import 'package:flutterhole_web/top_level_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

const importLoggers = null;

extension BuildContextX on BuildContext {
  /// Only works inside [HookWidget]s.
  void log(LogCall call) => read(logNotifierProvider.notifier).log(call);
}

final loggerProvider = Provider.family<Logger, String>((ref, name) {
  return Logger(name);
});

final logNotifierProvider = StateNotifierProvider<LogNotifier, List<LogRecord>>(
    (ref) => LogNotifier.fromStream(
        ref.watch(rootLoggerProvider), ref.watch(logStreamProvider.stream)));

extension LogLevelX on LogLevel {
  Level get level {
    switch (this) {
      case LogLevel.debug:
        return Level.FINE;
      case LogLevel.info:
        return Level.INFO;
      case LogLevel.warning:
        return Level.WARNING;
      case LogLevel.error:
        return Level.SEVERE;
    }
  }
}

class LogNotifier extends StateNotifier<List<LogRecord>> {
  LogNotifier._(this._root) : super([]);

  factory LogNotifier.fromStream(Logger root, Stream<LogRecord> stream) {
    final log = LogNotifier._(root);
    log.listenToStream(stream);
    return log;
  }

  final Logger _root;
  StreamSubscription<LogRecord>? _subscription;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void onData(LogRecord record) {
    if (state.isEmpty) {
      state = [record, ...state];
      return;
    }

    if (state.first != record) {
      state = [record, ...state];
    }
  }

  // TODO multiple?
  void listenToStream(Stream<LogRecord> stream) {
    _subscription = stream.listen(onData);
    state = [];
  }

  void log(LogCall call) {
    _root.log(call.level.level, call.message, call.error, call.stackTrace);
  }
}

final rootLoggerProvider = Provider<Logger>((ref) {
  final level = ref.watch(logLevelProvider);
  Logger.root.level = level.level;

  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  return Logger.root;
});

final logStreamProvider = StreamProvider<LogRecord>((ref) async* {
  yield* ref.watch(rootLoggerProvider).onRecord;
});

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    debugPrint('''

  "{ provider": "${provider.name ?? provider.runtimeType}",
  "  newValue": ${newValue.toString()} }
''');
  }
}
