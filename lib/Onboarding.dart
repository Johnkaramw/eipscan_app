import 'package:eipscan_app/main.dart';
import 'package:eipscan_app/onboarding_page_model.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingPageModel> onboardingPages = [
    OnboardingPageModel(
      imagePath: "assets/images/Health professional team-bro.png",
      title: "Episcan",
      description:
          "Begin your wellness journey today with Episcan, your trusted health partner.",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/Virus-bro.png",
      title: "Early Cancer Screening",
      description:
          "Discover early signs of cancer with simple steps through our screening feature.",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/Time management-pana.png",
      title: "Treatment Alarms",
      description:
          "Receive timely notifications for your treatment schedules, making sure you never miss a dose with our reminder system.",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/Questions-pana.png",
      title: "General Information",
      description:
          "Explore detailed information on 7 types of cancer, understanding the differences and specifics of each to empower your knowledge.",
    )
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 229, 216),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.05, // تقليل المسافة العلوية
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return buildOnboardingPage(onboardingPages[index], context);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20), // تقليل المسافات
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_currentPage != onboardingPages.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child:
                          Text('Next', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                if (_currentPage == onboardingPages.length - 1)
                  _buildButton(
                    label: 'Start Now',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => first()),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage(
      OnboardingPageModel pageModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0), // تقليل البادينغ
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            pageModel.imagePath,
            height: _calculateImageHeight(context),
            width: _calculateImageWidth(context),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20), // تقليل المسافة
          Text(
            pageModel.title,
            style: TextStyle(
              fontSize: 22, // تقليل حجم الخط
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10), // تقليل المسافة
          Text(
            pageModel.description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.grey[600]), // تقليل حجم الخط
          ),
        ],
      ),
    );
  }

  double _calculateImageHeight(BuildContext context) {
    if (_currentPage == 2 || _currentPage == 3) {
      return MediaQuery.of(context).size.height * 0.25; // تقليل ارتفاع الصورة
    } else {
      return MediaQuery.of(context).size.height * 0.35; // تقليل ارتفاع الصورة
    }
  }

  double _calculateImageWidth(BuildContext context) {
    if (_currentPage == 2 || _currentPage == 3) {
      return MediaQuery.of(context).size.width * 0.55; // تقليل عرض الصورة
    } else {
      return MediaQuery.of(context).size.width * 0.75; // تقليل عرض الصورة
    }
  }

  Widget _buildButton(
      {required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 208, 120, 4),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 25, vertical: 10), // تقليل البادينغ
      ),
      child: Text(label, style: TextStyle(fontSize: 14)), // تقليل حجم النص
    );
  }
}
