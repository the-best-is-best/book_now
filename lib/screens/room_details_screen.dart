import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/floot_model.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatelessWidget {
  final int house;
  final int floor;
  final RoomsModel room;

  const RoomDetailsScreen({
    required this.house,
    required this.floor,
    required this.room,
  });
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
    final numOfBedController = TextEditingController();

    final myHouseRead = context.read<HousesProvider>();
    final myRoomRead = context.read<RoomsProvider>();
    final myRoomWatch = context.watch<RoomsProvider>();
    final myHouse =
        myHouseRead.myHouses.firstWhere((house) => house.id == this.house);
    return Scaffold(
        appBar: AppBar(
          title: Text("${myHouse.name} - Room  ${room.name}"),
          actions: [
            IconButton(
              icon: myRoomWatch.editRoomActive
                  ? FaIcon(FontAwesomeIcons.eye)
                  : FaIcon(FontAwesomeIcons.edit),
              onPressed: () {
                myRoomRead.inEdit();
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        myRoomWatch.editRoomActive
                            ? Form(
                                key: _keyForm,
                                child: defaultFormField(
                                    context: context,
                                    controller: numOfBedController,
                                    label: 'New number of bed',
                                    type: TextInputType.number,
                                    validate: (String? val) {
                                      if (val != null && val.isNotEmpty) {
                                        return 'empty !!';
                                      }
                                      return null;
                                    }))
                            : Text(
                                "Number of bed : ${room.numbersOfBed}",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
