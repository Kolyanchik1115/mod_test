
import 'package:flutter/material.dart';
import 'package:mod_test/pages/widgets/add_dialog.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';


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
        backgroundColor: Colors.deepPurple,
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
          AppButtonWidget(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const RewardedAdButton(),
              );
            },
            color: Colors.deepPurple,
            title: const Text(
              'INSTALL',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            height: 60,
            width: 250,
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'With Eternal Shaders, the graphics of the game will be elevated to an unprecedented level.'
              'This update brings in a range of enhancements such as realistic lighting, shadows,'
              ' reflections, and dynamic water. The game world will be more vibrant and'
              'authentic, thanks'
              'to the intricate details and lifelike movement of the plants',
              style: TextStyle(height: 1.5),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Features of the Eternal Shaders Mod: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              '* RenderDragon support for improved rendering performance and quality.\n'
              '* Sun and Moon glow effects for a more immersive gameplay experience.\n'
              '* Plant movement for a realistic and dynamic environment.\n'
              '* Biome Optimization to enhance the overall game performance.\n'
              '* No lagging for smoother and seamless gameplay.\n'
              '* Compatibility with other addons to customize and personalize the game even futher.\n',
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
        ],
      ),
    );
  }
}
