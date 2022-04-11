abstract class HomeState{}

class HomeInitialState extends HomeState{}

class ChangeBottomState extends HomeState{}

class NewPostState extends HomeState{}

//get Data
class GetDataLoadingState extends HomeState{}

class GetDataSuccessState extends HomeState{}

class GetDataErrorState extends HomeState{
  final String error;

  GetDataErrorState(this.error);
}
//profile image
class GetProfileImageSuccessState extends HomeState{}

class GetProfileImageErrorState extends HomeState{}

//cover image
class GetCoverImageSuccessState extends HomeState{}

class GetCoverImageErrorState extends HomeState{}

//upload profile image
class UploadProfileImageSuccessState extends HomeState{}

class UploadProfileImageErrorState extends HomeState{}

//upload cover image
class UploadCoverImageSuccessState extends HomeState{}

class UploadCoverImageErrorState extends HomeState{}

//update data
class UpdateUserErrorState extends HomeState{}

class UpdateUserLoadingState extends HomeState{}

//create post
class CreatePostErrorState extends HomeState{}

class CreatePostSuccessState extends HomeState{}

class CreatePostLoadingState extends HomeState{}



