
import 'package:flutter/material.dart';
import 'package:proyecto_prueba_1/app/controllers/LrsController.dart';
import 'package:proyecto_prueba_1/app/views/Video/YoutubeApp.dart';

class VideoView extends StatelessWidget{
  const VideoView({super.key});

  void _captureTemplateRecordVideo(){
    LrsController.captureRecordVIdeoTemplate();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){Navigator.pop(context);} , child: const Text("Volver"))
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  YoutubeApp()
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){_captureTemplateRecordVideo();}, child: const Text("Plantilla de statement de video terminado"))
              ],
            )
          ],
        ),
      ),
    );
  }
}