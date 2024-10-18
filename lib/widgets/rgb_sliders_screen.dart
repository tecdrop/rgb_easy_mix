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
class RGBSliders extends StatefulWidget {
  const RGBSliders({
    super.key,
    required this.initialColor,
    required this.onColorChanged,
  });

  /// The color to control using the RGB sliders.
  final Color initialColor;

  /// Called when the color is changed by the user using the RGB sliders.
  final ValueChanged<Color>? onColorChanged;

  @override
  State<RGBSliders> createState() => _RGBSlidersState();
}

class _RGBSlidersState extends State<RGBSliders> {
  /// The color being controlled by the RGB sliders.
  late Color _color;

  /// Text controllers for the RGB text fields.
  late final Map<_RGB, TextEditingController> _rgbControllers = <_RGB, TextEditingController>{
    _RGB.red: TextEditingController(text: _color.red.toString()),
    _RGB.green: TextEditingController(text: _color.green.toString()),
    _RGB.blue: TextEditingController(text: _color.blue.toString()),
  };

  @override
  void initState() {
    super.initState();

    _color = widget.initialColor;
  }

  /// Updates the color by changing the specified RGB channel to the specified value.
  ///
  /// Optionally, updates the corresponding text field with the new value, and calls the
  /// onColorChanged callback.
  void _updateColor(_RGB rgb, int value, {bool updateTextField = false}) {
    setState(() {
      _color = switch (rgb) {
        _RGB.red => _color.withRed(value),
        _RGB.green => _color.withGreen(value),
        _RGB.blue => _color.withBlue(value),
      };
    });

    if (updateTextField) {
      _rgbControllers[rgb]!.text = value.toString();
    }

    widget.onColorChanged?.call(_color);
  }

  /// Returns the value of the specified RGB channel of the specified color.
  static int _getColorRGB(Color color, _RGB rgb) {
    return switch (rgb) {
      _RGB.red => color.red,
      _RGB.green => color.green,
      _RGB.blue => color.blue,
    };
  }

  /// Builds a table row with a slider and a text field for the specified RGB channel.
  TableRow _buildRGBTableRow(_RGB rgb, Color contrastColor) {
    return TableRow(
      children: <Widget>[
        _RGBSlider(
          value: _getColorRGB(_color, rgb),
          rgbColor: _rgbColors[rgb]!,
          foregroundColor: contrastColor,
          onChanged: (int value) => _updateColor(rgb, value, updateTextField: true),
        ),
        _RGBTextField(
          value: _getColorRGB(_color, rgb),
          foregroundColor: contrastColor,
          controller: _rgbControllers[rgb]!,
          onChanged: (int value) => _updateColor(rgb, value),
        ),
      ],
    );
  }

  /// The main build method of the screen.
  @override
  Widget build(BuildContext context) {
    final Color contrastColor = color_utils.contrastOf(_color);

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
          _buildRGBTableRow(_RGB.red, contrastColor),
          _buildRGBTableRow(_RGB.green, contrastColor),
          _buildRGBTableRow(_RGB.blue, contrastColor),
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

  @override
  Widget build(BuildContext context) {
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
