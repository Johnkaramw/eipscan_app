import 'package:flutter/material.dart';
import 'NameDisease.dart';
import 'NotificationPage.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eipscan_app/InformationDises.dart';
import 'package:eipscan_app/SettingScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  String? _selectedImagePath;
  final List<String> imageUrls = [
    "https://media.istockphoto.com/id/1637354459/photo/ovarian-cancer-cells-closeup-view-3d-illustration.jpg?s=2048x2048&w=is&k=20&c=R9HEVewfbRfz4_VD8T-nKufPFEyENCuKar9IxSoMvXw=",
  ];

  late Timer _timer;
  File? _selectedImage;
  String _predictionResult = '';

  final List<String> classNames = [
    'Actinic keratosis',
    'Basal Cell Carcinoma',
    'Benign Keratosis-like Lesions',
    'Dermatofibroma',
    'Melanoma',
    'Melanocytic Nevi',
    'Vascular Lesions'
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {});
    });
  }

  Future<void> pickImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedImagePath = pickedFile.path;
      });
    } else {
      print('No image selected');
    }
  }

  Future<void> captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedImagePath = pickedFile.path;
      });
    } else {
      print('No image captured');
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) {
      print('Please select an image first!');
      return;
    }

    try {
      var dio = Dio();
      dio.options.connectTimeout = Duration(minutes: 5);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_selectedImage!.path),
      });

      var response =
          await dio.post('http://192.168.1.6:8000/upload', data: formData);

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      } else {
        print('Error uploading image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> predictImage() async {
    if (_selectedImage == null) {
      print('Please select an image first!');
      return;
    }

    try {
      var dio = Dio();
      dio.options.connectTimeout = Duration(minutes: 5);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_selectedImage!.path),
      });

      var response =
          await dio.post('http://192.168.1.6:8000/predict', data: formData);

      if (response.statusCode == 200) {
        var data = response.data;
        setState(() {
          if (data.containsKey('prediction')) {
            _predictionResult = data['prediction'];
          } else if (data.containsKey('error')) {
            _predictionResult = data['error'];
          } else {
            _predictionResult = 'Please enter a valid image for prediction';
          }
        });
      } else {
        print('Error predicting image: ${response.statusCode}');
        setState(() {
          _predictionResult = 'Please enter a valid image for prediction';
        });
      }
    } catch (e) {
      print('Error predicting image: $e');
      setState(() {
        _predictionResult = 'Please enter a valid image for prediction';
      });
    }
  }

  void navigateToInformationPage(String prediction) {
    Widget page;
    switch (prediction) {
      case 'Actinic keratosis':
        page = ActinicKeratosisPage();
        break;
      case 'Basal Cell Carcinoma':
        page = BasalCellCarcinomaPage();
        break;
      case 'Benign Keratosis-like Lesions':
        page = KeratosisisesPage();
        break;
      case 'Dermatofibroma':
        page = DermatofibromaPage();
        break;
      case 'Melanoma':
        page = MelanomaPage();
        break;
      case 'Melanocytic Nevi':
        page = MyHomePage(title: 'Melanocytes');
        break;
      case 'Vascular lesions ':
        page = VascularlesionsPage();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unknown prediction: $prediction')),
        );
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 207, 207),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome to EPISCAN!',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 30.0,
                        color: Color.fromARGB(136, 54, 54, 54),
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  pause: const Duration(milliseconds: 1000),
                ),
                const SizedBox(height: 50),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _selectedImagePath != null &&
                              _selectedImagePath!.isNotEmpty
                          ? FileImage(File(_selectedImagePath!))
                          : NetworkImage(imageUrls[0]) as ImageProvider,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickImageGallery,
                  child: Text(
                    "Pick Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    backgroundColor: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: captureImage,
                  child: Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    backgroundColor: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    uploadImage();
                    predictImage();
                  },
                  child: Text(
                    "Result",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    backgroundColor: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Prediction Result: $_predictionResult',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                if (_predictionResult.isNotEmpty)
                  ElevatedButton(
                    onPressed: () =>
                        navigateToInformationPage(_predictionResult),
                    child: Text(
                      "More Info",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 40)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange;
                        }
                        return Colors.grey;
                      }),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.info, size: 30, color: Colors.white),
          Icon(Icons.alarm, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        animationCurve: Curves.easeInOut,
        color: Color.fromARGB(135, 36, 36, 36),
        backgroundColor: Colors.white,
        onTap: (index) {
          print('Tapped on item $index');
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Firstpage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformationPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
              break;
          }
        },
      ),
    );
  }
}
