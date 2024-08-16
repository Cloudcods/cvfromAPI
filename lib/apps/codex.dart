class Post {
  //Fields: These are the data members of the class that represent different aspects of a user's information,
  // such as name, education, job details, etc.
  final String dob;
  final String lastName;
  final List<String> education;
  final String firstName;
  final String email;
  final String middleName;
  final String designation;
  final String phone;
  final String address;
  final String summary;
  final String githubLink;
  final String collegeName;
  final String degreeName;
  final String educationCity;
  final String jobTitle;
  final String organization;
  final String jobCity;
  final String jobDescription;
  final String hobbies;
  final List<String> languages;

  Post({
    //Constructor: This is the default constructor for the Post class.
    required this.dob,
    required this.lastName,
    required this.education,
    required this.firstName,
    required this.email,
    required this.middleName,
    required this.designation,
    required this.phone,
    required this.address,
    required this.summary,
    required this.githubLink,
    required this.collegeName,
    required this.degreeName,
    required this.educationCity,
    required this.jobTitle,
    required this.organization,
    required this.jobCity,
    required this.jobDescription,
    required this.hobbies,
    required this.languages,
  });
//fromJson: This factory constructor creates a Post object from a JSON object.
// It takes a map json (key-value pairs of dynamic data) as a parameter.
 factory Post.fromJson(Map<String, dynamic> json) {
  final fields = json['fields'] ?? {};
  return Post(
    dob: fields['DOB'] ?? '',
    lastName: fields['Last Name'] ?? '',
    education: fields['Education'] != null ? List<String>.from(fields['Education']) : [],
    firstName: fields['First Name'] ?? '',
    email: fields['Email'] ?? '',
    middleName: fields['Middle Name'] ?? '',
    designation: fields['Designation'] ?? '',
    phone: fields['Phone'] ?? '',
    address: fields['Address'] ?? '',
    summary: fields['Summary'] ?? '',
    githubLink: fields['Github Link'] ?? '',
    collegeName: fields['College Name'] ?? '',
    degreeName: fields['Degree Name'] ?? '',
    educationCity: fields['Education City'] ?? '',
    jobTitle: fields['Job Title'] ?? '',
    organization: fields['Organization'] ?? '',
    jobCity: fields['Job City'] ?? '',
    jobDescription: fields['Job Description'] ?? '',
    hobbies: fields['Hobbies'] ?? '',
    languages: fields['Languages'] != null ? List<String>.from(fields['Languages']) : [],
  );
}

}