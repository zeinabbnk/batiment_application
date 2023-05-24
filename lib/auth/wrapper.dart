import 'package:batiment_application/auth/LogIn.dart';
import 'package:batiment_application/crud/infos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return _user == null ? LogIn() : infoHome();
  }
}
