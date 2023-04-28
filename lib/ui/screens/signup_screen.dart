import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/blocs/user_cubit.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
// Clé permettant d'accéder au widget Form
    final GlobalKey<FormState> formKey = GlobalKey();
// Controleur permettant d'accéder à la valeur du champs de saisie
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey, // Lien avec la clé
          child: Column(
            children: [
               TextFormField(
                  controller: usernameController, // Lien avec le controleur
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
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
                  controller: passwordController, // Lien avec le controleur
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
                      final String username = usernameController.text;
                      final String password = passwordController.text;
                      context.read<UserCubit>().signup(username, password).then((isCreated) {
                        if(isCreated){
                          Navigator.pop(context);
                        }
                        else{
                          final snackBar = SnackBar(
                          content: const Text('Cet utilisateur existe déjà'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      })
                      .catchError((error) {       
                        final snackBar = SnackBar(
                          content: const Text('Une erreur s\'est produite'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                            },
                          ),
                        );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }       
                },
                  child: const Text('S\'inscrire'))
            ],
          ),
        ),
      ),
    ));
  }
}
