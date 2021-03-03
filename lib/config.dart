import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

// 云接口相关配置

class CloudConfig {
  static String tcbAndroidAccessKey;
  static String tcbAndroidAccessKeyVersion;
  static String tcbIOSAccessKey;
  static String tcbIOSAccessKeyVersion;
  static String tcbEnv;

  static String tmpUsername;
  static String tmpPassword;

  static Future<void> init() async {
    await DotEnv.load(fileName: ".env");
    print(DotEnv.env);
    tcbAndroidAccessKeyVersion = DotEnv.env["tcbAndroidAccessKeyVersion"];
    tcbAndroidAccessKey = DotEnv.env["tcbAndroidAccessKey"];
    tcbEnv = DotEnv.env["tcbEnv"];
    tcbIOSAccessKey = DotEnv.env["tcbIOSAccessKey"];
    tcbIOSAccessKeyVersion = DotEnv.env["tcbIOSAccessKeyVersion"];

    tmpUsername = DotEnv.env["tmp_username"];
    tmpPassword = DotEnv.env["tmp_password"];
  }
}
