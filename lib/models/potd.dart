// To parse this JSON data, do
//
//     final potd = potdFromJson(jsonString);

import 'dart:convert';

List<Potd> potdFromJson(String str) => List<Potd>.from(json.decode(str).map((x) => Potd.fromJson(x)));

String potdToJson(List<Potd> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Potd {
    DateTime date;
    String explanation;
    MediaType mediaType;
    ServiceVersion serviceVersion;
    String title;
    String url;
    String? copyright;
    String? hdurl;

    Potd({
        required this.date,
        required this.explanation,
        required this.mediaType,
        required this.serviceVersion,
        required this.title,
        required this.url,
        this.copyright,
        this.hdurl,
    });

    factory Potd.fromJson(Map<String, dynamic> json) => Potd(
        date: DateTime.parse(json["date"]),
        explanation: json["explanation"],
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        serviceVersion: serviceVersionValues.map[json["service_version"]]!,
        title: json["title"],
        url: json["url"],
        copyright: json["copyright"],
        hdurl: json["hdurl"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "explanation": explanation,
        "media_type": mediaTypeValues.reverse[mediaType],
        "service_version": serviceVersionValues.reverse[serviceVersion],
        "title": title,
        "url": url,
        "copyright": copyright,
        "hdurl": hdurl,
    };
}

enum MediaType {
    IMAGE,
    VIDEO
}

final mediaTypeValues = EnumValues({
    "image": MediaType.IMAGE,
    "video": MediaType.VIDEO
});

enum ServiceVersion {
    V1
}

final serviceVersionValues = EnumValues({
    "v1": ServiceVersion.V1
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
