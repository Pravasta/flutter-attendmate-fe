import 'package:flutter/material.dart';
import 'package:flutter_attendmate_app/core/extensions/date_time_ext.dart';

import '../../../../core/constant/constant.dart';
import '../../../../data/model/response/attendance_response_model.dart';

class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({super.key, this.history});

  final Attendances? history;

  @override
  Widget build(BuildContext context) {
    final timeCheckIn = history?.checkIn?.toFormattedTimeAMPM() ?? '-';
    final timeCheckOut = history?.checkOut?.toFormattedTimeAMPM() ?? 'now';

    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Text(
                history?.checkIn!.toFormattedDayMonthYear() ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.text14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  '$timeCheckIn - $timeCheckOut',
                  style: AppText.text14.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Divider(
          color: AppColors.whiteSecondaryColor,
        ),
      ],
    );
  }
}
