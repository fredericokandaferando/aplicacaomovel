import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:aplicacaomovel/home_widgets/home_appbar.dart';
import 'package:aplicacaomovel/home_widgets/home_drawer.dart';
import 'package:aplicacaomovel/home_widgets/home_fab.dart';
class home_pricipalpage extends StatelessWidget{
  const home_pricipalpage({super.key});
Widget build(BuildContext context){
  return Scaffold(
   appBar: getHomeAppBar(),
   drawer:getHomeDrawer(context),
   floatingActionButton: getHomeFab(),
   body: Container(),
  );
}
}