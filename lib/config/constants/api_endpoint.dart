class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  // static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/register";
  static const String getAllUsers = "user/getAllUsers";
  static const String getCurrentUserId = "user/getCurrentUserId";
  static const String updateUser = "user/updateUser/";
  static const String deleteUser = "user/deleteUser/";
  static const String uploadImage = "user/uploadImage";
  static const String checkUser = "user/checkUser";
  static const String getMe = "user/getMe/";

  static const String addFood = "food/add-food";
  static const String uploadFood = "food/uploadFoodImage";

  static const String createCategory = "category/createCategory";
  static const String getAllCategory = "category/getAllCategories";
  static const String deleteCategory = "category/:id";
  static const String updateCategory = "category/:id";

  static const String getFoodsByCategory = "food/getFoodsByCategory/";
  static const String fetchAllFoods = "food/get-all-foods";
  static const String deleteFood = "food/deleteFood/";
  static const String searchFood = "food/search-food/";
  static const String updateFood = "food/updateFood/";
  static const String getFoodById = "food/getFoodById/";

  static const String getAllCart = "user/getAllCart/";
  static const String addToCart = "user/add-to-cart";
  static const String removeFromCart = "user/remove-from-cart/";
  static const String saveUserAddress = "user/save-user-address";
  static const String order = "user/order";
  static const String orderMe = "user/orderMe";
  static const String deleteOrder = "user/deleteOrder/";

  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String foodimageUrl = "http://10.0.2.2:3000/foodPictures/";
}
