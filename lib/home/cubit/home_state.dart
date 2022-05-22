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

//get posts
class GetPostsLoadingState extends HomeState{}

class GetPostsSuccessState extends HomeState{}

class GetPostsErrorState extends HomeState{
  final String error;

  GetPostsErrorState(this.error);
}

//get All Users
class GetAllUsersLoadingState extends HomeState{}

class GetAllUsersSuccessState extends HomeState{}

class GetAllUsersErrorState extends HomeState{
  final String error;

  GetAllUsersErrorState(this.error);
}

//like post
class LikePostsSuccessState extends HomeState{}

class LikePostsErrorState extends HomeState{
  final String error;

  LikePostsErrorState(this.error);
}

//comment post
class CommentPostsSuccessState extends HomeState{}

class CommentPostsErrorState extends HomeState{
  final String error;

  CommentPostsErrorState(this.error);
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

class UpdateUserSuccessState extends HomeState{}

class UpdateUserLoadingState extends HomeState{}

//create post
class CreatePostErrorState extends HomeState{}

class CreatePostSuccessState extends HomeState{}

class CreatePostLoadingState extends HomeState{}

//send messages
class SendMessageSuccessState extends HomeState{}

class SendMessageErrorState extends HomeState{}

class GetMessageSuccessState extends HomeState{}

class GetMessageErrorState extends HomeState{}
