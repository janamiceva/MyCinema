import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'location_screen.dart';




class TicketDisplayPage extends StatefulWidget {
  @override
  State<TicketDisplayPage> createState() => _TicketDisplayPageState();
}

class _TicketDisplayPageState extends State<TicketDisplayPage> {
  List<Map<String, dynamic>> tickets = [];

  @override
   void initState() {
    super.initState();
    // Call your function here
    Future.delayed(Duration.zero, () async {
      await getTickets();
    });
  }
  
   Future<void> getTickets() async{
    final currentUser = FirebaseAuth.instance.currentUser;
    final email = currentUser.email;
    if (email == null) {
      print('Error');
    }
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('tickets')
        .orderBy('date', descending: true)
        .get();
    setState(() {
      if (querySnapshot.docs.isNotEmpty) {
        tickets = querySnapshot.docs.map((doc) => doc.data()).toList();
      } else {
        tickets = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
if (tickets.isEmpty) {
    return Scaffold(
      backgroundColor: Color(0xffba68c8),
      appBar: AppBar(
          backgroundColor: Colors.purple.shade300,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          elevation: 4,
          title: Center(
            child: Text(
              'MyCinema',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LocationScreen()),
                );
              },
              icon: Icon(Icons.location_pin),
            ),
            SizedBox(width: 15.0),
          ],
        ),
      body: Center(
        child: Text('No tickets found.',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,)),
      ),
    );
  }
  else
    return Scaffold(
      backgroundColor: Color(0xffba68c8),
      appBar: AppBar(
          backgroundColor: Colors.purple.shade300,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          elevation: 4,
          title: Center(
            child: Text(
              'MyCinema',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LocationScreen()),
                );
              },
              icon: Icon(Icons.location_pin),
            ),
            SizedBox(width: 15.0),
          ],
        ),
     body: SafeArea(
  child: SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          tickets.length,
          (index) {
            final ticket = tickets[index];
            return Container(
              height: size.height * 0.70,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ticket['image']),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFrave(
                              text: 'DATE:',
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            TextFrave(
                              text: ticket['date'],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFrave(
                              text: 'TICKETS',
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            TextFrave(
                              text: ticket['tickets'].toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFrave(
                              text: 'TIME: ',
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            TextFrave(
                              text: ticket['time'],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFrave(
                              text: 'SEATS:',
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            Row(
                              children: List.generate(
                                ticket['selectedSeats'].length,
                                (i) {
                                  return TextFrave(
                                    text: '${ticket['selectedSeats'][i]} ',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      31,
                      (index) => TextFrave(
                        text: '- ',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Image(
                      image: AssetImage('images/qrcode.png'),
                    ),
                  ),
             
                ],
              ),
            );
          },
        ),
      ),
    ),
  ),
),

    );
  }
}