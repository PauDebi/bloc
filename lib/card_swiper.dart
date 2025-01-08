import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {

  const CardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: 20,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.45,
        itemBuilder: (BuildContext context, int index) {
          const info = "a";
          const imageUrl = null;

          return Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details', arguments: info),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: const AssetImage('assets/no-image.jpg') as ImageProvider,
                    fit: BoxFit.cover,
                    height: size.height * 0.45, // Ajuste de altura uniforme
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  
  }
}