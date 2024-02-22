import 'package:movie_app/data/model/trailer.dart';
import 'package:movie_app/domain/entity/trailer_entity.dart';

class TrailerMapping {
  TrailerEntity convert(Trailer trailer) {
    return TrailerEntity(
      id: trailer.id ?? "",
      key: trailer.key ?? "",
      name: trailer.name ?? "",
    );
  }
}
