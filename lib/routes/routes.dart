class TRoutes {

  static const login = '/login';
  static const forgetPassword = '/forget-password/';
  static const resetPassword = '/reset-password';
  static const dashboard = '/dashboard';
  static const media = '/media';

  /// CATEGORY SECTION SCREENS
  static const categories = "/categories";
  static const createCategory = "/category/createCategory";
  static const editCategory = "/editCategory";

  /// BRAND SECTION SCREEN
  static const brands = "/brands";
  static const createBrand = "/createBrand";
  static const editBrand = "/editBrand";

  /// BANNERS
  static const banners = "/banners";
  static const createBanner = "/createBanner";
  static const editBanner = "/editBanner";

  /// PRODUCTS
  static const products = "/products";
  static const createProduct = "/createProducts";
  static const editProduct = "/editProducts";


  /// CUSTOMERS
  static const customers = "/customers";
  static const createCustomers = "/createCustomers";
  static const customerDetails = "/customerDetails";

  /// ORDERS
  static const orders = "/orders";
  static const ordersDetails = "/orderDetails";


  ///SETTINGS & PROFILE
  static const settings = "/settings";
  static const profile = "/profile";

  static List sidebarMenuItems = [
    dashboard,media,categories,brands,banners,products,customers,orders,settings,profile,
  ];

}