import 'dart:io';

import 'package:path_provider_windows/path_provider_windows.dart';

Future<String> getDefaultAlbumPath() async {
  String? path;
  if (Platform.isLinux) {
    try {
      path = (await Process.run('xdg-user-dir', ['PICTURES']))
          .stdout
          .toString()
          .trim();
    } catch (e) {
      throw Exception("Can not resolve default user pictures paths: $e");
    }
  } else if (Platform.isWindows) {
    path = await PathProviderWindows().getPath(WindowsKnownFolder.Pictures);
  } else {
    throw UnsupportedError("Unsupported platform");
  }

  if (path == null || path.isEmpty) {
    throw Exception("Can not resolve default user pictures paths");
  }

  return path;
}
