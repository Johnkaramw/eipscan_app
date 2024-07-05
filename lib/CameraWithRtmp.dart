import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraWithRtmp extends StatefulWidget {
  @override
  _CameraWithRtmpState createState() => _CameraWithRtmpState();
}

class _CameraWithRtmpState extends State<CameraWithRtmp> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isCapturing = false; // Added boolean to track capturing state
  XFile? capturedImage; // Initialize capturedImage with null

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    debugShowCheckedModeBanner:
    false;

    // Request camera permission
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      throw CameraException('Camera permission not granted', 'permission');
    }

    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    return _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _takePicture() async {
    if (isCapturing) {
      print('Previous capture has not returned yet.');
      return;
    }

    isCapturing = true;

    try {
      final XFile image = await _controller.takePicture();

      // Save the picture to the device.
      capturedImage = image;

      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures/flutter_test';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${DateTime.now()}.jpg';
      await File(image.path).copy(filePath);

      print('Picture saved to $filePath');
    } catch (e) {
      print('Error taking picture: $e');
    } finally {
      isCapturing = false;
      setState(() {}); // Update the interface to display the captured image
    }
  }

  void _resetCapture() {
    setState(() {
      capturedImage = null; // Reset capturedImage to null
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return (_controller != null && _controller.value.isInitialized)
                    ? CameraPreview(_controller)
                    : Center(child: Text('Camera initialization failed'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          if (capturedImage != null)
            Positioned.fill(
              child: Image.file(
                File(capturedImage!.path),
                fit: BoxFit.cover,
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: capturedImage != null ? _resetCapture : null, // Disable button if no image captured
                    child: Icon(Icons.camera_alt),
                  ),
                  FloatingActionButton(
                    onPressed: _takePicture,
                    child: Icon(Icons.camera),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CameraWithRtmp(),
  ));
}
