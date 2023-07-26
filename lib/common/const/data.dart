import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = "ACCESS_TOKEN";
const REFRESH_TOKEN_KEY = "REFRESH_TOKEN";

final emulLocalhost = "10.0.2.2:3000";
final simulLocalhost = "127.0.0.2:3000";

final ip = Platform.isIOS ? simulLocalhost : emulLocalhost;

final storage = FlutterSecureStorage();


