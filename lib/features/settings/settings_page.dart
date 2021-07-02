import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterhole_web/constants.dart';
import 'package:flutterhole_web/dialogs.dart';
import 'package:flutterhole_web/features/grid/grid_layout.dart';
import 'package:flutterhole_web/features/layout/list.dart';
import 'package:flutterhole_web/features/layout/snackbar.dart';
import 'package:flutterhole_web/features/settings/developer_preferences.dart';
import 'package:flutterhole_web/features/settings/developer_widgets.dart';
import 'package:flutterhole_web/features/settings/pi_builders.dart';
import 'package:flutterhole_web/features/settings/settings_providers.dart';
import 'package:flutterhole_web/features/settings/single_pi_page.dart';
import 'package:flutterhole_web/features/settings/themes.dart';
import 'package:flutterhole_web/features/settings/user_preferences.dart';
import 'package:flutterhole_web/features/themes/theme_builders.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devMode = useProvider(devModeProvider);

    final Map<StaggeredTile, Widget> items = {
      // ignore: prefer_const_constructors
      StaggeredTile.fit(4): const ListTitle('Preferences'),
      // ignore: prefer_const_constructors
      StaggeredTile.fit(4): const UserPreferencesListView(),
      // ignore: prefer_const_constructors
      StaggeredTile.fit(4): const Divider(),
      // ignore: prefer_const_constructors
      StaggeredTile.extent(4, kToolbarHeight): const ListTitle('My Pi-holes'),
      // ignore: prefer_const_constructors
      StaggeredTile.extent(4, kToolbarHeight): const AddPiTile(),
      // ignore: prefer_const_constructors
      StaggeredTile.fit(4): PiListBuilder(
        onTap: (pi) {
          context.router.pushAndSaveSinglePiRoute(context, pi);
        },
      ),
      // ignore: prefer_const_constructors
      StaggeredTile.fit(4): const Divider(),
      // ignore: prefer_const_constructors
      StaggeredTile.extent(4, kToolbarHeight): const ListTitle('Danger zone'),
      // ignore: prefer_const_constructors
      StaggeredTile.count(2, 1): const _ResetActiveDashboardCard(),
      // ignore: prefer_const_constructors
      StaggeredTile.count(2, 1): const _DeletePiHolesCard(),
      // ignore: prefer_const_constructors
      StaggeredTile.count(2, 1): const _ToggleDevModeCard(),
      // ignore: prefer_const_constructors
      StaggeredTile.count(2, 1): const _ResetAllSettingsCard(),
    };

    if (devMode) {
      items.addAll({
        // ignore: prefer_const_constructors
        StaggeredTile.fit(4): const ListTitle('Developer'),
        // ignore: prefer_const_constructors
        StaggeredTile.fit(4): const DeveloperPreferencesListView(),
      });
    }

    items.addAll({
      // ignore: prefer_const_constructors
      StaggeredTile.extent(4, kToolbarHeight): Container(),
    });

    return ActivePiTheme(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: const [
            ThemeModeToggle(),
          ],
        ),
        body: PortraitPageGrid(
          // pageController: pageController,
          // crossAxisCount: 4,
          tiles: items.keys.toList(),
          children: items.values.toList(),
        ),
      ),
    );
  }
}

class _ResetAllSettingsCard extends StatelessWidget {
  const _ResetAllSettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PiColorsBuilder(
        builder: (context, piColors, child) => GridCard(
              color: piColors.error,
              child: GridInkWell(
                onTap: () => showModal(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    title: 'Reset all settings?',
                    onConfirm: () async {
                      await context
                          .read(settingsNotifierProvider.notifier)
                          .reset();
                      ScaffoldMessenger.of(context).showMessageNow(
                        message: 'All settings have been reset.',
                        leading: Icon(
                          KIcons.refresh,
                          color: piColors.error,
                        ),
                      );
                    },
                    body: const Text(
                        'All your preferences and Pi-holes and will be lost. This could help if the app gets stuck.'),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(KIcons.refresh, color: piColors.onError),
                      const SizedBox(width: kGridSpacing),
                      Text(
                        'Reset all settings',
                        style: TextStyle(color: piColors.onError),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class _DeletePiHolesCard extends StatelessWidget {
  const _DeletePiHolesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PiColorsBuilder(
        builder: (context, piColors, child) => GridCard(
              color: piColors.warning,
              child: GridInkWell(
                onTap: () => showModal(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    title: 'Delete all Pi-holes?',
                    onConfirm: () async {
                      await context
                          .read(settingsNotifierProvider.notifier)
                          .resetPiHoles();
                      ScaffoldMessenger.of(context).showMessageNow(
                        message: 'All Pi-holes have been deleted.',
                        leading: Icon(
                          KIcons.delete,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      );
                    },
                    body: const Text(
                        'All your Pi-holes and will be lost. This could help if the app gets stuck.'),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(KIcons.delete, color: piColors.onWarning),
                      const SizedBox(width: kGridSpacing),
                      Text(
                        'Delete all Pi-holes',
                        style: TextStyle(color: piColors.onWarning),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class _ResetActiveDashboardCard extends StatelessWidget {
  const _ResetActiveDashboardCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PiColorsBuilder(
        builder: (context, piColors, child) => GridCard(
              color: KColors.memoryUsage,
              child: GridInkWell(
                onTap: () => showModal(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    title: 'Reset active dashboard?',
                    onConfirm: () async {
                      await context
                          .read(settingsNotifierProvider.notifier)
                          .resetDashboard();
                      ScaffoldMessenger.of(context).showMessageNow(
                        message: 'Dashboard has been reset.',
                        leading: Icon(
                          KIcons.delete,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      );
                    },
                    body: const Text(
                        'Your active dashboard configuration will be lost. Other Pi-holes will be unaffected. Convenient when starting over.'),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(KIcons.dashboard, color: piColors.onWarning),
                      const SizedBox(width: kGridSpacing),
                      Text(
                        'Reset dashboard',
                        style: TextStyle(color: piColors.onWarning),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class _ToggleDevModeCard extends HookWidget {
  const _ToggleDevModeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enabled = useProvider(devModeProvider);

    return PiColorsBuilder(
        builder: (context, piColors, child) => GridCard(
              color: KColors.code,
              child: GridInkWell(
                onTap: () {
                  // enabled.value = !enabled.value;
                  context
                      .read(settingsNotifierProvider.notifier)
                      .toggleDevMode();
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(KIcons.logDebug, color: piColors.onWarning),
                      const SizedBox(width: kGridSpacing),
                      Text(
                        '${enabled ? 'Disable' : 'Enable'} dev mode',
                        style: TextStyle(color: piColors.onWarning),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
