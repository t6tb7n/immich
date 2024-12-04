import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/entities/asset.entity.dart';
import 'package:immich_mobile/interfaces/file_media.interface.dart';
import 'package:immich_mobile/repositories/asset_media.repository.dart';
import 'package:photo_manager/photo_manager.dart' hide AssetType;

final fileMediaRepositoryProvider = Provider((ref) =>
    (Platform.isLinux || Platform.isWindows)
        ? DesktopFileMediaRepository()
        : FileMediaRepository());

class FileMediaRepository implements IFileMediaRepository {
  @override
  Future<Asset?> saveImage(
    Uint8List data, {
    required String title,
    String? relativePath,
  }) async {
    final entity = await PhotoManager.editor.saveImage(
      data,
      filename: title,
      title: title,
      relativePath: relativePath,
    );
    return AssetMediaRepository.toAsset(entity);
  }

  @override
  Future<Asset?> saveImageWithFile(
    String filePath, {
    String? title,
    String? relativePath,
  }) async {
    final entity = await PhotoManager.editor.saveImageWithPath(
      filePath,
      title: title,
      relativePath: relativePath,
    );
    return AssetMediaRepository.toAsset(entity);
  }

  @override
  Future<Asset?> saveLivePhoto({
    required File image,
    required File video,
    required String title,
  }) async {
    final entity = await PhotoManager.editor.darwin.saveLivePhoto(
      imageFile: image,
      videoFile: video,
      title: title,
    );
    return AssetMediaRepository.toAsset(entity);
  }

  @override
  Future<Asset?> saveVideo(
    File file, {
    required String title,
    String? relativePath,
  }) async {
    final entity = await PhotoManager.editor.saveVideo(
      file,
      title: title,
      relativePath: relativePath,
    );
    return AssetMediaRepository.toAsset(entity);
  }

  @override
  Future<void> clearFileCache() => PhotoManager.clearFileCache();

  @override
  Future<void> enableBackgroundAccess() =>
      PhotoManager.setIgnorePermissionCheck(true);

  @override
  Future<void> requestExtendedPermissions() =>
      PhotoManager.requestPermissionExtend();
}

class DesktopFileMediaRepository implements IFileMediaRepository {
  Future<String> getDefaultAlbumPath() async {
    if (Platform.isLinux) {
      return (await Process.run('xdg-user-dir', ['PICTURES']))
          .stdout
          .toString()
          .trim();
    } else {
      final user = Platform.environment["UserProfile"]!;
      return '$user\\Pictures';
    }
  }

  @override
  Future<Asset?> saveImage(
    Uint8List data, {
    required String title,
    String? relativePath,
  }) async {
    final entity = AssetEntity(id: title, typeInt: 0, height: 0, width: 0);

    // final entity = await PhotoManager.editor.saveImage(
    //   data,
    //   filename: title,
    //   title: title,
    //   relativePath: relativePath,
    // );

    return AssetMediaRepository.toAsset(entity);
  }

  @override
  Future<Asset?> saveImageWithFile(
    String filePath, {
    String? title,
    String? relativePath,
  }) async {
    final file = File(filePath);
    final data = await file.readAsBytes();
    final outputDir = await getDefaultAlbumPath();
    final outputName =
        relativePath ?? filePath.split(Platform.pathSeparator).last;
    await Directory('$outputDir${Platform.pathSeparator}Immich')
        .create(recursive: true);
    final outputPath =
        '$outputDir${Platform.pathSeparator}Immich${Platform.pathSeparator}$outputName';
    await File(outputPath).writeAsBytes(data);

    final entity = AssetEntity(
        id: filePath, typeInt: 0, height: 0, width: 0, title: title);

    // final entity = await PhotoManager.editor.saveImageWithPath(
    //   filePath,
    //   title: title,
    //   relativePath: relativePath,
    // );
    return AssetMediaRepository.toAsset(entity);
  }

  @override
  Future<Asset?> saveLivePhoto({
    required File image,
    required File video,
    required String title,
  }) async {
    throw UnimplementedError();
    final entity = AssetEntity(id: title, typeInt: 0, height: 0, width: 0);
    // final entity = await PhotoManager.editor.darwin.saveLivePhoto(
    //   imageFile: image,
    //   videoFile: video,
    //   title: title,
    // );
    return AssetMediaRepository.toAsset(entity);
  }

  @override
  Future<Asset?> saveVideo(
    File file, {
    required String title,
    String? relativePath,
  }) async {
    throw UnimplementedError();
    final entity = AssetEntity(id: title, typeInt: 0, height: 0, width: 0);
    // final entity = await PhotoManager.editor.saveVideo(
    //   file,
    //   title: title,
    //   relativePath: relativePath,
    // );
    return AssetMediaRepository.toAsset(entity);
  }

  @override
  Future<void> clearFileCache() {
    // throw UnimplementedError();
    return Future(() => {});
  }

  @override
  Future<void> enableBackgroundAccess() {
    throw UnimplementedError();
  }

  @override
  Future<void> requestExtendedPermissions() {
    throw UnimplementedError();
  }
}
