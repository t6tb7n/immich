import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/extensions/build_context_extensions.dart';
import 'package:immich_mobile/providers/album/album.provider.dart';
import 'package:immich_mobile/providers/multiselect.provider.dart';
import 'package:immich_mobile/providers/timeline.provider.dart';
import 'package:immich_mobile/widgets/memories/memory_lane.dart';
import 'package:immich_mobile/providers/asset.provider.dart';
import 'package:immich_mobile/providers/server_info.provider.dart';
import 'package:immich_mobile/providers/user.provider.dart';
import 'package:immich_mobile/providers/websocket.provider.dart';
import 'package:immich_mobile/widgets/asset_grid/multiselect_grid.dart';
import 'package:immich_mobile/widgets/common/immich_app_bar.dart';
import 'package:immich_mobile/widgets/common/immich_loading_indicator.dart';

class ZoomInIntent extends Intent {}

class ZoomOutIntent extends Intent {}

class ZoomInAction extends Action {
  @override
  Object? invoke(Intent intent) {
    // TODO: implement invoke
    throw UnimplementedError();
  }
}

class ZoomOutAction extends Action {
  @override
  Object? invoke(Intent intent) {
    // TODO: implement invoke
    throw UnimplementedError();
  }
}

@RoutePage()
class PhotosPage extends HookConsumerWidget {
  final List<Function> zoomCallbacks = [];

  PhotosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final timelineUsers = ref.watch(timelineUsersIdsProvider);
    final tipOneOpacity = useState(0.0);
    final refreshCount = useState(0);
    final scalingFactor = useState(10);

    useEffect(
      () {
        ref.read(websocketProvider.notifier).connect();
        Future(() => ref.read(assetProvider.notifier).getAllAsset());
        Future(() => ref.read(albumProvider.notifier).refreshRemoteAlbums());
        ref.read(serverInfoProvider.notifier).getServerInfo();

        return;
      },
      [],
    );

    Widget buildLoadingIndicator() {
      Timer(const Duration(seconds: 2), () => tipOneOpacity.value = 1);

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImmichLoadingIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'home_page_building_timeline',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: context.primaryColor,
                ),
              ).tr(),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: tipOneOpacity.value,
              child: SizedBox(
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: const Text(
                    'home_page_first_time_notice',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ).tr(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Future<void> refreshAssets() async {
      final fullRefresh = refreshCount.value > 0;

      if (fullRefresh) {
        Future.wait([
          ref.read(assetProvider.notifier).getAllAsset(clear: true),
          ref.read(albumProvider.notifier).refreshRemoteAlbums(),
        ]);

        // refresh was forced: user requested another refresh within 2 seconds
        refreshCount.value = 0;
      } else {
        await ref.read(assetProvider.notifier).getAllAsset(clear: false);

        refreshCount.value++;
        // set counter back to 0 if user does not request refresh again
        Timer(const Duration(seconds: 4), () => refreshCount.value = 0);
      }
    }

    buildRefreshIndicator() {
      // final indicatorIcon = getBackupBadgeIcon();
      // final badgeBackground = context.colorScheme.surfaceContainer;
      const widgetSize = 30.0;
      return InkWell(
        onTap: () => refreshAssets(),
        borderRadius: BorderRadius.circular(12),
        child: Badge(
          backgroundColor: Colors.transparent,
          alignment: Alignment.bottomRight,
          offset: const Offset(-2, -12),
          child: Icon(
            Icons.refresh,
            size: widgetSize,
            color: context.primaryColor,
          ),
        ),
      );
    }

    zoomIn() {
      scalingFactor.value -= 1;
    }

    zoomOut() {
      scalingFactor.value += 1;
    }

    buildZoomInIndicator() {
      // final indicatorIcon = getBackupBadgeIcon();
      // final badgeBackground = context.colorScheme.surfaceContainer;
      const widgetSize = 30.0;
      return InkWell(
        onTap: () => zoomIn(),
        borderRadius: BorderRadius.circular(12),
        child: Badge(
          backgroundColor: Colors.transparent,
          alignment: Alignment.bottomRight,
          offset: const Offset(-2, -12),
          child: Icon(
            Icons.zoom_in,
            size: widgetSize,
            color: context.primaryColor,
          ),
        ),
      );
    }

    buildZoomOutIndicator() {
      // final indicatorIcon = getBackupBadgeIcon();
      // final badgeBackground = context.colorScheme.surfaceContainer;
      const widgetSize = 30.0;
      return InkWell(
        onTap: () => zoomOut(),
        borderRadius: BorderRadius.circular(12),
        child: Badge(
          backgroundColor: Colors.transparent,
          alignment: Alignment.bottomRight,
          offset: const Offset(-2, -12),
          child: Icon(
            Icons.zoom_out,
            size: widgetSize,
            color: context.primaryColor,
          ),
        ),
      );
    }

    return Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const SingleActivator(LogicalKeyboardKey.numpadAdd, control: true):
              ZoomInIntent(),
          const SingleActivator(LogicalKeyboardKey.numpadSubtract,
              control: true): ZoomOutIntent(),
        },
        child: Actions(
            actions: <Type, Action<Intent>>{
              ZoomInIntent:
                  CallbackAction<ZoomInIntent>(onInvoke: (ZoomInIntent intent) {
                zoomIn();
              }),
              ZoomOutIntent: CallbackAction<ZoomOutIntent>(
                  onInvoke: (ZoomOutIntent intent) {
                zoomOut();
              })
            },
            child: Focus(
                autofocus: true,
                child: Stack(
                  children: [
                    MultiselectGrid(
                        topWidget:
                            (currentUser != null && currentUser.memoryEnabled)
                                ? const MemoryLane()
                                : const SizedBox(),
                        renderListProvider: timelineUsers.length > 1
                            ? multiUsersTimelineProvider(timelineUsers)
                            : singleUserTimelineProvider(currentUser!.isarId),
                        buildLoadingIndicator: buildLoadingIndicator,
                        onRefresh: refreshAssets,
                        stackEnabled: true,
                        archiveEnabled: true,
                        editEnabled: true,
                        scalingFactor: scalingFactor.value,
                        addZoomListener: (Function cb) {
                          zoomCallbacks.clear();
                          zoomCallbacks.add(cb);
                        }),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      top: ref.watch(multiselectProvider)
                          ? -(kToolbarHeight + context.padding.top)
                          : 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: kToolbarHeight + context.padding.top,
                        color: context.themeData.appBarTheme.backgroundColor,
                        child: ImmichAppBar(actions: [
                          buildRefreshIndicator(),
                          buildZoomInIndicator(),
                          buildZoomOutIndicator()
                        ]),
                      ),
                    ),
                  ],
                ))));
  }
}
