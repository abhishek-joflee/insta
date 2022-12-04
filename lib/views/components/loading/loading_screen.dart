import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/strings.dart';

class LoadingScreen {
  LoadingScreen._();
  static final _i = LoadingScreen._();
  static LoadingScreen get instance => _i;

  _LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    }
    _controller = _showOverlay(
      context: context,
      text: text,
    );
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  _LoadingScreenController? _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    if (state == null) {
      return null;
    }

    final textController = StreamController<String>()..add(text);

    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (_) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.8,
                maxWidth: size.width * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: textController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.requireData,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return _LoadingScreenController(
      close: () {
        textController.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}

//* Loading Screen Controller
@immutable
class _LoadingScreenController {
  const _LoadingScreenController({
    required this.close,
    required this.update,
  });

  final bool Function() close;
  final bool Function(String) update;
}
