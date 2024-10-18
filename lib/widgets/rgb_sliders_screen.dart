// Copyright (c) 2024 Tecdrop. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file or at
// https://github.com/tecdrop/rgb_easy_mix/blob/main/LICENSE.

import 'package:flutter/material.dart';

import '../utils/color_utils.dart' as color_utils;

/// RGB channel enumeration.
enum _RGB { red, green, blue }

/// A map of RGB channels to their corresponding colors.
const Map<_RGB, Color> _rgbColors = <_RGB, Color>{
  _RGB.red: Color(0xFFFF0000),
  _RGB.green: Color(0xFF00FF00),
  _RGB.blue: Color(0xFF0000FF),
};

/// The RGB Sliders Screen stateful widget.
class RGBSliders extends StatelessWidget {
  const RGBSliders({
    super.key,
    required this.color,
    required this.onColorChanged,
    required this.redController,
    required this.greenController,
    required this.blueController,
  });

  /// The color to control using the RGB sliders.
  final Color color;

  /// Called when the color is changed by the user using the RGB sliders.
  final ValueChanged<Color>? onColorChanged;

  final TextEditingController redController;

  final TextEditingController greenController;

  final TextEditingController blueController;

  /// Updates the color by changing the specified RGB channel to the specified value and calls the
  /// onColorChanged callback.
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
                value: color.red,
                rgbColor: _rgbColors[_RGB.red]!,
                foregroundColor: contrastColor,
                onChanged: (int value) => _updateColor(_RGB.red, value),
              ),
              _RGBTextField(
                value: color.red,
                foregroundColor: contrastColor,
                controller: redController,
                onChanged: (int value) => _updateColor(_RGB.red, value),
              ),
            ],
          ),
          TableRow(
            children: <Widget>[
              _RGBSlider(
                value: color.green,
                rgbColor: _rgbColors[_RGB.green]!,
                foregroundColor: contrastColor,
                onChanged: (int value) => _updateColor(_RGB.green, value),
              ),
              _RGBTextField(
                value: color.green,
                foregroundColor: contrastColor,
                controller: greenController,
                onChanged: (int value) => _updateColor(_RGB.green, value),
              ),
            ],
          ),
          TableRow(
            children: <Widget>[
              _RGBSlider(
                value: color.blue,
                rgbColor: _rgbColors[_RGB.blue]!,
                foregroundColor: contrastColor,
                onChanged: (int value) => _updateColor(_RGB.blue, value),
              ),
              _RGBTextField(
                value: color.blue,
                foregroundColor: contrastColor,
                controller: blueController,
                onChanged: (int value) => _updateColor(_RGB.blue, value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A slider that controls a single RGB channel of a color.
class _RGBSlider extends StatelessWidget {
  const _RGBSlider({
    super.key, // ignore: unused_element
    required this.value,
    required this.rgbColor,
    required this.foregroundColor,
    this.onChanged,
  });

  /// The value of the slider.
  final int value;

  /// The color of the slider (red, green, or blue).
  final Color rgbColor;

  /// The foreground color of the slider.
  final Color foregroundColor;

  /// Called when the value of the slider changes.
  final void Function(int)? onChanged;

  // /// A map of RGB channels to their corresponding colors.
  // static const Map<_RGB, Color> _rgbColors = <_RGB, Color>{
  //   _RGB.red: Color(0xFFFF0000),
  //   _RGB.green: Color(0xFF00FF00),
  //   _RGB.blue: Color(0xFF0000FF),
  // };

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
    print('_RGBSlider $rgbColor build');

    return Slider(
      value: value.toDouble(),
      min: 0,
      max: 255,
      activeColor: foregroundColor,
      inactiveColor: foregroundColor,
      thumbColor: rgbColor,
      onChanged: (double value) => onChanged?.call(value.toInt()),
    );
  }
}

class _RGBTextField extends StatelessWidget {
  const _RGBTextField({
    super.key, // ignore: unused_element
    required this.value,
    required this.foregroundColor,
    required this.controller,
    this.onChanged,
  });

  /// The RGB component value being edited.
  final int value;

  /// The foreground color of the text field.
  final Color foregroundColor;

  final TextEditingController controller;

  /// Called when the value of the RGB component changes.
  final void Function(int)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: value.toString(),
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: foregroundColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: foregroundColor),
        ),
      ),
      style: TextStyle(color: foregroundColor),
      keyboardType: TextInputType.number,
      onChanged: (String value) => onChanged?.call(int.parse(value)),
    );
  }
}
