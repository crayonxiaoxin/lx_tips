library lx_tips;

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

enum TipsGravity { top, bottom, center }

/// 弹框提示
class Tips {
  Tips._();

  late BuildContext _context;
  static Tips? _instance;
  OverlayEntry? _entry;
  AnimationController? _animationController;
  late Animation<double> _animate;
  OverlayState? _overlayState;

  dynamic _message;

  EdgeInsetsGeometry? _padding;
  EdgeInsetsGeometry? _margin;
  double _blurSigma = 3.0;
  BorderRadiusGeometry? _borderRadius;
  Color? _background;
  TextStyle? _textStyle;
  TextAlign? _textAlign;
  TipsGravity _gravity = TipsGravity.top;
  double _elevation = 0;

  late Duration _duration;
  late Duration _animateDuration;

  Timer? _hideAnimTimer;
  Timer? _clearTimer;

  static Tips of(BuildContext context) {
    _instance ??= Tips._();
    _instance?._context = context;
    return _instance!;
  }

  VoidCallback? _listener;

  /// content 可以是 widget 或者 任意基础类型
  show(
      {required dynamic content,
      Duration duration = const Duration(milliseconds: 2000),
      Duration animateDuration = const Duration(milliseconds: 300),
      EdgeInsetsGeometry? padding =
          const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      EdgeInsetsGeometry? margin =
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      double blurSigma = 5.0,
      BorderRadiusGeometry? borderRadius =
          const BorderRadius.all(Radius.circular(16)),
      Color? color = const Color(0x99ffffff),
      TextStyle? textStyle,
      TextAlign? textAlign,
      double elevation = 0,
      TipsGravity gravity = TipsGravity.top}) {
    _message = content;
    _padding = padding;
    _margin = margin;
    _blurSigma = blurSigma;
    _borderRadius = borderRadius;
    _background = color;
    _textStyle = textStyle;
    _textAlign = textAlign;
    _elevation = elevation;
    _gravity = gravity;
    _duration = duration;
    _animateDuration = animateDuration;
    _resetInit();
    _startAnim();
    _stopAnim();
  }

  void _resetInit() {
    _hideAnimTimer?.cancel();
    _clearTimer?.cancel();
    _entry?.remove();
    _entry = _toastWidget();
    if (_listener != null) {
      _animationController?.removeListener(_listener!);
    }
    _listener = () {
      _overlayState?.setState(() {});
    };
  }

  void _startAnim() {
    _overlayState = Overlay.of(_context);
    assert(_overlayState != null);
    _animationController =
        AnimationController(duration: _animateDuration, vsync: _overlayState!);
    var begin = -100.0;
    var end = 0.0;
    var mediaQueryData = MediaQuery.of(_context);
    switch (_gravity) {
      case TipsGravity.top:
        begin = -100;
        end = mediaQueryData.padding.top;
        break;
      case TipsGravity.bottom:
        begin = mediaQueryData.size.height;
        end = mediaQueryData.size.height - 100;
        break;
      case TipsGravity.center:
        end = mediaQueryData.size.height / 2;
        begin = end;
        break;
    }

    _animate =
        Tween<double>(begin: begin, end: end).animate(_animationController!);
    _animationController?.addListener(_listener!);
    _animationController?.forward();
    _overlayState?.insert(_entry!);
  }

  void _stopAnim() {
    _hideAnimTimer = Timer(_duration, () {
      _animationController?.reverse();
    });
    _clearTimer = Timer(_duration + _animateDuration, () {
      _entry?.remove();
      _entry = null;
    });
  }

  _toastWidget() {
    var child = (_message is Widget)
        ? _message
        : Text(
            _message.toString(),
            style: _textStyle,
            textAlign: _textAlign,
          );
    return OverlayEntry(builder: (context) {
      return Positioned(
        top: _animate.value,
        child: Container(
          padding: _margin,
          width: MediaQuery.of(context).size.width,
          child: Material(
            borderRadius: _borderRadius,
            elevation: _elevation,
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            child: ClipRect(
              child: BackdropFilter(
                filter:
                    ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
                child: Container(
                    color: _background, padding: _padding, child: child),
              ),
            ),
          ),
        ),
      );
    });
  }
}
