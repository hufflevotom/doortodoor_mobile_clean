import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phone) async {
  final launchUri = Uri(
    scheme: 'tel',
    path: phone,
  );

  await launchUrl(launchUri);
}
