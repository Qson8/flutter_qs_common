import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/rendering.dart';
import 'package:image_pickers/image_pickers.dart';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// 图片

class QSImageUtil {
  /// 截屏图片生成图片流ByteData
  static Future<ByteData> capturePngToByteData(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData _byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return _byteData;
    } catch (e) {
      debugPrint(e);
    }
    return null;
  }

  /// 把图片ByteData写入File，并触发微信分享
  static Future<File> writeAsImageBytes(ByteData data) async {
    ByteData sourceByteData = data;
    Uint8List sourceBytes = sourceByteData.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();

    String storagePath = tempDir.path;
    File file = new File('$storagePath/海报截图.png');

    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsBytesSync(sourceBytes);
    return file;
  }

  /// 图片存储权限处理
  static Future<Null> handlePhotosPermission() async {
    // 判断是否有权限
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    Future<PermissionStatus> permission =
        PermissionHandler().checkPermissionStatus(PermissionGroup.photos);
    if (permission == PermissionStatus.denied) {
      // 无权限的话就显示设置页面
      bool isOpened = await PermissionHandler().openAppSettings();
      debugPrint('无权限');
    }
    PermissionHandler().requestPermissions(<PermissionGroup>[
      PermissionGroup.storage, // 在这里添加需要的权限
    ]);
  }

  /// 保存图片到相册
  static Future<File> saveImageToCamera(ByteData byteData) async {
    await handlePhotosPermission();
    
    Uint8List sourceBytes = byteData.buffer.asUint8List();
    String path = await ImagePickers.saveByteDataImageToGallery(sourceBytes);
    return File(path);
  }

}


/// 复制类 剪贴板
@immutable
class ClipboardData {
  final String text;
  const ClipboardData({this.text});
}

class Clipboard {
  Clipboard._();

  static const String kTextPlain = 'text/plain';

  /// Stores the given clipboard data on the clipboard.
  ///将ClipboardData中的内容复制的粘贴板
  static Future<void> setData(ClipboardData data) async {
    await SystemChannels.platform.invokeMethod<void>(
      'Clipboard.setData',
      <String, dynamic>{
        'text': data.text,
      },
    );
  }
}
