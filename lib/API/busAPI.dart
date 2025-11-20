import 'package:buzbee/API/registerAPI.dart';



Future<List<dynamic>> fetchbus() async {
  try {
    final response = await dio.get('$baseurl/busAPI/$LID');
print(response.data);
    if (response.statusCode == 200) {
      return response.data; 
    } else {
      return [];
    }
  } catch (e) {
    print("Error fetching bus: $e");
    return [];
  }
}
