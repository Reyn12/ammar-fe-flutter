import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_navigation_provider.g.dart';

@riverpod
class MainNavigationNotifier extends _$MainNavigationNotifier {
  @override
  int build() {
    return 0;
  }

  void changePage(int index) {
    state = index;
  }
}