import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChoosePhotoModel extends Cubit<ImageSource> {
  ChoosePhotoModel() : super(ImageSource.gallery);

  change(ImageSource source) {
    emit(source);
  }
}
