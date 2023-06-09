import 'dart:async';
import 'dart:io';
import 'package:ShaderMod/services/snack_bar_service.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:ShaderMod/resources/app_colors.dart';
import 'package:ShaderMod/resources/app_consts.dart';
import 'package:ShaderMod/resources/app_texts.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ShaderMod/pages/widgets/button_widget.dart';
import 'package:ShaderMod/services/admob_service.dart';
import 'package:open_file/open_file.dart';

class RewardedAdButton extends StatefulWidget {
  const RewardedAdButton({Key? key}) : super(key: key);

  @override
  State<RewardedAdButton> createState() => _RewardedAdButtonState();
}

class _RewardedAdButtonState extends State<RewardedAdButton> {
  late bool _isLoading;
  late String _filePath;
  late String _scaffoldMessage;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _filePath = '';
    _scaffoldMessage = '';
    AdModService.createRewardedAd();
  }

  void _onPressed() {
    if (_isLoading) return;
    _isLoading = true;
    _onWatch();

    AdModService.periodicCheckAdToShow(
      setLoading: (loading) => _setLoading(loading),
      isLoading: _isLoading,
      showAd: () => AdModService.showRewardedAd(
        onAdClosed: _onClose,
        onGettingRewards: () {},
        updateState: _setLoading,
      ),
    );
  }

  _setLoading(bool loading) {
    _isLoading = loading;
    setState(() {});
  }

  Future<void> _onWatch() async {
    _scaffoldMessage = '';
    bool isInstalled =
    await DeviceApps.isAppInstalled(AppConstantsString.minecraftPath);
    if (isInstalled) {
      _getFile();
    } else {
      _scaffoldMessage = 'Minecraft не установлен на вашем телефоне';
    }
  }



  Future<void> _onClose() async {
    Navigator.of(context, rootNavigator: true).pop();
    if (_scaffoldMessage.isNotEmpty) {
      SnackBarService.showSnackBar(context: context, message: _scaffoldMessage);
    } else {
      await OpenFile.open(_filePath,
          type: AppConstantsString.minecraftPath);
    }
  }

  Future<void> _getFile() async {
    final tempDir = await getExternalStorageDirectory();
    final file = File('${tempDir!.path}/${AppConstantsString.fileName}');
    final ifExist  =  await file.exists();
    _filePath = file.path;
    if (ifExist) return;
    final ByteData assetData =
    await rootBundle.load(AppConstantsString.assetFilePath);
    await file.writeAsBytes(assetData.buffer.asUint8List(), flush: true);
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
                  color: _isLoading ? null : AppColors.ad,
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
