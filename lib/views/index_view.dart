import 'package:ai_object_tracker/core/extensions.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
    Future.wait(
      [availableCameras().then((value) => cameras = value)],
    ).then((_) {
      if ((cameras ?? []).isNotEmpty) {
        _cameraController =
            CameraController(cameras?[0] ?? [][0], ResolutionPreset.medium);
        return;
      }
    });
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
                    color: Colors.blue,
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
            )
          ],
        ),
      ),
    );
  }
}
