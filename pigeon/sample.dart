import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/generated/sample.g.dart',
    dartOptions: DartOptions(),
    swiftOut: 'ios/Runner/generated/Sample.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
abstract class SampleApi {
  @async
  Sample fetchSampleAsync(SampleParameter parameter);

  Sample fetchSampleSync(SampleParameter parameter);

  @async
  Object? objectSampleAsync(Object? parameter);

  Object? objectSampleSync(Object? parameter);
}

@FlutterApi()
abstract class CallFromNative {
  Sample fetchSample(SampleParameter parameter);

  Object? objectSample(Object? parameter);
}

class Sample {
  Sample({
    required this.text,
    required this.id,
  });
  final String text;
  final int id;
}

class SampleParameter {
  SampleParameter({
    required this.text,
    required this.id,
  });
  final String text;
  final int id;
}
