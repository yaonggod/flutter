// id가 존재해서 pagination이 가능한 model
abstract class IModelWithId {
  final String id;
  IModelWithId({ required this.id });
}