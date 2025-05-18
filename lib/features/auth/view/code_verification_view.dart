import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/app_header.dart';

class CodeVerificationView extends StatefulWidget {
  final String email;

  const CodeVerificationView({super.key, required this.email});

  @override
  State<CodeVerificationView> createState() => _CodeVerificationViewState();
}

class _CodeVerificationViewState extends State<CodeVerificationView> {
  final List<TextEditingController> _codeControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyCode() async {
    // Prevent multiple verification attempts while loading
    if (_isLoading) return;

    String enteredCode = _codeControllers.map((c) => c.text).join();
    print('Entered code: $enteredCode');

    // TODO: Replace with actual code verification API call
    // Simulate API call delay
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // Mock verification: Assume any 6-digit code is correct for now
    bool isCodeCorrect = enteredCode.length == 6; // Simple mock validation

    setState(() {
      _isLoading = false;
    });

    if (isCodeCorrect && mounted) {
      // TODO: Handle successful verification (e.g., save token if applicable)
      // Navigate to home page
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // TODO: Handle incorrect code (e.g., show error message)
      // For mock, we'll just print for now or show a simple message
      print('Incorrect code (mock).');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.generalError), // Using a generic error for now
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resendCode() async {
     // Prevent multiple requests while loading
    if (_isLoading) return;

    print('Resend code requested for ${widget.email}');

    // TODO: Implement actual resend code API call
    // Simulate API call delay
     setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

     setState(() {
      _isLoading = false;
    });

    // TODO: Handle resend code response (e.g., show success/error message)
     if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.codeResentMessage), // Need to add this localization key
          backgroundColor: Colors.green,
        ),
      );
     }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppHeader(
        title: l10n.codeVerificationTitle,
        showBackButton: true,
      ),
      body: Container(
         decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Animasyon
                 Lottie.asset(
                    'assets/animations/login-animation.json',
                    height: 150,
                  ),
                const SizedBox(height: 40),
                Text(
                  l10n.enterCode,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.codeSentTo(widget.email),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 40,
                      child: TextField(
                        controller: _codeControllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            )
                          )
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            if (index < 5) {
                              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                            } else {
                              _focusNodes[index].unfocus();
                              // Auto-verify when last digit is entered, but wait for loading to finish
                                if (!_isLoading) {
                                   _verifyCode();
                                }
                            }
                          } else if (value.isEmpty) {
                             if (index > 0) {
                              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                            }
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isLoading ? null : _verifyCode,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                        )
                      : Text(l10n.verify),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _isLoading ? null : _resendCode,
                  child: Text(l10n.resendCode),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 