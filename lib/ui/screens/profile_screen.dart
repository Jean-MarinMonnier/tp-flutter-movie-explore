import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/blocs/profile_cubit.dart';

import '../../blocs/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().loadProfile();
    // Clé permettant d'accéder au widget Form
    final GlobalKey<FormState> formKey = GlobalKey();
// Controleur permettant d'accéder à la valeur du champs de saisie
    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
              firstnameController.text = state.profile?.firstname ?? '';
              lastnameController.text = state.profile?.lastname ?? '';
          return Form(
            key: formKey, // Lien avec la clé
            child: Column(
              children: [
                TextFormField(
                  controller: firstnameController, // Lien avec le controleur
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prénom',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le champs doit être renseigné';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: lastnameController, // Lien avec le controleur
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le champs doit être renseigné';
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final String firstname = firstnameController.text;
                        final String lastname = lastnameController.text;
                        context
                            .read<ProfileCubit>()
                            .saveProfile(firstname, lastname).then((value) => Navigator.pop(context));      
                      }
                    },
                    child: const Text('Enregistrer')),
              ],
            ),
          );
        }),
      ),
    );
  }
}
