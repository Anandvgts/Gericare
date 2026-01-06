import 'package:flutter/cupertino.dart';

class AlertRequest {
  final String? image;
  final String? title;
  final TextStyle? titletextStyle;
  final String? description;
  final Widget? content;
  final String? buttonTitle;
  final String? secondaryButtonTitle;
  final bool dismissable;
  final Function? onTap;
  final bool? isCancel;

  final Widget? iconWidget;
  final Widget? customWidget;
  final Widget? contentWidget;
  final bool? showActionBar;
  final bool? showCloseIcon;
  final bool? isError;

  AlertRequest({
    this.image,
    this.title,
    this.titletextStyle,
    this.description,
    this.content,
    this.isCancel,
    this.buttonTitle,
    this.secondaryButtonTitle,
    this.dismissable = true,
    this.iconWidget,
    this.customWidget,
    this.contentWidget,
    this.showActionBar,
    this.onTap,
    this.showCloseIcon,
    this.isError});

}

