import 'package:flutter/material.dart';

import '../constants/dimensions.dart';
import '../widgets/improved_primary_button.dart';
import '../widgets/improved_text_field.dart';
import '../widgets/text_widget.dart';

/// Example page demonstrating the usage of improved widgets
class ImprovedWidgetsExample extends StatefulWidget {
  const ImprovedWidgetsExample({super.key});

  @override
  State<ImprovedWidgetsExample> createState() => _ImprovedWidgetsExampleState();
}

class _ImprovedWidgetsExampleState extends State<ImprovedWidgetsExample> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget.heading4(
          'Improved Widgets Example',
          context: context,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: Dimensions.screenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              TextWidget.heading2(
                'Welcome Back!',
                context: context,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: Dimensions.responsiveHeight48),

              // Name Field
              ImprovedTextField(
                controller: _nameController,
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: Dimensions.responsiveHeight48),

              // Email Field
              ImprovedTextField(
                controller: _emailController,
                labelText: 'Email Address',
                hintText: 'Enter your email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: Dimensions.responsiveHeight48),

              // Password Field
              ImprovedTextField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: Dimensions.responsiveHeight48),

              // Login Button
              ImprovedPrimaryButton(
                label: 'Sign In',
                onPressed: _handleLogin,
                fullWidth: true,
                icon: Icons.login,
              ),
              SizedBox(height: Dimensions.responsiveHeight48),

              // Alternative Buttons
              Row(
                children: [
                  Expanded(
                    child: ImprovedPrimaryButton(
                      label: 'Cancel',
                      onPressed: _handleCancel,
                      outlined: true,
                      icon: Icons.close,
                    ),
                  ),
                  SizedBox(width: Dimensions.responsiveSpacing16),
                  Expanded(
                    child: ImprovedPrimaryButton(
                      label: 'Register',
                      onPressed: _handleRegister,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      icon: Icons.person_add,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.responsiveHeight48),

              // Social Login Buttons
              _buildSocialLoginSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return Column(
      children: [
        TextWidget.body(
          'Or continue with',
          context: context,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        SizedBox(height: Dimensions.responsiveHeight48),

        Row(
          children: [
            Expanded(
              child: ImprovedPrimaryButton(
                label: 'Google',
                onPressed: _handleGoogleLogin,
                outlined: true,
                icon: Icons.g_mobiledata,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
              ),
            ),
            SizedBox(width: Dimensions.responsiveSpacing16),
            Expanded(
              child: ImprovedPrimaryButton(
                label: 'Apple',
                onPressed: _handleAppleLogin,
                outlined: true,
                icon: Icons.apple,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle login logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget.body(
            'Login attempted with: ${_emailController.text}',
            context: context,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  void _handleCancel() {
    // Handle cancel logic
    Navigator.of(context).pop();
  }

  void _handleRegister() {
    // Handle register logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget.body('Register button tapped', context: context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  void _handleGoogleLogin() {
    // Handle Google login logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget.body('Google login tapped', context: context),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _handleAppleLogin() {
    // Handle Apple login logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget.body('Apple login tapped', context: context),
        backgroundColor: Colors.black,
      ),
    );
  }
}
