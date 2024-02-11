import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:application_a/until/model/mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ComponentsCardOrder extends StatelessWidget {
  const ComponentsCardOrder({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    AppinioSocialShare appinioSocialShare = AppinioSocialShare();
    final GlobalKey genKey = GlobalKey();

    Future<String> takePicture() async {
      try {
        RenderRepaintBoundary boundary =
            genKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

        if (boundary.debugNeedsPaint) {
          await Future.delayed(const Duration(milliseconds: 20));
          return takePicture();
        }

        ui.Image image = await boundary.toImage();
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String directory = appDocDir.path;
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        File imgFile = File('$directory/photo.png');
        await imgFile.writeAsBytes(pngBytes);
        return imgFile.path;
      } catch (e) {
        print('e: $e');
        return '';
      }
    }

    Future<void> shareToFacebook(
      String message,
      List<String> filePaths,
    ) async {
      try {
        print(message);
        print(filePaths);
        // String response = await appinioSocialShare.shareToFacebookStory('962023945511502');
        String response = await appinioSocialShare.shareToFacebook(
          message,
          filePaths,
        );
        print(response);
      } catch (e) {
        print('shareToFacebook: $e');
      }
    }

    Future<void> openUrl({required String track}) async {
      final Uri _url = Uri.parse('https://iship.co.th/track=$track');
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      } else {
        print('Could not launch $_url');
      }
    }

    return RepaintBoundary(
      key: genKey,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.8),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  color: Colors.red,
                  child: Image.network(
                    order.logoMobile,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.trackNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        order.statusName,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Divider(color: Colors.white),
            ),
            Text('จาก: ${order.srcName}', style: const TextStyle(fontSize: 16)),
            Text('ถึง: ${order.dstName}', style: const TextStyle(fontSize: 16)),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      openUrl(track: order.trackNo.toString());
                    },
                    child: Text(
                      'แชร์ไป App อื่น',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Share.shareUri(Uri.parse(
                          'https://app-uat.iship.cloud/print/paperang?order=${order.id}'));
                    },
                    child: Text(
                      'Paperang',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final path = await takePicture();
                      print(path);
                      shareToFacebook(
                        "testShare",
                        [(path.toString())],
                      );
                    },
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
