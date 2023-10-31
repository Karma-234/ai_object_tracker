import 'package:ai_object_tracker/core/extensions.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  List<CameraDescription>? cameras;
  CameraController? _cameraController;
  CameraImage? _cameraImage;
  bool isWorking = false;
  String result = "";
  Future loadModel() async {
    await Tflite.loadModel(
      model: "".lite,
      labels: "".txt,
    );
  }

  void initController() {
    _cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraController?.startImageStream((image) {
          if (!isWorking) {
            isWorking = true;
            _cameraImage = image;
          }
        });
      });
    });
  }

  loadModelOnStream() async {
    if (_cameraImage != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: _cameraImage!.planes.map((plane) => plane.bytes).toList(),
        imageHeight: _cameraImage!.height,
        imageWidth: _cameraImage!.width,
        imageStd: 127.5,
        imageMean: 127.5,
        rotation: 90,
        numResults: 3,
        threshold: 0.1,
        asynch: true,
      );
      recognitions?.forEach((resp) {
        result +=
            "${resp["label"]} ${(resp["confidence"] as double).toStringAsFixed(2)} \n\n";
      });
      setState(() {
        result;
        isWorking = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((value) => Future.wait(
          [availableCameras().then((value) => cameras = value)],
        ).then((_) {
          if ((cameras ?? []).isNotEmpty) {
            _cameraController =
                CameraController(cameras?[0] ?? [][0], ResolutionPreset.medium);
            return;
          }
        }));
  }

  @override
  void dispose() async {
    await Tflite.close();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        bottomSheet: Container(
          height: 50,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.black,
        ),
        body: Column(
          children: [
            _cameraImage == null
                ? Container(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.grey,
                  )
                : AspectRatio(
                    aspectRatio: _cameraController?.value.aspectRatio ?? 0,
                    child: CameraPreview(_cameraController ??
                        CameraController(
                            cameras?[0] ?? [][0], ResolutionPreset.high)),
                  ),
            32.h,
            Center(
              child: GestureDetector(
                onTap: _cameraImage != null
                    ? null
                    : () {
                        initController();
                      },
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
            40.h,
            Text(
              result,
              style: const TextStyle(fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}
