import 'package:flutter/material.dart';
import 'package:flutter_flurry_sdk/flurry.dart';
import 'package:mod_test/pages/install/widgets/ad_dialog.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/resources/utils/colors.dart';

class InstallPage extends StatelessWidget {
  static const routeName = '/install';

  const InstallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Shader Mod',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.icon,
      ),
      body: ListView(
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image(
              image: AssetImage('assets/images/img_0-min.jpg'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          buildInstallButtonWidget(context),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'С Eternal Shaders графика игры будет поднята на беспрецедентный уровень. Это '
              'обновление вносит ряд улучшений, таких как реалистичное освещение, тени,'
              'отражения и динамическая вода. Мир игры будет более ярким и подлинным'
              ' благодаря сложным деталям и реалистичному движению растений.',
              style: TextStyle(height: 1.5),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Особенности мода Eternal Shaders: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              '* Поддержка RenderDragon для улучшения производительности и качества отображения.\n'
              '* Эффекты свечения Солнца и Луны для более погружающегося игрового опыта.\n'
              '* Движение растений для реалистичной и динамичной среды.\n'
              '* Оптимизация биомов для повышения общей производительности игры.\n'
              '* Отсутствие задержек для плавной и безшовной игры.\n'
              '* Совместимость с другими аддонами для дальнейшей настройки и персонализации игр.\n',
              style: TextStyle(height: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/img_1-min.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/img_3-min.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/img_5-min.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/img_6-min.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/img_9-min.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          buildInstallButtonWidget(context),
        ],
      ),
    );
  }

  AppButtonWidget buildInstallButtonWidget(BuildContext context) {
    return AppButtonWidget(
      onPressed: () {
        Flurry.logEvent('Pressed INSTALL button');
        showDialog(
          context: context,
          builder: (_) => const AdDialog(),
        );
      },
      color: AppColors.icon,
      title: const Text(
        'Установить',
        style: TextStyle(color:AppColors.white, fontWeight: FontWeight.bold),
      ),
      height: 60,
      width: 250,
    );
  }
}
