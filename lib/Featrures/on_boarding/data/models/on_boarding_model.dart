import 'package:echange_plus/core/utils/app_assets.dart';

class OnBoardingModel {
  final String imagePath;
  final String title;
  final String subTitle;

  OnBoardingModel(
      {required this.imagePath, required this.title, required this.subTitle});
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    imagePath: Assets.AssetsImages1,
    title: "Échangez, gagnez, économisez avec Echange + !",
    subTitle: "Commencez votre expérience et gagnez des récompenses.",
   
  ),
  OnBoardingModel(
    imagePath: Assets.AssetsImages2,
    title:
        "Des services à échanger, des points à gagner – Rejoignez Echange + !",
    subTitle: "Echangez des services en toute simplicité.",
  ),
  OnBoardingModel(
    imagePath: Assets.AssetsImages3,
    title:
        "Faites des échanges intelligents, boostez vos avantages avec Echange + !",
    subTitle: "Maximisez vos avantages grâce à notre plateforme.",
  ),
];
