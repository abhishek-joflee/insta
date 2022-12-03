import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

const _clientId = '0a3fbf72d6630b9d8c22';
const _clientSecret = '478efaf8ac0ba22fd3dcf5a036e46e45c615dbb3';

class GithubLoginHelper {
  GithubLoginHelper._();
  static final _i = GithubLoginHelper._();
  static GithubLoginHelper get instance => _i;

  StreamSubscription<String?>? _linkListener;
  late Completer<String?> _codeCompleter;

  void _disposeDeepLinkListener() {
    _linkListener?.cancel();
    _linkListener = null;
  }

  void _initDeepLinkListener() {
    log('Starting listening for code...');
    _linkListener = linkStream.listen(
      _checkDeepLink,
      onError: (dynamic e) => log(':error on link listener', error: e),
      cancelOnError: true,
      onDone: () => log('done link listener'),
    );
  }

  Future<void> _checkDeepLink(String? link) async {
    log('Received: $link');
    if (link != null) {
      final code = link.substring(link.indexOf(RegExp('code=')) + 5);
      _disposeDeepLinkListener();

      //? 3. get access token from this code
      final response = await http.post(
        Uri.parse('https://github.com/login/oauth/access_token'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(
          {
            'client_id': _clientId,
            'client_secret': _clientSecret,
            'code': code,
          },
        ),
      );

      //? 4. return the access token
      final accessToken = (jsonDecode(response.body)
          as Map<String, dynamic>)['access_token'] as String;
      _codeCompleter.complete(accessToken);
    } else {
      // user has aborted the process or something wrong
      _codeCompleter.complete(null);
    }
  }

  Future<String?> login() async {
    //? assign completer
    _codeCompleter = Completer();

    //? 1. launch the browser for github login
    const url =
        'https://github.com/login/oauth/authorize?client_id=$_clientId&scope=read:user%20user:email';
    final uri = Uri.parse(url);
    unawaited(
      launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      ),
    );

    //? 2. start the listener for `CODE` which will come with redirect url
    _initDeepLinkListener();
    return _codeCompleter.future;
  }
}
