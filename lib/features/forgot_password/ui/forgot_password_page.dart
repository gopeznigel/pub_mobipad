import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/forgot_password/actions.dart';
import 'package:mobipad/features/forgot_password/view_models/forgot_password_view_model.dart';
import 'package:mobipad/features/login/ui/widgets/email_text_field.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:mobipad/utils/validator.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String route = '/forgotPasswordPage';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool sent = false;

  Store<AppState> get store => StoreProvider.of(context);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) =>
            ForgotPasswordPageViewModel(store.state.forgotPasswordState),
        builder: _buildPage,
      );

  Widget _buildPage(
      BuildContext context, ForgotPasswordPageViewModel viewModel) {
    final sending = viewModel.isSending;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: OhNotesColor.primary,
        title: Text(
          'Forgot Password',
          style: OhNotesTextStyles.appBarTitle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Email',
                        style: OhNotesTextStyles.appBarTitle,
                      ),
                    ),
                    EmailTextField(
                      enabled: !sending,
                      controller: _emailController,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          !sending ? OhNotesColor.primary : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      var validated = Validator.formValidated(_formKey);
                      if (validated) {
                        store.dispatch(
                            SendResetPasswordLink(_emailController.text));
                        setState(() {
                          sent = true;
                        });
                      }
                    },
                    child: !sending
                        ? Text(
                            'Send Password Reset Link',
                            style: OhNotesTextStyles.button.copyWith(
                              color: Colors.white,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: !sending && sent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Center(
                    child: Text(
                      'Password reset link was sent on the email provided.',
                      textAlign: TextAlign.center,
                      style: OhNotesTextStyles.notePreviewBody.copyWith(
                        color: OhNotesColor.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
