import 'dart:async';
import 'dart:io';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mod_test/resources/app_colors.dart';
import 'package:mod_test/resources/app_consts.dart';
import 'package:mod_test/resources/app_texts.dart';
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
  late bool _isLoading;
  late String _filePath;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _filePath = '';
    AdModService.createRewardedAd();
  }

  void _onPressed() {
    if (_isLoading) return;
    _isLoading = true;

    AdModService.periodicCheckAdToShow(
      setState: setState,
      isLoading: _isLoading,
      showAd: () => AdModService.showRewardedAd(
        onAdClosed: _onClose,
        onGettingRewards: _onWatch,
        updateState: _resetState,
      ),
    );
  }

  _resetState() {
    _isLoading = false;
    setState(() {});
  }

  Future<void> _onWatch() async {
    bool isInstalled =
        await DeviceApps.isAppInstalled(AppConstantsString.minecraftPath);
    if (isInstalled) {
      final response = await http.get(Uri.parse(AppConstantsString.fileUrl));
      final getAddonDirectory = await getExternalStorageDirectory();
      final bytes = response.bodyBytes;

      final file =
          File('${getAddonDirectory!.path}/${AppConstantsString.fileName}');
      final ready = await file.writeAsBytes(bytes);
      _filePath = ready.path;
    } else {
      const snackBar = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.icon,
        content: Text(
          'Minecraft не установлен на вашем телефоне',
          style: AppText.txt1,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _onClose() async {
    Navigator.of(context, rootNavigator: true).pop();
    await OpenFile.open(_filePath);
  }

  @override
  Widget build(BuildContext context) {
    final color = _isLoading ? Colors.grey : AppColors.icon;
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
              const Text(
                'СМОТРЕТЬ',
                style: AppText.txt1,
              ),
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
