/*
 * Copyright (c) 2021-2022 Larry Aasen. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

/// A widget to display the upgrade dialog.
class UpgradeAlert extends UpgradeBase {
  /// The [child] contained by the widget.
  final Widget? child;
  final GlobalKey<NavigatorState> navState;

  /// Creates a new [UpgradeAlert].
  UpgradeAlert({Key? key, Upgrader? upgrader, required this.navState, this.child})
      : super(upgrader ?? Upgrader.sharedInstance, key: key);

  /// Describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context, UpgradeBaseState state) {
    if (upgrader.debugLogging) {
      print('upgrader: build UpgradeAlert');
    }

   try{
     return FutureBuilder(
         future: state.initialized,
         builder: (BuildContext context, AsyncSnapshot<bool> processed) {
           if (processed.connectionState == ConnectionState.done &&
               processed.data != null &&
               processed.data!) {
             upgrader.checkVersion(context: navState!.currentState!.context);
           }
           return child ?? Container();
         });
   }catch(e){
      return Container();
   }
  }
}
