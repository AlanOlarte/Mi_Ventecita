import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

enum WidgetState { NONE, LOADING, LOADED, ERROR }

class _CameraScreenState extends State<CameraScreen> {
  int indexCamera = 0;
  WidgetState _widgetState = WidgetState.NONE;
  List<CameraDescription> _cameras;
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final deviceRatio = size.width / size.height;

    switch (_widgetState) {
      case WidgetState.NONE:
      case WidgetState.LOADING:
        return buildScaffold(
            context, Center(child: CircularProgressIndicator()));
      case WidgetState.LOADED:
        return buildScaffold(
            context,
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
        );
      case WidgetState.ERROR:
        return buildScaffold(
            context,
            Center(
                child: Text(
                    "¡Ooops! Error al cargar la cámara 😩. Reinicia la apliación.")));
    }
    return Container();
  }

  Widget buildScaffold(BuildContext context, Widget body) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cámara"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))),
        actions: [
          IconButton(
              icon: Icon(Icons.flip_camera_ios_rounded),
              onPressed: (){
                setState(() {
                  ( indexCamera == 0 )? indexCamera = 1:indexCamera = 0;
                  initializeCamera();
                });
              })
        ],
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            //final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png',);
            final image = await _cameraController.takePicture();
            Navigator.pop(context, image.path);
          } catch (e) {
            print(e);
          }
        },
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> initializeCamera() async {
    _widgetState = WidgetState.LOADING;
    if (mounted) setState(() {});

    _cameras = await availableCameras();

    _cameraController = CameraController(_cameras[indexCamera], ResolutionPreset.high);

    _initializeControllerFuture = _cameraController.initialize();
    // await _cameraController.initialize();

    if (_cameraController.value.hasError) {
      _widgetState = WidgetState.ERROR;
      if (mounted) setState(() {});
    } else {
      _widgetState = WidgetState.LOADED;
      if (mounted) setState(() {});
    }
  }
}