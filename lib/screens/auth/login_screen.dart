import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kinzy_club/common/validators.dart';
import 'package:kinzy_club/screens/auth/cubit/login_cubit.dart';
import 'package:kinzy_club/screens/todo/todo_screen.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6c5ce7),
        leading: const Icon(
          FontAwesomeIcons.clipboardList,
          color: Colors.white,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {},
            child: Text(
              "Login",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
              },
              child: const Text(
                "SignUp",
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Form(
            key: fkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(8.0), // Border radius 8dp
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary, // Border color
                      width: 2.0, // Border width
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Optional shadow
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          validator: Validators.validateEmail,
                          onSaved: (value) {
                            context.read<LoginCubit>().updateForm("email", value);
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          validator: Validators.validatePassword,
                          onSaved: (newValue) {
                            context.read<LoginCubit>().updateForm("password", newValue);
                          },
                        ),
                        const SizedBox(height: 12),
                        BlocConsumer<LoginCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthSuccess) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const TodoScreen(),
                                ),
                              );
                            }
                            if (state is AuthError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(state.message)));
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  fixedSize: Size(MediaQuery.sizeOf(context).width, 20)),
                              onPressed: () {
                                if (fkey.currentState!.validate()) {
                                  fkey.currentState!.save();
                                  context.read<LoginCubit>().login();
                                }
                              },
                              child: state is AuthLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(fontSize: 14),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => const SignupScreen()));
                              },
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          onPressed: () {},
                          child: RichText(
                            text: const TextSpan(
                              text: "Login with ",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: "Google",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
