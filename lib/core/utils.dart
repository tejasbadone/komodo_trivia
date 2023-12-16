import 'package:html_unescape/html_unescape.dart';

String decodeString(String text) {
  var escape = HtmlUnescape().convert(text);
  return escape;
}
