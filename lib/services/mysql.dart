/*import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '10.0.2.2',
      user = 'root',
      password = 'sifra123',
      db = 'hffl_zapisnik';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
      host: host,
      port: port,
      password: password,
      user: user,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}*/
