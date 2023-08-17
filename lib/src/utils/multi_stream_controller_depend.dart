import 'dart:async';

/// Utility class that handles initialization of an object which
/// multiple stream controllers depend on.
class MultiStreamControllerDepend<T> {
  MultiStreamControllerDepend(Iterable<StreamController> controllers, this.onInit, this.onUninit) {
    for (final controller in controllers) {
      controller.onListen = _onListen;
      controller.onCancel = _onCancel;
    }
  }

  T? object;

  T Function() onInit;
  void Function(T object) onUninit;

  int _listeners = 0;

  void _onListen() {
    object ??= onInit();
    ++_listeners;
  }

  void _onCancel() {
    if (--_listeners == 0) {
      onUninit(object as T);
      object = null;
    }
  }
}