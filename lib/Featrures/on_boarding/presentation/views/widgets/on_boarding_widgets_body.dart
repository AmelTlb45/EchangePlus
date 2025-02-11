import 'package:echange_plus/Featrures/on_boarding/presentation/views/widgets/custom_smooth_page_controller.dart';
import 'package:echange_plus/core/utils/app_assets.dart';
import 'package:echange_plus/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart'; // Pour les icônes SVG

class OnBoardingWidgetBody extends StatefulWidget {
  const OnBoardingWidgetBody({super.key});

  @override
  _OnBoardingWidgetBodyState createState() => _OnBoardingWidgetBodyState();
}

class _OnBoardingWidgetBodyState extends State<OnBoardingWidgetBody> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    List<String> quotes = [
      "Échangez, gagnez, économisez avec Echange + !",
      "Des services à échanger, des points à gagner – Rejoignez Echange + !",
      "Faites des échanges intelligents, boostez vos avantages avec Echange + !"
    ];

    List<String> images = [
      Assets.AssetsImages1,
      Assets.AssetsImages2,
      Assets.AssetsImages3
    ];

    List<String> smallTexts = [
      "Commencez votre expérience et gagnez des récompenses.",
      "Echangez des services en toute simplicité.",
      "Maximisez vos avantages grâce à notre plateforme."
    ];

    return Expanded(
      child: Stack(
        children: [
          // PageView horizontal pour naviguer entre les pages d'images
          PageView.builder(
            controller: _controller,
            scrollDirection:
                Axis.horizontal, // Défilement horizontal entre les pages
            itemCount: images.length,
            itemBuilder: (context, index) {
              return _buildOnboardingPage(
                context,
                screenWidth,
                images[index],
                quotes[index],
                smallTexts[index],  // Passer le petit texte ici
              );
            },
            onPageChanged: _onPageChanged,
          ),
          Positioned(
            bottom: 50,
            left: screenWidth * 0.1,
            child: _buildPageIndicator(),
          ),
          _buildNavigationButton(screenWidth),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(
      BuildContext context, double screenWidth, String image, String quote, String smallText) {
    return SingleChildScrollView(
      // Permet le défilement vertical dans chaque page
      scrollDirection: Axis.vertical, // Défilement vertical
      child: Column(
        children: [
          _buildImageSection(screenWidth, image),
          const SizedBox(height: 5),
          CustomSmoothPageIndecator(controller: _controller),
          const SizedBox(height: 20),
          _buildTextSection(screenWidth, quote),
          const SizedBox(height: 10),
          _buildSmallTextSection(screenWidth, smallText),  // Ajouter le petit texte ici
        ],
      ),
    );
  }

  Widget _buildImageSection(double screenWidth, String image) {
    return Container(
      width: screenWidth,
      height: 380,
      margin: const EdgeInsets.only(bottom: 100),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildTextSection(double screenWidth, String quote) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        quote,
        style: CustomTextStyles.Open500style24.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth > 400 ? 24 : 20,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSmallTextSection(double screenWidth, String smallText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        smallText,
        style: CustomTextStyles.Open500style24.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: screenWidth > 400 ? 14 : 12,
          color: Colors.black54,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 10,
          width: _currentIndex == index ? 25 : 10,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButton(double screenWidth) {
    return Positioned(
      bottom: 20,
      left: screenWidth * 0.1,
      right: screenWidth * 0.1,
      child: GestureDetector(
        onTap: _currentIndex == 2
            ? () {
                // Rediriger l'utilisateur vers la page principale
                Navigator.pushNamed(context, '/home');
              }
            : () {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 55,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 153, 51),
                Color.fromARGB(255, 243, 177, 33),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex != 2)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_right.svg',
                      // ignore: deprecated_member_use
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
                  ),
                Center(
                  child: Text(
                    _currentIndex == 2 ? "Commencer" : "Suivant",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
