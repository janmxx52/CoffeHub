import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffehub/core/utils/validators.dart';
import 'package:coffehub/features/auth/providers/auth_provider.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();

}

class _LoginFormState extends State<LoginForm> {


  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscureText = true;


  Future<void> _loginWithGoogle() async {
    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.loginWithGoogle();

    if (!mounted) return;

    if (success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
            (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.errorMessage ?? "Đăng nhập Google thất bại",
          ),
        ),
      );
    }
  }

  Future<void> _loginWithFacebook() async {
    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.loginWithFacebook();

    if (!mounted) return;

    if (success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
            (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.errorMessage ?? "Đăng nhập Facebook thất bại",
          ),
        ),
      );
    }
  }



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Đăng nhập thành công"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.errorMessage ?? "Đăng nhập thất bại",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          TextFormField(
            controller: _emailController,
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _passwordController,
            validator: Validators.validatePassword,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: "Mật khẩu",
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: authProvider.isLoading ? null : _login,
                  child: authProvider.isLoading
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ),
                  )
                      : const Text("Đăng nhập"),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/register',
              );
            },
            child: const Text("Tạo tài khoản mới ?"),
          ),
          const SizedBox(height: 25),

          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Hoặc tiếp tục với",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: 20),

          Consumer<AuthProvider>(
            builder: (_, authProvider, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(width: 20),

                  IconButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : _loginWithGoogle,
                    icon: Image.asset(
                      "assets/icons/google.png",
                      width: 40,
                    ),
                  ),

                  const SizedBox(width: 18),

                  IconButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : _loginWithFacebook,
                    icon: Image.asset(
                      "assets/icons/facebook.png",
                      width: 40,
                    ),
                  ),


                  IconButton(
                    onPressed: () {
                      // TODO Apple
                    },
                    icon: Image.asset(
                      "assets/icons/apple.png",
                      width: 78,
                    ),
                  ),
                ],
              );
            },
          ),
       ],
      ),
    );
  }
}