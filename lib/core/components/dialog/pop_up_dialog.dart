import '../../common/routes/navigation.dart';
import '../../constant/constant.dart';
import '../../core.dart';

class PopUpDialog extends StatelessWidget {
  const PopUpDialog({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.blackColor,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('Are you sure ? ',
                style: AppText.text14.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: DefaultButton(
                    title: 'Cancel',
                    onTap: () => Navigation.pop(),
                    backgroundColor: AppColors.greyColor,
                    borderRadius: 8,
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: DefaultButton(
                    title: 'Yes',
                    onTap: onTap,
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
