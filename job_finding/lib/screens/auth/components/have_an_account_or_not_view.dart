import 'package:flutter/material.dart';
import 'package:job_finding/utils/constants.dart';

class HaveAnAccountOrNotView extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLogin;

  const HaveAnAccountOrNotView(
      {Key? key, this.onPressed, required this.isLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Don\'t Have Account?' : 'Already Have an account?',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.w800,
            color: blackColor,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            !isLogin ? 'Log In' : 'Register',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
          ),
        )
      ],
    );
  }
}