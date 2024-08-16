import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APICall extends StatefulWidget {
  @override
  _APICallState createState() => _APICallState();
}

class _APICallState extends State<APICall> {
  final String apiUrl = 'https://api.airtable.com/v0/app7TDeHagnJEtYlz/Details';//apiUrl: URL of the Airtable API where the data will be sent.

  // Controllers for the textfield where the user put input for each in textfield.
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _githubLinkController = TextEditingController();
  final TextEditingController _collegeNameController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _educationCityController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _jobCityController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _languagesController = TextEditingController();

  String result = ''; // To store the result from the API call
  

  //_postData(): This function makes an HTTP POST request to the Airtable API. It sends the data entered by the user to the specified endpoint.
  Future<void> _postData() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer pat703vpKB5Wlg35B.20b7f83d25dcae00c8fb81f71c5c932c1a00a9c32138dc83c206f5e09f82f135',
        },
        //body: The data is encoded to JSON format and sent as the request body.
        body: jsonEncode(<String, dynamic>{
  'fields': {
  'First Name': _firstNameController.text.isNotEmpty ? _firstNameController.text : 'Suman',
  'Middle Name': _middleNameController.text.isNotEmpty ? _middleNameController.text : 'Kumar',
  'Last Name': _lastNameController.text.isNotEmpty ? _lastNameController.text : 'Ghimire',
  'Designation': _designationController.text.isNotEmpty ? _designationController.text : 'Flutter Intern',
  'Summary': _summaryController.text.isNotEmpty ? _summaryController.text : 'This is summary.',
  'Address': _addressController.text.isNotEmpty ? _addressController.text : 'Damak',
  'Email': _emailController.text.isNotEmpty ? _emailController.text : 'Damak',
  'Phone': _phoneController.text.isNotEmpty ? _phoneController.text : '+9779898989898',
  'DOB': _dobController.text.isNotEmpty ? _dobController.text : '2024-08-08',
  'Github Link': _githubLinkController.text.isNotEmpty ? _githubLinkController.text : 'https://github.com/suman', 
  'College Name': _collegeNameController.text.isNotEmpty ? _collegeNameController.text : 'College name goes here',
  'Degree Name': _degreeController.text.isNotEmpty ? _degreeController.text : 'Degree goes here',
  'Education': ['Secondary School', '+2 College', "Bachelor's in Computer Science"],
  'Job Title': _jobTitleController.text.isNotEmpty ? _jobTitleController.text : 'Flutter Developer',
  'Organization': _organizationController.text.isNotEmpty ? _organizationController.text : 'Pracas Infosys',
  'Job City': _jobCityController.text.isNotEmpty ? _jobCityController.text : 'Biratnagar',
  'Job Description': _jobDescriptionController.text.isNotEmpty ? _jobDescriptionController.text : 'Internship in flutter.',
  'Hobbies': _hobbiesController.text.isNotEmpty ? _hobbiesController.text : 'Coding',
  'Languages': ['English', 'Nepali', 'Chinese'],
  'Education City': _educationCityController.text.isNotEmpty ? _educationCityController.text : 'Damak',
}


        }),

      );
      // for response handling of api
      //If the status code is 200, it decodes the JSON response and updates the result to show success.
      //If it fails, an error message is displayed.
      setState(() {
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          result = 'Successfully posted data with ID: ${responseData['id']}';
           ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data posted successfully')),
        );
          print('Data posted successfully');
        } else {
             ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post data: ${response.reasonPhrase}')),
        );
          print('Failed to post data: ${response.statusCode} - ${response.body}');
        }
      });
    } catch (e) {
      setState(() {
        result = 'Error: $e';
        print('Error occurred while posting data: $e');
      });
    }
  }
//appbar display cv info at the top...
//build(): This method builds the UI of the app, rendering all the components including text fields and the submit button.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Info'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 238, 191, 50),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                   Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
              TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: 'First Name')),
              TextField(controller: _middleNameController, decoration: const InputDecoration(labelText: 'Middle Name')),
              TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: 'Last Name')),
              TextField(controller: _designationController, decoration: const InputDecoration(labelText: 'Designation')),
              TextField(controller: _summaryController, decoration: const InputDecoration(labelText: 'Summary')),
              TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone')),
              TextField(controller: _dobController, decoration: const InputDecoration(labelText: 'DOB')),
              TextField(controller: _githubLinkController, decoration: const InputDecoration(labelText: 'Github Link')),
               SizedBox(height: 10),
               Text(
              'Education',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
              TextField(controller: _collegeNameController, decoration: const InputDecoration(labelText: 'College Name')),
              TextField(controller: _degreeController, decoration: const InputDecoration(labelText: 'Degree')),
              TextField(controller: _educationCityController, decoration: const InputDecoration(labelText: 'Education City')),
               SizedBox(height: 10),
                   Text(
              'Experience',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
              TextField(controller: _jobTitleController, decoration: const InputDecoration(labelText: 'Job Title')),
              TextField(controller: _organizationController, decoration: const InputDecoration(labelText: 'Organization')),
              TextField(controller: _jobCityController, decoration: const InputDecoration(labelText: 'Job City')),
              TextField(controller: _jobDescriptionController, decoration: const InputDecoration(labelText: 'Job Description')),
               SizedBox(height: 10),
                   Text(
              'Hobbies',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
              TextField(controller: _hobbiesController, decoration: const InputDecoration(labelText: 'Hobbies')),
               SizedBox(height: 10),
                   Text(
              'languages.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
              TextField(controller: _languagesController, decoration: const InputDecoration(labelText: 'Languages')),
              const SizedBox(height: 10),
ElevatedButton(
  onPressed: _postData,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 104, 240, 108), // Set the background color to green
  ),
  child: const Text('Submit'),
),
const SizedBox(height: 20.0),
Text(result, style: const TextStyle(fontSize: 16.0)),

            ],
          ),
        ),
      ),
    );
       
  }
}
