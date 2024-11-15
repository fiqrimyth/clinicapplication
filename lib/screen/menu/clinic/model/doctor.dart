// Model untuk data dokter
class Doctor {
  final String name;
  final String specialist;
  final String hospital;
  final String imageUrl;
  final double rating;
  final String description;
  final String locationMapUrl;
  final int excellentCount;
  final int goodCount;
  final int averageCount;
  final int badCount;
  final int tooBadCount;
  final List<Experience> experiences;
  final double consultationPrice;
  final List<Review> reviews;

  Doctor({
    required this.name,
    required this.specialist,
    required this.hospital,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.locationMapUrl,
    required this.excellentCount,
    required this.goodCount,
    required this.averageCount,
    required this.badCount,
    required this.tooBadCount,
    required this.experiences,
    required this.consultationPrice,
    required this.reviews,
  });
}

class Experience {
  final String position;
  final String hospital;

  Experience({
    required this.position,
    required this.hospital,
  });
}

class Review {
  final String userName;
  final String date;
  final String comment;
  final double rating;
  final String userImage;

  Review({
    required this.userName,
    required this.date,
    required this.comment,
    required this.rating,
    required this.userImage,
  });
}
