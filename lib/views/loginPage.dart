import 'package:event_ease/data/model/auth/loginRequest.dart';
import 'package:event_ease/presentation/auth/bloc/auth_bloc.dart';
import 'package:event_ease/views/Eo/eoHomePage.dart';
import 'package:event_ease/views/User/userHomePage.dart';
import 'package:event_ease/views/registerPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  bool isShowPassword = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  'Selamat Datang Kembali',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Email field
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? 'Please enter your email'
                              : null,
                ),
                const SizedBox(height: 20),

                // Password field
                TextFormField(
                  controller: passwordController,
                  obscureText: !isShowPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed:
                          () =>
                              setState(() => isShowPassword = !isShowPassword),
                    ),
                  ),
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? 'Please enter your password'
                              : null,
                ),
                const SizedBox(height: 20),
                // Login button with BLoC
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    } else if (state is AuthSuccess) {
                      final user = state.responseModel.user!;
                      final role = user.role?.toUpperCase();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login berhasil')),
                      );

                      if (role == 'EO') {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => EoHomePage(user: user),
                          ),
                        );
                      } else if (role == 'USER') {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => UserHomePage(user: user),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Role tidak dikenali')),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            state is AuthLoading
                                ? null
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    final req = LoginRequestModel(
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                    );
                                    context.read<AuthBloc>().add(
                                      LoginRequested(requestModel: req),
                                    );
                                  }
                                },
                        child: Text(
                          state is AuthLoading ? 'Memuat...' : 'Masuk',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    text: 'Belum punya akun? ',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                    children: [
                      TextSpan(
                        text: 'Daftar Disini!',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const Registerpage(),
                                  ),
                                );
                              },
                      ),
                    ],
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
