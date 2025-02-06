
//// APP ROUTES SCREEN
class AppScreen{
  static const home = "/";
  static const store = "/store";
  static const favourites = "/favourites";
  static const settings = "/settings";
  static const subCategories = "/sub-categories";
  static const productDetail = "/product-detail";
  static const order = "/order";
  static const checkout = "/checkout";
  static const cart = "/cart";
  static const brand = "/brand";
  static const userProfile = "/user-profile";
  static const userAddress = "/user-address";
  static const onBoarding = "/on-boarding";

  static List<String> allAppScreenItems = [
    onBoarding,
    home,
    store,
    favourites,
    subCategories,
    productDetail,
    order,
    checkout,
    cart,
    brand,
    userAddress,
    userProfile,
    settings,
  ];

}