import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rabbit_go/presentation/widgets/alert_bus_route.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyAlertReportBusRoute extends StatefulWidget {
  final String name, routeId;
  final int price;
  const MyAlertReportBusRoute(
      {Key? key,
      required this.name,
      required this.routeId,
      required this.price})
      : super(key: key);

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
            topStart: Radius.circular(30),
            topEnd: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEDEDED), width: 2),
                    ),
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
                    border: Border.all(color: const Color(0xFFE8E8E8)),
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
                      hintStyle: TextStyle(
                        color: Color(0xFF949494),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                if (_mediaFile != null)
                  _mediaFile!.path.endsWith('.mp4')
                      ? const SizedBox(
                          height: 200,
                          width: 200,
                          child: Icon(Icons.videocam, size: 200),
                        )
                      : Image.file(
                          _mediaFile!,
                          height: 200,
                          width: 200,
                        ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: InkWell(
                    onTap: _pickMedia,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/images/attach_file_add.png',
                          width: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Subir archivo (.jpg,.png,.mp4,.gif)',
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  textButton: 'Realizar reporte',
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 32,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF990404),
                  colorText: const Color(0xFFFFFFFF),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Future.delayed(const Duration(milliseconds: 100), () {
                      showBottomSheet(
                        context: context,
                        builder: (context) => MyAlertBusRoute(
                          name: widget.name,
                          routeId: widget.routeId,
                          price: widget.price,
                        ),
                      );
                    });
                  },
                  textButton: 'Regresar',
                  width: MediaQuery.of(context).size.width * 0.9,
                  border: Border.all(color: const Color(0xFFE8E8E8)),
                  height: 32,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFFFFF),
                  colorText: const Color(0xFF01142B),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
