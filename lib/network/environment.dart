enum AppEnvironment { localMockoon, staging, production }

///   flutter run --dart-define=APP_ENV=local
///   flutter run --dart-define=APP_ENV=production
const String appEnvName = String.fromEnvironment(
  'APP_ENV',
  defaultValue: 'production',
);

final appMode = switch (appEnvName) {
  'local' => AppEnvironment.localMockoon,
  'staging' => AppEnvironment.staging,
  _ => AppEnvironment.production,
};

/// true = pakai data mock:
///   flutter run --dart-define=USE_MOCK=true
final mockStatus = const bool.fromEnvironment('USE_MOCK');

const String baseUrlOverride = String.fromEnvironment('API_BASE_URL');

const String localBaseUrl = 'http://10.0.2.2:8000/api';
const String stagingBaseUrl = 'https://api-ammar.pranalatech.com/api';
const String productionBaseUrl = 'https://api-ammar.pranalatech.com/api';

String get apiBaseUrl {
  if (baseUrlOverride.isNotEmpty) return baseUrlOverride;

  return switch (appMode) {
    AppEnvironment.localMockoon => localBaseUrl,
    AppEnvironment.staging => stagingBaseUrl,
    AppEnvironment.production => productionBaseUrl,
  };
}
