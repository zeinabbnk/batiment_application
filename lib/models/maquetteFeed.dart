import 'package:batiment_application/models/maquetteModel.dart';
import 'package:flutter/material.dart';

class maquetteFeed extends StatelessWidget {
  final Maquette? maquette;

  const maquetteFeed({super.key, this.maquette});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 100, left: 15, right: 15),
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                image: NetworkImage(maquette!.MaqURLImage!),
                fit: BoxFit.cover,
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Titre :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF4d6d7c)),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    maquette!.titre!,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Numéro d'étage :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF4d6d7c)),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(maquette!.NumE!,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
