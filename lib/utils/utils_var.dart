import 'package:event_planning/models/user.dart';

final List<String> types = [
  'Type',
  'Desserts',
  'Cooking',
  'Venues',
  'Photographers',
  'Decoration',
  'DJs',
  'Beauty',
  'Invitation card',
  'Flowers',
  'Clothes',
  'Gifts & souvenirs'
      'Car rental',
  'Arada bands'
];
final List<String> vendorTypes = [
  'Desserts',
  'Cooking',
  'Venues',
  'Photographers',
  'Decoration',
  'DJs',
  'Beauty',
  'Invitation card',
  'Flowers',
  'Clothes',
  'Gifts & souvenirs',
  'Car rental',
  'Arada bands'
];
final List<String> locations = [
  'Location',
  'Fahameh',
  'Midan',
  'Mazzeh',
  'Kafrsoseh',
  'Malki',
  'Abo Remanneh',
  'Baramkeh',
  'Shaalan',
  'Dayhet Qudsya',
  'Masaken Barzeh',
  'Mashouaa Dummar',
  'Bab Toumah'
];
final List<String> fromPrices = [
  'From price',
  '5000',
  '10000',
  '50000',
  '100000',
  '500000',
  '1000000',
  '7000000'
];
final List<String> toPrices = [
  'To price',
  '5000',
  '10000',
  '50000',
  '100000',
  '500000',
  '1000000',
  '7000000'
];
final List<String> postType = ['Type', 'Offer', 'Service'];
// final List<String> confirmTimeList = ['Booking confirmation time','One day','Two days','Three days','Four days',
//                                       'Five days','Six days','Seven days'];
final Map<String, int> confirmTimeList = {
  'Booking confirmation time': 0,
  'One day': 1,
  'Two days': 2,
  'Three days': 3,
  'Four days': 4,
  'Five days': 5,
  'Six days': 6,
  'Seven days': 7
};

final Map<int, String> orderStatus = {
  0: 'Pending',
  1: 'In progress',
  2: 'Refuse',
  3: 'Accepted',
  4: 'Finished',
};

const localUrl = "http://10.0.2.2:8000/";
const wifi = 'http://192.168.43.97:8000/';
const wifiMays = 'http://192.168.1.6:8000/';
const apiUrl = wifi;
String theFcm = " ";
int state = 8 ;
int myId = 0;
int selectedId = 0;
// late User user;
