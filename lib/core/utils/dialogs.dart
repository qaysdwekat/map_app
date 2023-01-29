import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void showErrorIconNotification({
    required final BuildContext context,
    required final String title,
    required final Widget asset,
    required final bool enableSlideOff,
    required final bool ltr,
  }) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 5),
      enableSlideOff: enableSlideOff,
      toastBuilder: (onCancel) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: ltr ? 0 : 3),
                child: asset,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
