import 'package:flutter/material.dart';
import '../Helpers/ColorBrightness.dart';
import '../IconPicker/iconPicker.dart';
import '../IconPicker/searchBar.dart';
import '../Models/IconPack.dart';

import 'package:flex_color_picker/flex_color_picker.dart';

class FullScreenDialog extends StatefulWidget {
  FullScreenDialog({
    Key key,
    this.showSearchBar,
    this.showTooltips,
    this.backgroundColor,
    this.title,
    this.iconPackMode,
    this.customIconPack,
    this.searchIcon,
    this.searchClearIcon,
    this.searchHintText,
    this.iconColor,
    this.noResultsText,
    this.iconSize,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
  }) : super(key: key);

  final bool showSearchBar;
  final bool showTooltips;
  final Color backgroundColor;
  final Widget title;
  final IconPack iconPackMode;
  final Map<String, IconData> customIconPack;
  final Icon searchIcon;
  final Icon searchClearIcon;
  final String searchHintText;
  Color iconColor;
  final String noResultsText;
  final double iconSize;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  FullScreenDialogState createState() => FullScreenDialogState();
}

// ignore: must_be_immutable
class FullScreenDialogState extends State<FullScreenDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: DefaultTextStyle(
                        child: widget.title,
                        style: TextStyle(
                          color:
                              ColorBrightness(widget.backgroundColor).isLight()
                                  ? Colors.black
                                  : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: ColorBrightness(widget.backgroundColor).isLight()
                            ? Colors.black
                            : Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              if (widget.showSearchBar)
                SearchBar(
                  iconPack: widget.iconPackMode,
                  customIconPack: widget.customIconPack,
                  searchIcon: widget.searchIcon,
                  searchClearIcon: widget.searchClearIcon,
                  searchHintText: widget.searchHintText,
                  backgroundColor: widget.backgroundColor,
                ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Colors",
                  ),
                ),
              ),
              SizedBox(height: 15),
              ColorPicker(
                  color: widget.iconColor,
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: false,
                    ColorPickerType.primary: true,
                    ColorPickerType.accent: false,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: false,
                    ColorPickerType.wheel: false,
                  },
                  borderRadius: 30,
                  spacing: 10,
                  runSpacing: 10,
                  width: 30,
                  height: 30,
                  onColorChanged: (Color color) =>
                      setState(() => widget.iconColor = color),
                  heading: null),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Icons",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: IconPicker(
                  showTooltips: widget.showTooltips,
                  iconPack: widget.iconPackMode,
                  customIconPack: widget.customIconPack,
                  iconColor: widget.iconColor,
                  backgroundColor: widget.backgroundColor,
                  noResultsText: widget.noResultsText,
                  iconSize: widget.iconSize,
                  mainAxisSpacing: widget.mainAxisSpacing,
                  crossAxisSpacing: widget.crossAxisSpacing,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
