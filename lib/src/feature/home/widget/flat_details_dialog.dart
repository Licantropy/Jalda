import 'package:flutter/material.dart';
import 'package:jalda/src/core/localization/localization.dart';
import 'package:jalda/src/core/utils/extensions/num_extensions.dart';
import 'package:jalda/src/feature/app/widget/app_button.dart';
import 'package:jalda/src/feature/home/data/models/flat/flat_model.dart';

class FlatDetailsDialogWidget extends StatefulWidget {
  final FlatModel flat;

  const FlatDetailsDialogWidget({required this.flat, super.key});

  static void show(BuildContext context, FlatModel flat) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => FlatDetailsDialogWidget(flat: flat),
    );
  }

  @override
  State<FlatDetailsDialogWidget> createState() => _FlatDetailsDialogWidgetState();
}

class _FlatDetailsDialogWidgetState extends State<FlatDetailsDialogWidget> {
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  final PageController _pageController = PageController(viewportFraction: 0.85);

  void _pop() => Navigator.pop(context);

  @override
  void dispose() {
    _currentPage.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = Localization.of(context);

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      insetPadding: 20.p,
      shape: RoundedRectangleBorder(borderRadius: 15.r),
      child: Padding(
        padding: 16.vp,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              child: Text(
                widget.flat.status == AvailabilityStatus.free ? localization.free : localization.occupied,
                style: theme.primaryTextTheme.titleLarge?.copyWith(
                  color: widget.flat.status == AvailabilityStatus.free ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (widget.flat.images.isNotEmpty)
              SizedBox(
                height: 250,
                width: double.maxFinite,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.flat.images.length,
                  onPageChanged: (index) => _currentPage.value = index,
                  itemBuilder: (context, index) => Padding(
                    padding: 8.p,
                    child: ClipRRect(borderRadius: 10.r, child: Image.network(widget.flat.images[index].imageUrl, fit: BoxFit.cover)),
                  ),
                ),
              ),
            8.h,
            ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  widget.flat.images.length,
                  (int index) => AnimatedContainer(
                    margin: 2.hp,
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage.value == index ? theme.colorScheme.primary : theme.colorScheme.primary.withOpacity(0.2),
                    ),
                    duration: const Duration(milliseconds: 200),
                  ),
                ),
              ),
            ),
            Padding(
              padding: 16.hp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.h,
                  Text(
                    widget.flat.name,
                    style: theme.primaryTextTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    maxLines: 2,
                  ),
                  5.h,
                  if (widget.flat.description != null)
                    Text(
                      widget.flat.description!,
                      style: theme.primaryTextTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  16.h,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(backgroundColor: Colors.orangeAccent, minRadius: 30, maxRadius: 30),
                      5.w,
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: '${widget.flat.name}\n',
                            children: [
                              TextSpan(text: '${widget.flat.address}\n'),
                              TextSpan(text: localization.floor_rooms(widget.flat.floor, widget.flat.rooms)),
                              // TextSpan(text: 'Этаж:${widget.flat.floor}/Комнат: ${widget.flat.rooms}'),
                            ],
                            style: theme.primaryTextTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.flat.priceDay != null
                            ? localization.price_per_day(widget.flat.priceDay.toString())
                            : localization.price_per_hour(widget.flat.priceHour.toString()),
                        style: theme.primaryTextTheme.titleMedium?.copyWith(color: const Color(0xFF3ECD79), fontSize: 18),
                      ),
                    ],
                  ),
                  16.h,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                        onPressed: _pop,
                        color: Colors.red.shade700,
                        text: localization.close,
                        width: MediaQuery.of(context).size.width * 0.35,
                        textColor: Colors.white,
                        borderRadius: 10,
                      ),
                      AppButton(
                        color: theme.colorScheme.primary,
                        text: localization.request,
                        width: MediaQuery.of(context).size.width * 0.40,
                        textColor: Colors.white,
                        borderRadius: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
