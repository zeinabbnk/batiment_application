import 'package:batiment_application/models/maquetteFeed.dart';
import 'package:batiment_application/models/maquetteModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class maquetteList extends StatelessWidget {
  const maquetteList({super.key});

  @override
  Widget build(BuildContext context) {
    final _maquette = Provider.of<List<Maquette>>(context);
    return SliverList(delegate: SliverChildBuilderDelegate(
      (_, index) {
        return maquetteFeed(maquette: _maquette[index],);
      },
      childCount: _maquette.length,
    ));
  }
}
