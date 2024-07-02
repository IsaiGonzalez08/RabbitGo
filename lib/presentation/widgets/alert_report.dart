import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyAlertReportBusRoute extends StatefulWidget {
  final String name;
  const MyAlertReportBusRoute({Key? key, required this.name}) : super(key: key);

  @override
  State<MyAlertReportBusRoute> createState() => _MyAlertReportBusRouteState();
}

class _MyAlertReportBusRouteState extends State<MyAlertReportBusRoute> {
  File? _mediaFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _mediaFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(30), topEnd: Radius.circular(30))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFEDEDED), width: 2)),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/Bus.png', width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            color: Color(0xFF01142B),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text('[Dirección de la ruta].'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF949494)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const TextField(
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                    hintText:
                        'Escribe de manera clara los motivos de tu \ninconformidad.',
                  ),
                ),
              ),
              if (_mediaFile != null)
                _mediaFile!.path.endsWith('.mp4')
                    ? Container(
                        height: 200,
                        width: 200,
                        child: Icon(Icons.videocam, size: 200),
                      )
                    : Image.file(
                        _mediaFile!,
                        height: 200,
                        width: 200,
                      ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickMedia,
                child: Text('Seleccionar Imagen o Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
