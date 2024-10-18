// Copyright (c) 2024 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file or at
// https://github.com/tecdrop/rgb_easy_mix/blob/main/LICENSE.

import 'package:flutter/material.dart';

import '../utils/color_utils.dart' as color_utils;

/// The RGB Sliders Screen stateful widget.
class RGBSliders extends StatelessWidget {
  const RGBSliders({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  /// The initial color to apply to the RGB sliders.
  final Color color;

  /// Called when the color is changed by the user using the RGB sliders.
  final ValueChanged<Color>? onColorChanged;

  void _updateColor(_RGB rgb, int value) {
    final Color updatedColor = switch (rgb) {
      _RGB.red => color.withRed(value),
      _RGB.green => color.withGreen(value),
      _RGB.blue => color.withBlue(value),
    };
    onColorChanged?.call(updatedColor);
  }

  /// The main build method of the screen.
  @override
  Widget build(BuildContext context) {
    print('RGBSliders build');

    final Color contrastColor = color_utils.contrastOf(color);

    return SliderTheme(
      data: const SliderThemeData(
        trackHeight: 1,
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FixedColumnWidth(48.0),
        },
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              _RGBSlider(
                rgb: _RGB.red,
                value: color.red,
                contrastColor: contrastColor,
                onChanged: (int value) => _updateColor(_RGB.red, value),
              ),
            ],
          ),
          TableRow(
            children: <Widget>[
              _RGBSlider(
                rgb: _RGB.green,
                value: color.green,
                contrastColor: contrastColor,
                onChanged: (int value) => _updateColor(_RGB.green, value),
              ),
            ],
          ),
          TableRow(
            children: <Widget>[
              _RGBSlider(
                rgb: _RGB.blue,
                value: color.blue,
                contrastColor: contrastColor,
                onChanged: (int value) => _updateColor(_RGB.blue, value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// RGB channel enumeration.
enum _RGB { red, green, blue }

/// A slider that controls a single RGB channel of a color.
class _RGBSlider extends StatelessWidget {
  const _RGBSlider({
    super.key, // ignore: unused_element
    required this.rgb,
    required this.value,
    required this.contrastColor,
    this.onChanged,
  });

  /// The RGB channel to control.
  final _RGB rgb;

  /// The color to control.
  final int value;

  /// The contrast color to use for the slider.
  final Color contrastColor;

  /// Called when the value of the slider changes.
  final void Function(int)? onChanged;

  /// A map of RGB channels to their corresponding colors.
  static const Map<_RGB, Color> _rgbColors = <_RGB, Color>{
    _RGB.red: Color(0xFFFF0000),
    _RGB.green: Color(0xFF00FF00),
    _RGB.blue: Color(0xFF0000FF),
  };

  // /// Returns the value of the specified RGB channel of the specified color.
  // static double _getColorRGB(Color color, _RGB rgb) {
  //   return switch (rgb) {
  //     _RGB.red => color.red,
  //     _RGB.green => color.green,
  //     _RGB.blue => color.blue,
  //   }
  //       .toDouble();
  // }

  // /// Returns the specified color after updating the specified RGB channel with the specified value.
  // static Color _updateColor(Color color, _RGB rgb, double value) {
  //   final int intValue = value.toInt();
  //   return switch (rgb) {
  //     _RGB.red => color.withRed(intValue),
  //     _RGB.green => color.withGreen(intValue),
  //     _RGB.blue => color.withBlue(intValue),
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    print('_RGBSlider $rgb build');

    return Slider(
      value: value.toDouble(),
      min: 0,
      max: 255,
      activeColor: contrastColor,
      inactiveColor: contrastColor,
      thumbColor: _rgbColors[rgb],
      onChanged: (double value) => onChanged?.call(value.toInt()),
    );
  }
}
