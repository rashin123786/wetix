//========Base Url ================//

const baseUri = 'http://192.168.43.114:5000';
String? userObjectId;
const itemId = '';
const reviewId = '';

//========Authentication Url================//

const signUpUri = '$baseUri/signup'; //Post
const loginUri = "$baseUri/login"; // Post

//==============Cart Url=======================//

const addToCart = '$baseUri/cart-add'; // POST
const getCartData = '$baseUri/cart'; //GET
const deleteCart = '$baseUri/cart/'; //DELETE
const updateItemQuantity = '$baseUri/cart/update-item-count';

//==============Dashboard Url=======================//

const getDashBoard = '$baseUri/dashboard'; //GET

//================page uri======================//

const getAboutSectionContent = '$baseUri/page-about'; // GET
const getContactSectionContent = '$baseUri/page-contact'; //Get
const getBannerSectionContent = '$baseUri/page-banner'; //Get
const getOtherSectionContent = '$baseUri/page-other'; //Get

//==================Review=====================//
const createReview = '$baseUri/reviews'; // POST
const getAllReviews = '$baseUri/get-reviews'; // GET
const getReviewById = '$baseUri/reviews/$reviewId'; //Get
const updateReviewById = '$baseUri/reviews/$reviewId'; //PUT
const deleteReviewById = '$baseUri/reviews/$reviewId'; // DELETE

//================== Home Page =====================//

const getDashboardInfo = '$baseUri/dashboard';
const getHomepageEvents = '$baseUri/homepage-events'; //Home page All events
const getPastEvents = '$baseUri/getPastEvents';
const getUpcomingEvents = '$baseUri/getUpcomingEvents';
const getLiveEvents = '$baseUri/getLiveEvents';
// ===============create order=============//
const cartOrder = "$baseUri/create-order";
const getCartOrder = "$baseUri/get-order/";

String? tokenss;
