import 'package:buzbee/API/registerAPI.dart';

Future<bool> postProfile({
  required String Profile,
  required  context,
}) async {
  try {
    final response = await dio.post(
      '$baseurl/ProfileAPI/$LID',
      // data: {
      //   ,
      // },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }

  } catch (e) {
    print("Error pt: $e");
    return false;
  }
}


Future<List<dynamic>> profile() async {
  try {
    final response = await dio.get('$baseurl/profileAPI/$LID');
print(response.data);
    if (response.statusCode == 200) {
      return response.data; 
    } else {
      return [];
    }
  } catch (e) {
    print("Error viewing profile: $e");
    return [];
  }
}
