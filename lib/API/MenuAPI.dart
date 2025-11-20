import 'package:buzbee/API/registerAPI.dart';


Future<List<dynamic>> fetchMenu() async {
  try {
    final response = await dio.get('$baseurl/_________/$LID');
print(response.data);
    if (response.statusCode == 200) {
      return response.data; 
    } else {
      return [];
    }
  } catch (e) {
    print("Failed to load menu items: $e");
    return [];
  }
}
