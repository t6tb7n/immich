import 'dart:io';
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/domain/models/store.model.dart';
import 'package:immich_mobile/domain/models/user.model.dart';
import 'package:immich_mobile/entities/album.entity.dart';
import 'package:immich_mobile/entities/asset.entity.dart';
import 'package:immich_mobile/entities/store.entity.dart';
import 'package:immich_mobile/infrastructure/entities/user.entity.dart';
import 'package:immich_mobile/interfaces/album_media.interface.dart';
import 'package:immich_mobile/repositories/asset_media.repository.dart';
import 'package:photo_manager/photo_manager.dart' hide AssetType;
import 'package:crypto/crypto.dart';

final albumMediaRepositoryProvider = Provider((ref) =>
    (Platform.isLinux || Platform.isWindows)
        ? DesktopAlbumMediaRepository()
        : AlbumMediaRepository());

class AlbumMediaRepository implements IAlbumMediaRepository {
  @override
  Future<List<Album>> getAll() async {
    final List<AssetPathEntity> assetPathEntities =
        await PhotoManager.getAssetPathList(
      hasAll: true,
      filterOption: FilterOptionGroup(containsPathModified: true),
    );
    return assetPathEntities.map(_toAlbum).toList();
  }

  @override
  Future<List<String>> getAssetIds(String albumId) async {
    final album = await AssetPathEntity.fromId(albumId);
    final List<AssetEntity> assets =
        await album.getAssetListRange(start: 0, end: 0x7fffffffffffffff);
    return assets.map((e) => e.id).toList();
  }

  @override
  Future<int> getAssetCount(String albumId) async {
    final album = await AssetPathEntity.fromId(albumId);
    return album.assetCountAsync;
  }

  @override
  Future<List<Asset>> getAssets(
    String albumId, {
    int start = 0,
    int end = 0x7fffffffffffffff,
    DateTime? modifiedFrom,
    DateTime? modifiedUntil,
    bool orderByModificationDate = false,
  }) async {
    final onDevice = await AssetPathEntity.fromId(
      albumId,
      filterOption: FilterOptionGroup(
        containsPathModified: true,
        orders: orderByModificationDate
            ? [const OrderOption(type: OrderOptionType.updateDate)]
            : [],
        imageOption: const FilterOption(needTitle: true),
        videoOption: const FilterOption(needTitle: true),
        updateTimeCond: modifiedFrom == null && modifiedUntil == null
            ? null
            : DateTimeCond(
                min: modifiedFrom ?? DateTime.utc(-271820),
                max: modifiedUntil ?? DateTime.utc(275760),
              ),
      ),
    );

    final List<AssetEntity> assets =
        await onDevice.getAssetListRange(start: start, end: end);
    return assets.map(AssetMediaRepository.toAsset).toList().cast();
  }

  @override
  Future<Album> get(
    String id, {
    DateTime? modifiedFrom,
    DateTime? modifiedUntil,
  }) async {
    final assetPathEntity = await AssetPathEntity.fromId(id);
    return _toAlbum(assetPathEntity);
  }

  static Album _toAlbum(AssetPathEntity assetPathEntity) {
    final Album album = Album(
      name: assetPathEntity.name,
      createdAt:
          assetPathEntity.lastModified?.toUtc() ?? DateTime.now().toUtc(),
      modifiedAt:
          assetPathEntity.lastModified?.toUtc() ?? DateTime.now().toUtc(),
      shared: false,
      activityEnabled: false,
    );
    album.owner.value = User.fromDto(Store.get(StoreKey.currentUser));
    album.localId = assetPathEntity.id;
    album.isAll = assetPathEntity.isAll;
    return album;
  }
}

class DesktopAlbumMediaRepository implements IAlbumMediaRepository {
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

  Future<Album> getDefaultAlbum() async {
    final outputDir = await getDefaultAlbumPath();
    final name = outputDir.split('/').last;
    final album = Album(
      name: name,
      createdAt: DateTime.now().toUtc(),
      modifiedAt: DateTime.now().toUtc(),
      shared: false,
      activityEnabled: false,
      localId: name,
    );
    album.isAll = true;
    return album;
  }

  @override
  Future<List<Album>> getAll() async {
    // final List<AssetPathEntity> assetPathEntities =
    //     await PhotoManager.getAssetPathList(
    //   hasAll: true,
    //   filterOption: FilterOptionGroup(containsPathModified: true),
    // );
    // return assetPathEntities.map(_toAlbum).toList();
    return [await getDefaultAlbum()];
  }

  @override
  Future<List<String>> getAssetIds(String albumId) async {
    // final album = await AssetPathEntity.fromId(albumId);
    // final List<AssetEntity> assets =
    //     await album.getAssetListRange(start: 0, end: 0x7fffffffffffffff);
    // return assets.map((e) => e.id).toList();
    final defaultAlbumPath = await getDefaultAlbumPath();
    List<String> assetIds = [];
    await for (final entry in Directory(defaultAlbumPath)
        .list(recursive: true, followLinks: true)) {
      if (entry.path.toLowerCase().endsWith('.jpg')) assetIds.add(entry.path);
    }
    return assetIds;
  }

  @override
  Future<int> getAssetCount(String albumId) async {
    // final album = await AssetPathEntity.fromId(albumId);
    // return album.assetCountAsync;
    final defaultAlbumPath = await getDefaultAlbumPath();
    List<String> assetIds = [];
    await for (final entry in Directory(defaultAlbumPath)
        .list(recursive: true, followLinks: true)) {
      if (entry.path.toLowerCase().endsWith('.jpg')) assetIds.add(entry.path);
    }
    return assetIds.length;
  }

  @override
  Future<List<Asset>> getAssets(
    String albumId, {
    int start = 0,
    int end = 0x7fffffffffffffff,
    DateTime? modifiedFrom,
    DateTime? modifiedUntil,
    bool orderByModificationDate = false,
  }) async {
    // final onDevice = await AssetPathEntity.fromId(
    //   albumId,
    //   filterOption: FilterOptionGroup(
    //     containsPathModified: true,
    //     orders: orderByModificationDate
    //         ? [const OrderOption(type: OrderOptionType.updateDate)]
    //         : [],
    //     imageOption: const FilterOption(needTitle: true),
    //     videoOption: const FilterOption(needTitle: true),
    //     updateTimeCond: modifiedFrom == null && modifiedUntil == null
    //         ? null
    //         : DateTimeCond(
    //             min: modifiedFrom ?? DateTime.utc(-271820),
    //             max: modifiedUntil ?? DateTime.utc(275760),
    //           ),
    //   ),
    // );

    // final List<AssetEntity> assets =
    //     await onDevice.getAssetListRange(start: start, end: end);
    // return assets.map(AssetMediaRepository.toAsset).toList().cast();

    final defaultAlbumPath = await getDefaultAlbumPath();
    List<String> assetIds = [];
    await for (final entry in Directory(defaultAlbumPath)
        .list(recursive: true, followLinks: true)) {
      if (entry.path.toLowerCase().endsWith('.jpg'))
        assetIds.add(entry.absolute.path);
    }

    final user = Store.get<UserDto>(StoreKey.currentUser);
    final userId = user.id;
    return assetIds.map((e) async {
      return Asset(
          checksum:
              base64.encode(sha1.convert(await File(e).readAsBytes()).bytes),
          localId: e,
          ownerId: userId,
          fileCreatedAt: await File(e).lastModified(),
          fileModifiedAt: await File(e).lastModified(),
          updatedAt: await File(e).lastModified(),
          durationInSeconds: 0,
          type: AssetType.image,
          fileName: e);
    }).wait;
  }

  @override
  Future<Album> get(
    String id, {
    DateTime? modifiedFrom,
    DateTime? modifiedUntil,
  }) async {
    // final assetPathEntity = await AssetPathEntity.fromId(id);
    // return _toAlbum(assetPathEntity);
    return await getDefaultAlbum();
  }
}
