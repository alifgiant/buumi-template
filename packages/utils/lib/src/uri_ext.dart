import 'package:url_launcher/url_launcher.dart';

extension UriExt on String {
  Future<bool> call() async {
    // try to open whatsapp
    final uri = Uri.parse('https://wa.me/$this');
    if (await canLaunchUrl(uri)) return launchUrl(uri);
    return false;
  }

  Future<bool> openMap() async {
    final cleanedCoordinate = replaceAll(' ', '');
    // try to open google map app
    final googleMapUri = Uri.parse('comgooglemaps://?q=$cleanedCoordinate');
    if (await canLaunchUrl(googleMapUri)) return launchUrl(googleMapUri);

    // try to open apple map app
    final appleMapUri = Uri.parse('maps://?ll=$cleanedCoordinate');
    if (await canLaunchUrl(appleMapUri)) return launchUrl(appleMapUri);

    // try to open google map website
    final uri = Uri.parse('https://www.google.com/maps?q=$cleanedCoordinate');
    if (await canLaunchUrl(uri)) return launchUrl(uri);

    return false;
  }
}
