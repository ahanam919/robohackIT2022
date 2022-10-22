import 'package:flutter/material.dart';

class Cause {
  final String causeName;

  const Cause({
    this.causeName,
  });

  factory Cause.fromJson(Map<String, dynamic> json) {
    String causeText = "";
    if (json!=null) {
      causeText=  json['causeName'];
    }
    return Cause(causeName:causeText);
  
  }
}

class RatingImage {
  final String small;
  final String large;

  const RatingImage({this.small, this.large});

  factory RatingImage.fromJson(Map<String, dynamic> json) {
    return RatingImage(
      small: json['small'],
      large: json['large'],
    );
  }
}

class Rating {
  final dynamic score;
  final dynamic rating;
  final RatingImage ratingimage;

  const Rating({this.score, this.rating, this.ratingimage});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
        score: json['score'],
        rating: json['rating'],
        ratingimage: RatingImage.fromJson(json['ratingImage']));
  }
}

class CharityDetail {
  final String charityNavigatorURL;
  final String websiteURL;
  final String tagLine;
  final String charityName;
  final Rating currentRating;
  final Cause cause;

  const CharityDetail({
    this.charityNavigatorURL,
    this.websiteURL,
    this.tagLine,
    this.charityName,
    this.currentRating,
    this.cause,
  });

  factory CharityDetail.fromJson(Map<String, dynamic> json) {
    return CharityDetail(
        charityNavigatorURL: json['charityNavigatorURL'],
        websiteURL: json['websiteURL'],
        tagLine: json['tagLine'],
        charityName: json['charityName'],
        currentRating: Rating.fromJson(json['currentRating']),
        cause: Cause.fromJson(json['cause']));
  }
}
