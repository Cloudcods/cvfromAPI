import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'codex.dart';

class CvPage extends StatefulWidget {
  const CvPage({super.key});

  @override
  State<CvPage> createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
  late Future<List<Post>> postsFuture;

  @override
  void initState() {
    super.initState();
    postsFuture = getDetails();
  }
//Makes an HTTP GET request to Airtable's API.
  static Future<List<Post>> getDetails() async {
    var url = Uri.parse("https://api.airtable.com/v0/app7TDeHagnJEtYlz/Details");
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer pat703vpKB5Wlg35B.20b7f83d25dcae00c8fb81f71c5c932c1a00a9c32138dc83c206f5e09f82f135",
    });
//If successful (statusCode == 200),
// it decodes the JSON response and maps each record into a Post object using Post.fromJson().
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List records = body['records'];
      return records.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

//appbar for display the cv info.....
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('CV Info'),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 238, 191, 50),
    ),

    //Handling Different States in FutureBuilder
    body: FutureBuilder<List<Post>>(
      future: postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.'));
        }
//displaying the data
//Card and Text: Displays the user's details inside a card with padding and custom styles for text.
//listviewbuilder for the scrolling the list.....
        final posts = snapshot.data!;
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${post.firstName} ${post.middleName} ${post.lastName}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    
                    Text('${post.designation}'),
                    Text('${post.githubLink}'),
                    
                     SizedBox(height:8),
                    Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                        
                Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('DOB: ${post.dob}'),
          Text('Email: ${post.email}'),
          Text('Phone: ${post.phone}'),
          Text('Address: ${post.address}'),
        ],
      ),
    ),
    Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Adds spacing between title and summary
            Text(
              post.summary,
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  ],
),

            SizedBox(height: 8),                   
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Education',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${post.collegeName}'),
                              Text('${post.degreeName}'),
                              Text('${post.educationCity}'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Hobbies',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text('${post.hobbies}', textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 8),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Experience',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${post.jobTitle}'), 
                              Text('${post.organization}'), 
                              Text('${post.jobCity}'), 
                              Text('${post.jobDescription}'), 
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Languages',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                // Display languages as a list, centered
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: post.languages
                                      .map((language) => Text(language, textAlign: TextAlign.center))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  );
}
}