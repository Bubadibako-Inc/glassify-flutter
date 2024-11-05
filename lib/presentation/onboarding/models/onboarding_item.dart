class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnboardingItem> itemList = [
  OnboardingItem(
    image: 'assets/images/onboarding_1.svg',
    title: 'Temukan Gaya Kamu',
    description:
        'Saatnya upgrade style! Cukup upload foto wajahmu, dan biarkan Glassify nyariin kacamata yang cocok banget sama vibe kamu. Siap tampil kece?',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding_2.svg',
    title: 'Rekomendasi Cerdas',
    description:
        'Nggak perlu pusing milih kacamata! AI kita bakal nge-review wajahmu dan kasih rekomendasi kacamata yang pas. Cuma dalam beberapa detik, kamu bisa tampil lebih stylish!',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding_3.svg',
    title: 'Belanja Tanpa Ribet',
    description:
        'Nikmati belanja kacamata dengan santai! Dengan pilihan yang super variatif dan rekomendasi personal, Glassify bikin kamu gampang banget cari kacamata yang bikin kamu makin keren.',
  ),
];
