abstract class HomeState{}

class HomeInitialState extends HomeState{}

class ChangeBottomState extends HomeState{}

class NewPostState extends HomeState{}

class GetDataLoadingState extends HomeState{}

class GetDataSuccessState extends HomeState{}

class GetDataErrorState extends HomeState{
  final String error;

  GetDataErrorState(this.error);
}

class GetProfileImageSuccessState extends HomeState{}

class GetProfileImageErrorState extends HomeState{}

class GetCoverImageSuccessState extends HomeState{}

class GetCoverImageErrorState extends HomeState{}

class UploadProfileImageSuccessState extends HomeState{}

class UploadProfileImageErrorState extends HomeState{}


