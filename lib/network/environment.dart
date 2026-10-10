enum AppEnvironment { localMockoon, staging, production }

/// Pilih environment saat build/run:
///   flutter run --dart-define=APP_ENV=local        -> backend lokal (php artisan serve / serve:workers)
///   flutter run --dart-define=APP_ENV=production   -> https://api-ammar.pranalatech.com (default)
const String _appEnvName = String.fromEnvironment(
  'APP_ENV',
  defaultValue: 'production',
);

final appMode = switch (_appEnvName) {
  'local' => AppEnvironment.localMockoon,
  'staging' => AppEnvironment.staging,
  _ => AppEnvironment.production,
};

/// true = pakai data mock (tanpa backend) untuk mengembangkan UI:
///   flutter run --dart-define=USE_MOCK=true
final mockStatus = const bool.fromEnvironment('USE_MOCK');

/// Semua path di ApiService berawalan `/v1/...`, sedangkan Laravel menaruh API di bawah `/api`,
/// jadi base URL harus berakhiran `/api`. Bisa ditimpa: --dart-define=API_BASE_URL=https://host/api
const String _baseUrlOverride = String.fromEnvironment('API_BASE_URL');

// Android emulator memakai 10.0.2.2 untuk menjangkau localhost komputer.
const String localBaseUrl = 'http://10.0.2.2:8000/api';
const String stagingBaseUrl = 'https://api-ammar.pranalatech.com/api';
const String productionBaseUrl = 'https://api-ammar.pranalatech.com/api';

String get apiBaseUrl {
  if (_baseUrlOverride.isNotEmpty) return _baseUrlOverride;

  return switch (appMode) {
    AppEnvironment.localMockoon => localBaseUrl,
    AppEnvironment.staging => stagingBaseUrl,
    AppEnvironment.production => productionBaseUrl,
  };
}
