import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:immich_mobile/entities/asset.entity.dart';
import 'package:photo_manager/photo_manager.dart' show ThumbnailSize;
import 'package:image/image.dart';

/// The local image provider for an asset
class ImmichLocalImageProvider extends ImageProvider<ImmichLocalImageProvider> {
  final Asset asset;

  ImmichLocalImageProvider({
    required this.asset,
  }) : assert(asset.local != null, 'Only usable when asset.local is set');

  /// Converts an [ImageProvider]'s settings plus an [ImageConfiguration] to a key
  /// that describes the precise image to load.
  @override
  Future<ImmichLocalImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(
    ImmichLocalImageProvider key,
    ImageDecoderCallback decode,
  ) {
    final chunkEvents = StreamController<ImageChunkEvent>();
    return MultiImageStreamCompleter(
      codec: _codec(key.asset, decode, chunkEvents),
      scale: 1.0,
      chunkEvents: chunkEvents.stream,
      informationCollector: () sync* {
        yield ErrorDescription(asset.fileName);
      },
    );
  }

  // Streams in each stage of the image as we ask for it
  Stream<ui.Codec> _codec(
    Asset key,
    ImageDecoderCallback decode,
    StreamController<ImageChunkEvent> chunkEvents,
  ) async* {
    // Load a small thumbnail
    Uint8List? thumbBytes;
    if (Platform.isLinux || Platform.isWindows) {
      final bytes = await File(asset.localId!).readAsBytes();
      final image = decodeImage(bytes);
      if (image != null) {
        final thumbnail = image.height < image.width
            ? copyResize(image,
                height: 256, interpolation: Interpolation.average)
            : copyResize(image,
                width: 256, interpolation: Interpolation.average);
        thumbBytes = encodePng(thumbnail);
      }
    } else {
      thumbBytes = await asset.local?.thumbnailDataWithSize(
        const ThumbnailSize.square(256),
        quality: 80,
      );
    }
    if (thumbBytes != null) {
      final buffer = await ui.ImmutableBuffer.fromUint8List(thumbBytes);
      final codec = await decode(buffer);
      yield codec;
    } else {
      debugPrint("Loading thumb for ${asset.fileName} failed");
    }

    if (asset.isImage) {
      File? file;
      if (Platform.isLinux || Platform.isWindows) {
        final path = asset.localId;
        file = path != null ? File(path) : null;
      } else {
        file = await asset.local?.originFile;
      }
      if (file == null) {
        throw StateError("Opening file for asset ${asset.fileName} failed");
      }
      try {
        final buffer = await ui.ImmutableBuffer.fromFilePath(file.path);
        final codec = await decode(buffer);
        yield codec;
      } catch (error) {
        throw StateError("Loading asset ${asset.fileName} failed");
      }
    }

    chunkEvents.close();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is ImmichLocalImageProvider) {
      return asset == other.asset;
    }

    return false;
  }

  @override
  int get hashCode => asset.hashCode;
}
