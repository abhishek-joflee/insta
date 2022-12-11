import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/rich_text/base_text.dart';
import '../components/rich_text/rich_text_widget.dart';
import '../constants/app_strings.dart';

class LoginViewSignupLinks extends StatelessWidget {
  const LoginViewSignupLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.subtitle1?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(text: AppStrings.dontHaveAnAccount),
        BaseText.plain(text: AppStrings.signUpOn),
        BaseText.link(
          text: AppStrings.facebook,
          onTap: () => unawaited(
            launchUrl(
              Uri.parse(AppStrings.facebookSignupUrl),
              mode: LaunchMode.externalApplication,
            ),
          ),
        ),
        BaseText.plain(text: AppStrings.orCreateAnAccountOn),
        BaseText.link(
          text: AppStrings.google,
          onTap: () => unawaited(
            launchUrl(
              Uri.parse(AppStrings.googleSignupUrl),
              mode: LaunchMode.externalApplication,
            ),
          ),
        ),
        BaseText.plain(text: '/'),
        BaseText.link(
          text: AppStrings.github,
          onTap: () => unawaited(
            launchUrl(
              Uri.parse(AppStrings.githubSignupUrl),
              mode: LaunchMode.externalApplication,
            ),
          ),
        ),
      ],
    );
  }
}
