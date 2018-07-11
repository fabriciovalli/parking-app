import 'package:flutter/material.dart';

void addIfNonNull(Widget child, List<Widget> children) {
  if (child != null) {
    children.add(child);
  }
}
