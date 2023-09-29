class Music{
  late String name;
  late String id;
  late String image;
  late String duration;
  late String artist;
  late String path;

  Music({
   required this.id,
   required this.name,
   required this.path,
   this.image = "assets/music.png",
   this.duration = "",
    this.artist = "UNKNOWN Artist"
});

  static List<Music> songs = [
    Music(id: "01",name: "GTA SAN ANDREAS",path:"assets/audio.mp3",image: 'assets/gta.jpg'),
    Music(id: "02",name: "Congratulation",path:"assets/cong.mp3"),
    Music(id: "03",name: "Friends",path:"assets/friends.m4a",image: 'assets/friends.jpg'),
    Music(id: "04",name: "Hello",path:"assets/hello.mp3"),
    Music(id: "05",name: "Infinity",path:"assets/infinity.mp3"),
    Music(id: "06",name: "JVLA",path:"assets/jvla.mp3"),
    Music(id: "07",name: "Lovely",path:"assets/lovely.m4a",image: 'assets/images.png'),
    Music(id: "08",name: "Ocean",path:"assets/ocean.mp3"),
    Music(id: "09",name: "Rap God",path:"assets/rapgod.mp3",image: 'assets/em.jpg'),

  ];


}