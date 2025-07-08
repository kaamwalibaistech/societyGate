class ApiConstant {
  static const String baseUrl = "https://thesocietygate.com/api/";
  static const String adminRegister = "mygetapi.php";
  static const String loginApi = "login";
  static const String societyMembersList = "usersbysociety";

  // Visitors API Constants
  static const String visitorsbysocietyAndFlatId =
      "getVisitorsbysocietyandflatid"; // used to fetch visitors for membr, admin
  static const String visitorsbysocietyId =
      "getvisitorsbysocietyid"; //used to fetch visitors for watchmen
  static const String insertVisitor = "insertvisitor";
  static const String getVisitors = "getvisitor";
  static const String deleteVisitor = "deletevisitor";
  static const String aproveVisitor = "approvevisitor";
  static const String editVisitor = "updatevisitor";

  // Shop API Constants
  static const String shopList = "shopslist";
  static const String addShop = "shopsadd";
  static const String updateShop = "shopsupdate";
  static const String deleteShop = "shopsdelete";

  // Announcement API Constants
  static const String getAnnouncements = "getannouncement";
  static const String deleteAnnouncement = "announcementsdelete";

  /// Community API Constants
  static const String getCommunityPosts = "communitypostget";
  static const String deleteCommunityPost = "communitypostdelete";
  static const String getComments = "community_commentget";
  static const String insertComment = "community_commentinsert";
  static const String deleteComment = "community_commentdelete";

  //Amenities API Constants
  static const String createOrderForAmenitiesAmenities = "create-order";
  static const String amenitiesBookbyUser = "amenities-book-by-user";
  static const String storeAccId = "add-razorpay-id"; // Store AccId in database
}
