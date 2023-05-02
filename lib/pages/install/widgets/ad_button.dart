import 'dart:async';
import 'dart:io';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mod_test/resources/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/services/admob_service.dart';

import 'package:open_file/open_file.dart';

class RewardedAdButton extends StatefulWidget {
  const RewardedAdButton({Key? key}) : super(key: key);

  @override
  State<RewardedAdButton> createState() => _RewardedAdButtonState();
}

class _RewardedAdButtonState extends State<RewardedAdButton> {
  late final bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    AdModService.createRewardedAd();
  }

  void _onPressed() {
    if (_isLoading) return;
    _isLoading = true;

    AdModService.periodicCheckAdToShow(
      setState: setState,
      isLoading: _isLoading,
      showAd: () => AdModService.showRewardedAd(
        onAdClosed: _afterDismissingRewardedAd,
        onGettingRewards: _afterWatchingRewardedAd,
        updateState: _resetState,
      ),
    );
  }

  _resetState() {
    _isLoading = false;
    setState(() {});
  }

  Future<void> _afterDismissingRewardedAd() async {}

  Future<void> _afterWatchingRewardedAd() async {
    Navigator.of(context, rootNavigator: true).pop();
    bool isInstalled =
        await DeviceApps.isAppInstalled('com.mojang.minecraftpe');
    if (isInstalled) {
      const url =
          'https://www.dropbox.com/s/5wc31t4yio8j2f8/spider.mcaddon?dl=1';
      final response = await http.get(Uri.parse(url));
      final getAddonDirectory = await getExternalStorageDirectory();
      final bytes = response.bodyBytes;
      const fileName = 'spider.mcaddon';
      final file = File('${getAddonDirectory!.path}/$fileName');
      final ready = await file.writeAsBytes(bytes);
      await OpenFile.open(ready.path);
    } else {
      const snackBar = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.white,
        content: Text(
          'Minecraft не установлен на вашем телефоне',
          style: TextStyle(fontSize: 17),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _isLoading ? Colors.grey : Colors.deepPurpleAccent;
    return Stack(
      children: [
        AppButtonWidget(
          color: color,
          shadowColor: color,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 21,
                height: 21,
              ),
              const Text('Смотреть'),
              Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _isLoading ? null : AppColors.icon,
                ),
                width: 21,
                height: 21,
                child: _isLoading
                    ? CircularProgressIndicator(color: color)
                    : const FittedBox(child: Text('AD')),
              ),
            ],
          ),
          height: 53,
          width: 230,
          onPressed: _isLoading ? null : _onPressed,
        ),
      ],
    );
  }
}
