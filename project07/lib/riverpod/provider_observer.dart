import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  // provider에서 변경사항 발생
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    print('[Provider Updated] provider $provider / $previousValue -> $newValue');
  }

  // app에 새 provider 들어옴
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    print('[Provider Added] provider $provider / $value');
  }


  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    print('[Provider Disposed] provider $provider');
  }
}