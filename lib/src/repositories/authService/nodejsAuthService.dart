import 'package:http/http.dart';

import 'index.dart';

class NodejsAuthService extends AuthService {
  String apiUrl;
  Client client = Client();

  NodejsAuthService(this.apiUrl);

  Future<bool> login(String usernameOrEmail, String password) async {
    print('Login...');
    final response = await client.post(apiUrl + '/api/users/login',
        body: {'usernameOrEmail': usernameOrEmail, 'password': password});
    if (response.statusCode == 200) {
      saveToken(response.body.toString());
      return true;
    }
    return false;
  }
}
