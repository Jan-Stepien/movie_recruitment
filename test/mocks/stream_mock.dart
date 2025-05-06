import 'dart:async';

import 'package:mocktail/mocktail.dart';

class MockStream<T> extends Mock implements Stream<T> {}

class MockStreamController<T> extends Mock implements StreamController<T> {}
