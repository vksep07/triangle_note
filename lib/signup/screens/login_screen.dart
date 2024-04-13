import 'package:flutter/material.dart';
import 'package:plateron_assignment/notes/screens/notes_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countryController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  bool _isNumberValid = false;

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/img1.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Login/Signup",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                getDynamicText(),
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        readOnly: true,
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Enter phone number',
                          // Remove the border outline
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onChanged: (value) {
                          // Remove any non-numeric characters
                          onTextChanged(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        !_isNumberValid ? Colors.grey : Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  NoteScreen()),
                    );
                    // if (_isNumberValid) {
                    //   FocusScope.of(context).unfocus();
                    //   checkUserExistOrNot(mobileNumber: _controller.text);
                    // }
                  },
                  child: const Text(
                    "Send the code",
                    style: TextStyle(
                      color: Colors.white, // Set text color to blue
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onTextChanged(String value) {
    _controller.value = _controller.value.copyWith(
      text: value.replaceAll(RegExp(r'\D'), ''),
      selection: TextSelection.collapsed(offset: value.length),
    );
    // Limit length to 10 digits
    if (_controller.text.length > 10) {
      _controller.text = _controller.text.substring(0, 10);
    }
    setState(() {
      if (_controller.text.length == 10) {
        _isNumberValid = true;
      } else {
        _isNumberValid = false;
      }
    });
  }

  checkUserExistOrNot({required String mobileNumber}) async {}

  getDynamicText() {
    return "Discover skilled professionals and reliable labor for your needs through our  employer app";
  }
}
