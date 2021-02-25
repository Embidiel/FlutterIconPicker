import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import 'FullScreenDialog.dart';
import 'AdaptiveDialog.dart';
import '../Helpers/ColorBrightness.dart';
import '../IconPicker/iconPicker.dart';
import '../IconPicker/searchBar.dart';
import '../Models/IconPack.dart';

// ignore: must_be_immutable
class DefaultDialog extends StatelessWidget {
  DefaultDialog({
    Key key,
    this.showSearchBar,
    this.routedView = false,
    this.adaptive = true,
    this.showTooltips,
    this.barrierDismissible,
    this.iconSize,
    this.iconColor,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.iconPickerShape,
    this.backgroundColor,
    this.constraints,
    this.title,
    this.closeChild,
    this.searchIcon,
    this.searchHintText,
    this.searchClearIcon,
    this.noResultsText,
    this.iconPackMode,
    this.customIconPack,
  }) : super(key: key);

  final bool showSearchBar;
  final bool routedView;
  final bool adaptive;
  final bool showTooltips;
  final bool barrierDismissible;
  final double iconSize;
  Color iconColor;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final ShapeBorder iconPickerShape;
  final Color backgroundColor;
  final BoxConstraints constraints;
  final Widget title;
  final Widget closeChild;
  final Icon searchIcon;
  final String searchHintText;
  final Icon searchClearIcon;
  final String noResultsText;
  final IconPack iconPackMode;
  final Map<String, IconData> customIconPack;

  @override
  Widget build(BuildContext context) {
    if (adaptive) {
      if (routedView) {
        return FullScreenDialog(
          showSearchBar: showSearchBar,
          showTooltips: showTooltips,
          backgroundColor: backgroundColor,
          title: title,
          iconPackMode: iconPackMode,
          customIconPack: customIconPack,
          searchIcon: searchIcon,
          searchClearIcon: searchClearIcon,
          searchHintText: searchHintText,
          iconColor: iconColor,
          noResultsText: noResultsText,
          iconSize: iconSize,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        );
      }
      return AdaptiveDialog(
        constraints: constraints,
        shape: iconPickerShape,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Padding(
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
                          child: title,
                          style: TextStyle(
                            color: ColorBrightness(backgroundColor).isLight()
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: ColorBrightness(backgroundColor).isLight()
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                if (showSearchBar)
                  SearchBar(
                    iconPack: iconPackMode,
                    customIconPack: customIconPack,
                    searchIcon: searchIcon,
                    searchClearIcon: searchClearIcon,
                    searchHintText: searchHintText,
                    backgroundColor: backgroundColor,
                  ),
                Expanded(
                  child: IconPicker(
                    showTooltips: showTooltips,
                    iconPack: iconPackMode,
                    customIconPack: customIconPack,
                    iconColor: iconColor,
                    backgroundColor: backgroundColor,
                    noResultsText: noResultsText,
                    iconSize: iconSize,
                    mainAxisSpacing: mainAxisSpacing,
                    crossAxisSpacing: crossAxisSpacing,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return AlertDialog(
        backgroundColor: backgroundColor,
        shape: iconPickerShape,
        title: DefaultTextStyle(
          child: title,
          style: TextStyle(
            color: ColorBrightness(backgroundColor).isLight()
                ? Colors.black
                : Colors.white,
            fontSize: 20,
          ),
        ),
        content: Container(
          constraints: constraints,
          child: Column(
            children: <Widget>[
              if (showSearchBar)
                SearchBar(
                  iconPack: iconPackMode,
                  customIconPack: customIconPack,
                  searchIcon: searchIcon,
                  searchClearIcon: searchClearIcon,
                  searchHintText: searchHintText,
                  backgroundColor: backgroundColor,
                ),
              Text('TANGINAs'),
              ColorPicker(
                  color: iconColor,
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: false,
                    ColorPickerType.primary: true,
                    ColorPickerType.accent: false,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: false,
                    ColorPickerType.wheel: false,
                  },
                  onColorChanged: (Color color) => () => iconColor = color,
                  heading: Text(
                    'Select color',
                    style: Theme.of(context).textTheme.headline5,
                  )),
              Expanded(
                child: IconPicker(
                  showTooltips: showTooltips,
                  iconPack: iconPackMode,
                  customIconPack: customIconPack,
                  iconColor: iconColor,
                  backgroundColor: backgroundColor,
                  noResultsText: noResultsText,
                  iconSize: iconSize,
                  mainAxisSpacing: mainAxisSpacing,
                  crossAxisSpacing: crossAxisSpacing,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: closeChild,
          ),
        ],
      );
    }
  }
}
