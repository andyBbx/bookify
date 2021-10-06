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
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Center(
                child: Row(
              children: [
                widget.cheapItem.icon.isNotEmpty
                    ? SvgPicture.asset(
                        widget.cheapItem.icon,
                        color: Colors.white,
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.cheapItem.text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )),
            height: 50,
            decoration: BoxDecoration(
              color: textBold,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Center(
                child: Row(
              children: [
                widget.cheapItem.icon.isNotEmpty
                    ? SvgPicture.asset(
                        widget.cheapItem.icon,
                        color: textBold,
                      )
                    : Container(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.cheapItem.text,
                  style: TextStyle(
                      color: textBold,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: textBold,
                )),
          );
  }
}
