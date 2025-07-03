// english_club/features/login/ui/widgets/whatsapp_launcher.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppLauncher {
  static Future<void> launchWhatsApp({
    required BuildContext context,
    required String phoneNumber,
    String message = '', // Optional: you can add a default message
  }) async {
    // Ensure the phone number starts with a '+' for international format
    String formattedPhoneNumber = phoneNumber.startsWith('+')
        ? phoneNumber
        : '+$phoneNumber';

    // WhatsApp URL scheme for direct chat
    String url = 'whatsapp://send?phone=$formattedPhoneNumber';
    if (message.isNotEmpty) {
      url += '&text=${Uri.encodeComponent(message)}';
    }

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // Fallback to web WhatsApp if direct app launch fails
        String webUrl = 'https://wa.me/$formattedPhoneNumber';
        if (message.isNotEmpty) {
          webUrl += '?text=${Uri.encodeComponent(message)}';
        }

        if (await canLaunchUrl(Uri.parse(webUrl))) {
          await launchUrl(
            Uri.parse(webUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          // Show an error if neither method works
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Could not launch WhatsApp. Please ensure WhatsApp is installed.',
              ),
            ),
          );
        }
      }
    } catch (e) {
      // Catch any potential errors during launch
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }
}
