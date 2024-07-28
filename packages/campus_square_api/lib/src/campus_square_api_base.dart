import 'dart:convert';

import 'package:campus_square_api/src/campus_square_client.dart';
import 'package:campus_square_api/src/entity/schedule.dart';
import 'package:http/http.dart' as http;

const host = 'csweb.u-aizu.ac.jp';
const portalPath = '/campusweb/campusportal.do';

class CampusSquare {
  final CampusSquareClient _client;
  late String _rwfHash;
  bool _isLoggedIn = false;

  CampusSquare([CampusSquareClient? httpClient])
      : _client = httpClient ?? CampusSquareClient(http.Client());

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String userName, String password) async {
    _isLoggedIn = false;

    _checkUsername(userName);
    _checkPassword(password);

    String rwfHash = _extractRWFHash((await _client.post(Uri(
      scheme: 'https',
      host: host,
      path: portalPath,
    ))).body);

    Uri loginURI = Uri(
      scheme: 'https',
      host: host,
      path: portalPath,
      queryParameters: {
        'wfId': 'nwf_PTW0000002_login',
        'userName': userName,
        'password': password,
        'locale': 'ja_JP',
        'undefined': '',
        'action': 'rwf',
        'tabId': 'home',
        'page': '',
        'rwfHash': rwfHash,
      },
    );
    String body = (await _client.get(loginURI)).body;

    if (body.contains("ユーザ名またはパスワードの入力に誤りがあります")) {
      throw Exception('Invalid username or password');
    }

    _rwfHash = _extractRWFHash((await _client.get(Uri(
      scheme: 'https',
      host: host,
      path: portalPath,
      queryParameters: {
        'page': 'main',
      }
    ))).body);

    _isLoggedIn = true;
  }

  Future<List<Schedule>> checkSchedule(int year, int month, int day) async {
    Uri scheduleURI = Uri(
      scheme: 'https',
      host: host,
      path: portalPath,
      queryParameters: {
        'wfId': 'wf_PTW0005100-s_20120920145137',
        'event': 'findMyscheduleList',
        'calendarYear': '2024',
        'calendarMonth': '7',
        'selectedDate': '${year}_${month}_${day}_Thu_wf_PTW0005100-s_20120920145137',
        'action': 'rwf',
        'tabId': 'home',
        'page': 'main',
        'rwfHash': _rwfHash,
      },
    );
    String body = (await _client.post(scheduleURI)).body;
    String clipped = clip(body, '<ul class="mysch-portlet-list">', '</ul>');

    return clipped.split('<li class=')
        .map((e) {
          try {
            return Schedule.fromHTMLElement(e);
          } catch (e) {
            print(e);
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }
}

void _checkUsername(String userName) {
  if (userName.isEmpty) {
    throw Exception('Username is empty');
  }
}

void _checkPassword(String password) {
  if (password.isEmpty) {
    throw Exception('Password is empty');
  }
}

/// Extract the RWF hash from the raw HTML file
String _extractRWFHash(String html) {
  String clipped = clip(html, 'var portalConf = ', ';')
      .replaceAll('\'', '"');
  Map<String, dynamic> json = jsonDecode(clipped);

  if (json['rwfHash'] == null) {
    throw Exception('Failed to extract RWF hash');
  }
  if (json['rwfHash'] is! String) {
    throw Exception('Failed to extract RWF hash');
  }
  return json['rwfHash'];
}

/// Extracts a substring from a target string based on two marker strings
///
/// [target] The target string from which to extract the substring
/// [first] The first marker string to delimit the start of the substring
/// [last] The second marker string to delimit the end of the substring
String clip(final String target, final String first, final String last) {
  final int startIndex = (target.indexOf(first) + first.length);
  return target.substring(startIndex, target.indexOf(last, startIndex));
}