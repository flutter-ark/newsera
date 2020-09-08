import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCall {
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization":
            "Bearer 032a148c765b4336b57e2a863aad6baf", // yuv pro acc // normally its not manually coded as we fetch the O2Auth token for the server and use it here. This is just for demo purpose as we don't have a auth system with server side.
      };

  postData(data, apiUrl) async {
    final response =
        await http.post(apiUrl, body: jsonEncode(data), headers: _setHeaders());
    return await json.decode(response.body) as Map<String, dynamic>;
  }

  getData(apiUrl) async {
    final response = await http.get(apiUrl, headers: _setHeaders());
    return await json.decode(response.body) as Map<String, dynamic>;
  }
}
