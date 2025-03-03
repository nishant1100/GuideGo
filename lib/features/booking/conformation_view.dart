import 'package:flutter/material.dart';

class ConfirmationView extends StatefulWidget {
  final String guideName;
  final String guideImage;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String meetupPoint;
  final String pickupType;
  final double totalAmount;

  const ConfirmationView({
    super.key,
    required this.guideName,
    required this.guideImage,
    required this.selectedDate,
    required this.selectedTime,
    required this.meetupPoint,
    required this.pickupType,
    required this.totalAmount,
  });

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  TextEditingController otpController = TextEditingController();
  String selectedPayment = "cash"; // Default payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Payment"),
        backgroundColor: const Color(0xFF9C27B0),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Guide Information
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(widget.guideImage),
                      radius: 30,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.guideName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const Text(
                          "Total estimated tour time: 4 hours",
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 35),

                // Experience Section
      
                detailRow("Tour Start Date","${widget.selectedDate.toLocal()}"),
                detailRow("Tour Start Time", widget.selectedTime.format(context)),
                detailRow("Meetup Point", widget.meetupPoint),
                detailRow("Pickup Type", widget.pickupType),

                const SizedBox(height: 35),

                // Payment Breakdown
                const Divider(color: Colors.white),
                Text("Amount",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 10),
                detailRow("Guide charge", "\NRP ${widget.totalAmount - 5}"),
                detailRow("Estimated Tax", "\NRP 5.00"),
                detailRow("Discount", "\NRP 0.00"),
                detailRow("Total", "\NRP ${widget.totalAmount}",
                    isBold: true),

                const Divider(color: Colors.white),

                const SizedBox(height: 35),

                // Payment Options
                const Text(
                  "Choose Your Payment Option",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                paymentOption("Visa **** **** **** 6745", "visa"),
                paymentOption("97******33 (e-wallet)", "ewallet"),
                paymentOption("Hand pay (Recomended) *cash*", "cash"),

                const SizedBox(height: 40),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text("Edit", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showSuccessModal(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9C27B0),
                        ),
                        child: const Text("Make Payment", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Row to show details
  Widget detailRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // Payment Option Widget
  Widget paymentOption(String title, String value) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedPayment == value ? Colors.blue[100] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selectedPayment == value ? Colors.blue : Colors.grey),
        ),
        child: Row(
          children: [
            Expanded(child: Text(title)),
            Radio(
              value: value,
              groupValue: selectedPayment,
              onChanged: (String? val) {
                setState(() {
                  selectedPayment = val!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Process Payment Function
  // void processPayment() {
  //   if (otpController.text.isEmpty) {
  //     showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //               title: const Text("Error"),
  //               content: const Text("Please enter your OTP"),
  //               actions: [
  //                 TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Text("OK"))
  //               ],
  //             ));
  //     return;
  //   }

  //   // Show success message
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: const Text("Success"),
  //             content: Text("Payment completed via $selectedPayment."),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: const Text("OK"))
  //             ],
  //           ));
  // }
  void showSuccessModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text("Payment Successful"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 10),
            const Text("Your booking has been confirmed."),
            const SizedBox(height: 10),
            Text("Guide: ${widget.guideName}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Total: NRP ${widget.totalAmount}", style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pop(context); // Go back to the previous page
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

}
