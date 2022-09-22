class RatingComponentModel {
  String serviceType;
  String name;
  String image;
  String customerId;
  String providerId;
  String reviewId;
  String review;
  double rating;

  RatingComponentModel(
      {required this.serviceType,
      required this.name,
      required this.image,
      required this.customerId,
      required this.providerId,
      required this.rating,
      required this.review,
      required this.reviewId});
}
