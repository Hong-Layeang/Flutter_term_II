import 'package:download_app/ui/providers/theme_color_provider.dart';
import 'package:download_app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

import 'download_controller.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;
 

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final result = controller.ressource;
        final currentMB = (controller.progress * result.size).toStringAsFixed(1);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            title: Text(result.name, style: AppTextStyles.label,),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${(controller.progress * 100).toInt()}% completed ($currentMB of ${result.size} MB)"),
                LinearProgressIndicator(value: controller.progress, color: themeProvider.themeColor.color,),
              ],
            ),
            trailing: IconButton(
              icon: Icon(controller.status == DownloadStatus.downloaded ? Icons.check_circle : Icons.download),
              onPressed: controller.status == DownloadStatus.notDownloaded ? controller.startDownload : null,
            ),
          ),
        );
      }
    );
  }
}
