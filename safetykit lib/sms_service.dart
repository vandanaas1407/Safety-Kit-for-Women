import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class SMSService {
  SMSService._();
  static final instance = SMSService._();

  /// Send one message to multiple recipients at once
  Future<void> sendBulkSMS(String message, List<String> numbers) async {
    if (numbers.isEmpty) {
      print("⚠️ No contacts to send SMS.");
      return;
    }

    // Join all numbers as comma-separated (Android & iOS both support this)
    final recipients = numbers.join(',');

    final Uri smsUri;
    if (defaultTargetPlatform == TargetPlatform.android) {
      smsUri = Uri.parse("smsto:$recipients?body=$message");
    } else {
      smsUri = Uri(
        scheme: "sms",
        path: recipients,
        queryParameters: {"body": message},
      );
    }

    print("🚨 Launching SMS to: $recipients");
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      print("❌ Could not open SMS app for $recipients");
    }
  }
}
