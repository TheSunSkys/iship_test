import 'package:application_a/until/model/mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComponentsCardOrder extends StatelessWidget {
  const ComponentsCardOrder({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {

    return Container(
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
                  onTap: () {},
                  child: Text(
                    'แชร์ไป App อื่น',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Paperang',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
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
    );
  }
}
