import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/chip_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterChipItem extends StatefulWidget {
  const FilterChipItem({Key? key, required this.cheapItem, required this.func})
      : super(key: key);

  final CheapItem cheapItem;
  final Function func;

  @override
  _FilterChipItemState createState() => _FilterChipItemState();
}

class _FilterChipItemState extends State<FilterChipItem> {
  @override
  Widget build(BuildContext context) {
    return widget.cheapItem.seleted
        ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            // margin: const EdgeInsets.symmetric(
            //   horizontal: 10,

            child: Center(
                child: Row(
              children: [
                // widget.cheapItem.icon.isNotEmpty
                //     ? SvgPicture.asset(
                //         widget.cheapItem.icon,
                //         color: Colors.white,
                //       )
                //     : const SizedBox.shrink(),
                // widget.cheapItem.icon.isNotEmpty
                //     ? const SizedBox(
                //         width: 10,
                //       )
                //     : Container(),
                Text(
                  widget.cheapItem.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )),
            height: 50,
            decoration: BoxDecoration(
              color: textBold,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            // margin: const EdgeInsets.symmetric(
            //   horizontal: 10,
            // ),
            child: Center(
                child: Row(
              children: [
                // widget.cheapItem.icon.isNotEmpty
                //     // ? SvgPicture.asset(
                //     //     widget.cheapItem.icon,
                //     //     color: textBold,
                //     //   )
                //     ? Image.network(widget.cheapItem.icon)
                //     : Container(),
                // widget.cheapItem.icon.isNotEmpty
                //     ? const SizedBox(
                //         width: 10,
                //       )
                //     : Container(),
                Text(
                  widget.cheapItem.text,
                  style: TextStyle(
                      color: textBold,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: textBold,
                )),
          );
  }
}

class FilterChipHour extends StatefulWidget {
  const FilterChipHour({Key? key, required this.cheapItem}) : super(key: key);

  final CheapItem cheapItem;

  @override
  _FilterChipHourState createState() => _FilterChipHourState();
}

class _FilterChipHourState extends State<FilterChipHour> {
  @override
  Widget build(BuildContext context) {
    return widget.cheapItem.seleted
        ? Center(
            child: Text(
            widget.cheapItem.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w300),
          ))
        : Center(
            child: Text(
            widget.cheapItem.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textBold, fontSize: 19, fontWeight: FontWeight.w500),
          ));
  }
}
