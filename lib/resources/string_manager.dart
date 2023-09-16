// Its String Manager File , Defines all String which are using in app
class StringManager {
  //SplashScreen
  static const myApp = "My Blog";
  static const appTitle = "Welcome to My Blog";

  //Login screen
  static const loginText = "Login";
  static const loginTitle = "Please log in to access your account";
  static const emailHintTxt = "Enter Email";
  static const emailLabelTxt = "Email";
  static const passHintTxt = "Enter Password";
  static const passLabelTxt = "Password";
  static const requiredWarningTxt = "Enter all Filled";
  static const noAccountTxt = "Don't have an account?";

  //SignUp Screen
  static const signUpText = "SignUp";
  static const userHintTxt = "Enter User Name";
  static const userLabelTxt = "User name";
  static const signupTitle = "Create your account to start sharing your thoughts with the world!";
  static const haveAccountTxt = "Already have an account?";

  // Dashboard Screen
  static const portfolioScreen = "Portfolio";
  static const blogScreen = "Blog";
  static const contactUsScreen = "Contact Us";


  //Contact Screen
  static const contactAppBarTxt = "Contact Us";
  static const nameHintTxt = "Enter Your Name";
  static const nameLabelTxt = "Name";
  static const phoneHintTxt = "Enter Phone Number";
  static const phoneLabelTxt = "Phone Number";
  static const descriptionHintTxt = "Enter Description";
  static const descriptionLabelTxt = "Description";
  static const sendMessageBtn = "Send Message";

  //Add Blog Screen
  static const titleHintTxt = "Enter Blog Title";
  static const titleLabelTxt = "Blog Title";
  static const addBlogTxt = "Add Blog";
  static const updateBlogTxt = "Update Blog";

  //Bloggers Profile Screen
  static const updateProfileBtn = "Update Profile";

  //Blog List Screen
  static const helloTxt = "Hello,";
  static const emptyBlogTxt = "No Blog Data";
  static const editTxt = "Edit";
  static const deleteTxt = "Delete";

  // Portfoilo Screen
  static const portfolioAppBarTitle = "Portfolio";
  static const skillTxt = "Skills";
  static const achievementTxt = "Achievements";
  static const projectTxt = "Projects";





}
// Firebase Service String Manager, the string defines the key(which store the data/value) of the database and defines the firebase collection String
class FBServiceManager {
  static const serviceFirebaseNoAccount = "Account doesn't exist";
  static const serviceFbSentSuccess = "Message sent Successfully";
  static const serviceFbUpdateSuccess = "Update Successfully";
  static const serviceFbDeleteSuccess = "Delete Successfully";
  static const serviceFbSentFail = "Message Failed";
  static const dbUser = "users";
  static const dbContactUs = "contactUs";
  static const fbUserName = "user_name";
  static const fbEmail = "email";
  static const fbDescription = "description";
  static const fbPhoneNumber = "phoneNumber";
  static const fbUid = "uid";
  static const fbSkill = "skill";
  static const fbAchievement = "achievement";
  static const fbProject = "project";
}

// Api Service String Manager and key also
class ApiServiceManager {
  static const blogAdd = "Blog add Successfully";
  static const blogUpdate = "Blog update Successfully";
  static const apiTitleKey = "title";
  static const apiDescriptionKey = "description";
  static const apiAuthorKey = "authorId";
  static const apiImageUrlKey = "imageUrl";

}
