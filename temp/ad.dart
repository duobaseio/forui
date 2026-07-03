class BannerAd {
  const BannerAd({required this.imageUrl});

  final String imageUrl;

  factory BannerAd.fromJson(Map<String, dynamic> json) {
    final imageUrl = json['image_url'] ?? json['imageUrl'] ?? json['url'];
    if (imageUrl is! String || imageUrl.isEmpty) {
      throw FormatException('Banner image URL missing', json);
    }
    return BannerAd(imageUrl: imageUrl);
  }
}

const demoBanners = <BannerAd>[
  BannerAd(
    imageUrl:
        'https://dkstatics-public.digikala.com/digikala-adservice-banners/1bfb62262affe6ed2759f1696e28abad0a39c83f_1782732094.jpg?x-oss-process=image/quality,q_80/format,webp',
  ),
  BannerAd(
    imageUrl:
        'https://dkstatics-public.digikala.com/digikala-adservice-banners/2012482b00fa849d9fad31f029e09a35b35bb093_1782221197.jpg?x-oss-process=image/quality,q_80/format,webp',
  ),

];
