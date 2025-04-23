import 'dart:convert';
import 'config.dart';  // Import config.dart to use processURL
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gap/result_screen.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;

  late final Future<void> _future;
  CameraController? _cameraController;

  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Stack(
            children: [
              if (_isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _initCameraController(snapshot.data!);

                      return Center(
                        child: CameraPreview(_cameraController!),
                      );
                    } else {
                      return const LinearProgressIndicator();
                    }
                  },
                ),
              Scaffold(
                  appBar: AppBar(
                    title: const Text('Generic Alternative Provider'),
                  ),
                  backgroundColor:
                      _isPermissionGranted ? Colors.transparent : null,
                  body: _isPermissionGranted
                      ? Column(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: _scanImage,
                                  child: const Text('Scan Image'),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: const Text(
                              "Camera Permission Denied",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ))
            ],
          );
        });
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> result(String text) async {
    final navigator = Navigator.of(context);
    if (text.isNotEmpty) {
      var textBody = {"text": text};

      var res = await http.post(Uri.parse(processURL),  // Use processURL here
          headers: {"Content-type": "application/json"},
          body: jsonEncode(textBody));

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ResultScreen(text: res.body.toString()),
        ),
      );
    }
  }

  Future<void> _scanImage() async {
    if (_cameraController == null) return;

    try {
      // Uncomment to take picture and process real image
      // final pictureFile = await _cameraController!.takePicture();
      //
      // final file = File(pictureFile.path);
      // final inputImage = InputImage.fromFile(file);
      // final recognizedText = await textRecognizer.processImage(inputImage);
      //
      // final String text = recognizedText.text;
      //
      // result(text);

      const text =
          "dextromethorphane, cabergoline, abacavir, amylase-papain-carminative-oil, cytosine-arabinoside, cyproheptadine-vit-b1-vit-b2-vit-b6 ";

      result(text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}
