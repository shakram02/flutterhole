import 'dart:math';

import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:pihole_api/pihole_api.dart';

class PiholeRepositoryDemo implements PiholeRepository {
  final _random = Random();

  @override
  Future<PiholeStatus> disable(CancelToken cancelToken) async =>
      const PiholeStatus.disabled();

  @override
  Future<PiholeStatus> enable(CancelToken cancelToken) async =>
      const PiholeStatus.enabled();

  @override
  Future<PiClientActivityOverTime> fetchClientActivityOverTime(
      CancelToken cancelToken) async {
    final j = {
      'clients': [
        {'name': 'localhost', 'ip': '127.0.0.1'},
        {'name': '', 'ip': '10.0.1.2'},
        {'name': '', 'ip': '10.0.1.10'},
        {'name': '', 'ip': '10.0.1.11'},
        {'name': '', 'ip': '10.0.1.1'},
        {'name': '', 'ip': '10.0.1.12'},
        {'name': '', 'ip': '10.0.1.7'},
        {'name': '', 'ip': '10.0.1.17'},
        {'name': '', 'ip': '10.0.1.16'},
        {'name': '', 'ip': '10.0.1.9'},
        {'name': '', 'ip': '10.0.1.19'}
      ],
      'over_time': {
        '1627052700': [9, 12, 2, 0, 0, 0, 0, 5, 60, 0, 105],
        '1627053300': [0, 5, 11, 0, 0, 0, 0, 12, 49, 0, 116],
        '1627053900': [0, 10, 0, 0, 0, 0, 2, 8, 25, 0, 95],
        '1627054500': [0, 10, 13, 0, 0, 0, 0, 19, 13, 0, 78],
        '1627055100': [0, 8, 0, 0, 4, 0, 0, 0, 81, 0, 37],
        '1627055700': [0, 19, 2, 2, 0, 0, 1, 5, 94, 0, 0],
        '1627056300': [10, 7, 19, 0, 0, 0, 0, 0, 85, 0, 0],
        '1627056900': [0, 6, 6, 0, 0, 0, 0, 12, 89, 0, 0],
        '1627057500': [0, 10, 1, 0, 0, 0, 2, 1, 9, 0, 0],
        '1627058100': [0, 26, 1, 0, 0, 0, 0, 5, 13, 0, 0],
        '1627058700': [0, 8, 47, 0, 4, 0, 0, 8, 7, 0, 0],
        '1627059300': [0, 18, 4, 0, 0, 0, 0, 0, 24, 0, 0],
        '1627059900': [10, 6, 0, 0, 0, 0, 0, 5, 0, 0, 0],
        '1627060500': [0, 11, 0, 0, 0, 0, 0, 4, 0, 0, 34],
        '1627061100': [0, 7, 0, 0, 0, 0, 7, 3, 0, 0, 0],
        '1627061700': [0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        '1627062300': [0, 8, 0, 1, 4, 0, 0, 10, 0, 0, 0],
        '1627062900': [0, 13, 14, 0, 0, 0, 0, 21, 27, 0, 0],
        '1627063500': [10, 12, 4, 0, 0, 0, 0, 4, 42, 0, 0],
        '1627064100': [0, 8, 0, 0, 0, 0, 0, 1, 31, 0, 0],
        '1627064700': [0, 14, 0, 0, 0, 0, 2, 0, 3, 0, 0],
        '1627065300': [0, 7, 0, 0, 0, 0, 0, 5, 17, 0, 0],
        '1627065900': [0, 10, 0, 0, 4, 0, 0, 3, 2, 0, 0],
        '1627066500': [0, 14, 37, 0, 0, 1, 0, 14, 39, 0, 0],
        '1627067100': [11, 7, 28, 0, 0, 0, 0, 0, 70, 0, 0],
        '1627067700': [0, 9, 111, 0, 0, 0, 0, 2, 13, 0, 0],
        '1627068300': [0, 13, 57, 2, 0, 0, 2, 5, 95, 0, 0],
        '1627068900': [0, 10, 16, 3, 0, 0, 1, 4, 86, 0, 0],
        '1627069500': [0, 6, 87, 0, 4, 0, 0, 6, 113, 0, 0],
        '1627070100': [0, 21, 29, 0, 0, 0, 0, 10, 146, 0, 0],
        '1627070700': [10, 32, 13, 0, 0, 0, 0, 12, 84, 0, 0],
        '1627071300': [0, 11, 5, 0, 0, 0, 0, 11, 34, 0, 0],
        '1627071900': [0, 7, 9, 0, 0, 0, 7, 6, 37, 0, 0],
        '1627072500': [0, 12, 2, 0, 0, 0, 0, 14, 51, 0, 0],
        '1627073100': [0, 9, 3, 2, 4, 0, 0, 0, 47, 0, 0],
        '1627073700': [0, 12, 7, 0, 0, 0, 0, 7, 119, 0, 0],
        '1627074300': [10, 7, 0, 0, 0, 0, 0, 19, 36, 137, 0],
        '1627074900': [0, 7, 6, 0, 0, 0, 0, 4, 31, 6, 0],
        '1627075500': [0, 8, 8, 0, 0, 0, 2, 7, 17, 5, 0],
        '1627076100': [0, 12, 1, 0, 0, 0, 0, 2, 11, 10, 0],
        '1627076700': [0, 9, 0, 3, 4, 0, 0, 5, 5, 7, 0],
        '1627077300': [0, 17, 1, 0, 0, 0, 0, 2, 54, 8, 0],
        '1627077900': [10, 10, 8, 0, 0, 0, 1, 8, 67, 34, 0],
        '1627078500': [0, 13, 1, 1, 0, 0, 0, 0, 12, 8, 0],
        '1627079100': [0, 0, 3, 0, 0, 0, 2, 1, 21, 5, 0],
        '1627079700': [0, 0, 83, 0, 0, 0, 5, 0, 5, 13, 0],
        '1627080300': [0, 0, 26, 0, 4, 0, 0, 3, 53, 4, 0],
        '1627080900': [0, 0, 26, 0, 0, 0, 0, 4, 31, 0, 0],
        '1627081500': [10, 0, 55, 0, 0, 0, 0, 3, 99, 0, 0],
        '1627082100': [0, 0, 38, 0, 0, 0, 2, 10, 88, 0, 0],
        '1627082700': [0, 0, 25, 1, 0, 0, 3, 0, 4, 0, 0],
        '1627083300': [0, 0, 13, 0, 0, 0, 0, 3, 47, 0, 0],
        '1627083900': [0, 0, 5, 1, 4, 0, 0, 2, 5, 0, 0],
        '1627084500': [0, 0, 77, 0, 0, 0, 1, 3, 23, 0, 0],
        '1627085100': [10, 0, 85, 0, 0, 0, 0, 5, 32, 0, 0],
        '1627085700': [0, 0, 98, 0, 0, 0, 0, 0, 12, 0, 0],
        '1627086300': [0, 0, 62, 0, 0, 0, 3, 11, 6, 0, 0],
        '1627086900': [0, 0, 10, 0, 0, 0, 0, 0, 1, 0, 0],
        '1627087500': [0, 0, 9, 0, 4, 0, 0, 3, 0, 0, 0],
        '1627088100': [0, 0, 9, 0, 0, 0, 0, 2, 0, 0, 0],
        '1627088700': [8, 0, 7, 0, 0, 0, 0, 3, 0, 0, 0],
        '1627089300': [0, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0],
        '1627089900': [0, 0, 8, 0, 0, 0, 2, 9, 0, 0, 0],
        '1627090500': [0, 0, 8, 0, 0, 0, 0, 7, 0, 0, 0],
        '1627091100': [0, 0, 0, 0, 4, 0, 0, 1, 0, 0, 0],
        '1627091700': [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        '1627092300': [7, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0],
        '1627092900': [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0],
        '1627093500': [0, 0, 29, 0, 0, 0, 2, 11, 0, 0, 0],
        '1627094100': [0, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0],
        '1627094700': [0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 0],
        '1627095300': [0, 0, 2, 0, 0, 0, 0, 3, 0, 0, 0],
        '1627095900': [7, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0],
        '1627096500': [0, 0, 1, 0, 0, 0, 1, 3, 0, 0, 0],
        '1627097100': [0, 0, 0, 0, 0, 0, 2, 8, 0, 0, 0],
        '1627097700': [0, 0, 10, 0, 0, 0, 1, 3, 0, 0, 0],
        '1627098300': [0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0],
        '1627098900': [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        '1627099500': [7, 0, 1, 0, 0, 0, 0, 3, 0, 0, 0],
        '1627100100': [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        '1627100700': [0, 0, 23, 0, 0, 0, 2, 7, 0, 0, 0],
        '1627101300': [0, 0, 8, 2, 0, 0, 0, 3, 0, 0, 0],
        '1627101900': [0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0],
        '1627102500': [0, 0, 1, 0, 0, 0, 0, 6, 0, 0, 0],
        '1627103100': [7, 0, 0, 0, 1, 0, 1, 2, 30, 0, 0],
        '1627103700': [0, 0, 16, 0, 0, 0, 0, 2, 20, 0, 0],
        '1627104300': [0, 0, 16, 0, 0, 0, 2, 11, 13, 0, 0],
        '1627104900': [0, 0, 50, 0, 0, 0, 0, 2, 5, 0, 0],
        '1627105500': [0, 0, 22, 4, 4, 0, 1, 0, 4, 0, 0],
        '1627106100': [0, 0, 5, 0, 0, 0, 0, 9, 1, 0, 0],
        '1627106700': [8, 0, 18, 0, 0, 0, 0, 2, 14, 0, 0],
        '1627107300': [0, 0, 19, 0, 0, 0, 0, 7, 5, 0, 0],
        '1627107900': [0, 0, 18, 2, 0, 0, 2, 0, 13, 0, 0],
        '1627108500': [0, 0, 20, 0, 0, 0, 0, 7, 6, 0, 0],
        '1627109100': [0, 0, 10, 0, 4, 0, 0, 2, 1, 0, 0],
        '1627109700': [0, 0, 9, 0, 0, 0, 0, 1, 6, 0, 0],
        '1627110300': [8, 0, 22, 0, 0, 0, 0, 0, 6, 0, 0],
        '1627110900': [0, 0, 91, 0, 0, 0, 0, 4, 20, 0, 0],
        '1627111500': [0, 0, 72, 0, 0, 0, 2, 3, 8, 0, 0],
        '1627112100': [0, 0, 74, 0, 0, 0, 0, 8, 10, 0, 0],
        '1627112700': [0, 0, 44, 0, 4, 0, 0, 9, 4, 0, 0],
        '1627113300': [0, 0, 37, 0, 0, 0, 1, 0, 14, 0, 0],
        '1627113900': [8, 0, 220, 0, 0, 0, 0, 0, 15, 0, 0],
        '1627114500': [0, 0, 189, 1, 0, 0, 0, 4, 2, 0, 0],
        '1627115100': [0, 0, 138, 0, 0, 0, 2, 0, 1, 0, 0],
        '1627115700': [0, 98, 19, 0, 0, 0, 1, 3, 15, 0, 0],
        '1627116300': [0, 27, 9, 1, 4, 0, 0, 15, 140, 0, 0],
        '1627116900': [0, 14, 19, 0, 0, 0, 0, 7, 58, 0, 0],
        '1627117500': [9, 31, 15, 0, 0, 0, 0, 0, 16, 0, 0],
        '1627118100': [0, 26, 18, 0, 0, 0, 0, 6, 20, 0, 0],
        '1627118700': [0, 9, 77, 0, 0, 0, 7, 2, 128, 0, 0],
        '1627119300': [0, 25, 111, 0, 0, 0, 0, 5, 99, 128, 0],
        '1627119900': [0, 8, 24, 0, 4, 0, 0, 4, 50, 5, 0],
        '1627120500': [0, 8, 17, 0, 0, 0, 0, 8, 95, 6, 0],
        '1627121100': [10, 11, 16, 0, 0, 0, 0, 5, 158, 10, 0],
        '1627121700': [0, 10, 13, 0, 0, 0, 0, 4, 121, 5, 0],
        '1627122300': [0, 8, 31, 0, 0, 0, 7, 1, 70, 6, 0],
        '1627122900': [0, 17, 48, 0, 0, 0, 1, 0, 56, 14, 0],
        '1627123500': [0, 9, 13, 0, 4, 0, 0, 13, 74, 6, 0],
        '1627124100': [0, 12, 26, 0, 0, 0, 0, 7, 85, 5, 0],
        '1627124700': [9, 9, 28, 0, 0, 0, 0, 12, 46, 9, 0],
        '1627125300': [0, 12, 19, 0, 0, 0, 0, 1, 42, 5, 0],
        '1627125900': [0, 9, 28, 0, 0, 0, 2, 2, 8, 7, 0],
        '1627126500': [0, 20, 28, 0, 0, 0, 0, 15, 38, 12, 0],
        '1627127100': [0, 9, 18, 1, 4, 0, 0, 0, 5, 5, 0],
        '1627127700': [0, 9, 37, 0, 0, 0, 0, 14, 32, 5, 0],
        '1627128300': [10, 14, 27, 0, 0, 0, 0, 6, 6, 13, 0],
        '1627128900': [0, 8, 14, 0, 0, 0, 0, 4, 190, 6, 0],
        '1627129500': [0, 9, 27, 0, 0, 0, 2, 2, 76, 53, 0],
        '1627130100': [0, 21, 38, 0, 0, 0, 1, 5, 99, 11, 0],
        '1627130700': [0, 12, 115, 0, 4, 0, 0, 4, 30, 8, 0],
        '1627131300': [0, 8, 54, 0, 0, 0, 0, 5, 13, 20, 0],
        '1627131900': [10, 9, 15, 0, 0, 0, 1, 0, 23, 9, 0],
        '1627132500': [0, 9, 32, 0, 0, 0, 0, 18, 24, 5, 0],
        '1627133100': [0, 7, 25, 0, 0, 0, 2, 4, 90, 5, 0],
        '1627133700': [0, 24, 29, 0, 0, 0, 0, 0, 18, 14, 0],
        '1627134300': [0, 10, 14, 0, 4, 0, 0, 7, 154, 9, 0],
        '1627134900': [0, 25, 13, 0, 0, 0, 0, 11, 86, 5, 0],
        '1627135500': [9, 13, 21, 0, 0, 0, 0, 0, 105, 9, 0],
        '1627136100': [0, 7, 83, 0, 0, 0, 0, 16, 51, 5, 0],
        '1627136700': [0, 7, 63, 0, 0, 0, 7, 1, 18, 5, 0],
        '1627137300': [0, 20, 61, 0, 0, 0, 0, 4, 32, 14, 0],
        '1627137900': [0, 14, 12, 1, 4, 0, 0, 13, 3, 6, 0],
        '1627138500': [0, 12, 10, 0, 0, 0, 0, 0, 3, 4, 0]
      }
    };
    final queries = PiClientsOverTimeModel.fromJson(j);
    await Future.delayed(const Duration(seconds: 2));
    return queries.entity;
    return PiClientActivityOverTime(clients: [], activity: {});
  }

  @override
  Future<PiForwardDestinations> fetchForwardDestinations(
      CancelToken cancelToken) async {
    return PiForwardDestinations(destinations: {});
  }

  @override
  Future<PiDetails> fetchPiDetails(CancelToken cancelToken) async {
    // throw 'oh no my man';
    return PiDetails(
        temperature: _random.nextDouble() * 50 + 25,
        cpuLoads: [],
        memoryUsage: _random.nextDouble() * 100);
  }

  int count = 0;
  @override
  Future<PiQueriesOverTime> fetchQueriesOverTime(
      CancelToken cancelToken) async {
    final j = {
      "domains_over_time": {
        "1627139100": 59,
        "1627139700": 82,
        "1627140300": 94,
        "1627140900": 128,
        "1627141500": 80,
        "1627142100": 68,
        "1627142700": 165,
        "1627143300": 69,
        "1627143900": 72,
        "1627144500": 118,
        "1627145100": 103,
        "1627145700": 91,
        "1627146300": 114,
        "1627146900": 56,
        "1627147500": 88,
        "1627148100": 85,
        "1627148700": 60,
        "1627149300": 65,
        "1627149900": 114,
        "1627150500": 53,
        "1627151100": 87,
        "1627151700": 49,
        "1627152300": 85,
        "1627152900": 160,
        "1627153500": 106,
        "1627154100": 121,
        "1627154700": 154,
        "1627155300": 154,
        "1627155900": 233,
        "1627156500": 271,
        "1627157100": 224,
        "1627157700": 230,
        "1627158300": 234,
        "1627158900": 192,
        "1627159500": 210,
        "1627160100": 142,
        "1627160700": 37,
        "1627161300": 29,
        "1627161900": 253,
        "1627162500": 218,
        "1627163100": 186,
        "1627163700": 250,
        "1627164300": 232,
        "1627164900": 185,
        "1627165500": 151,
        "1627166100": 171,
        "1627166700": 194,
        "1627167300": 223,
        "1627167900": 110,
        "1627168500": 289,
        "1627169100": 255,
        "1627169700": 145,
        "1627170300": 129,
        "1627170900": 13,
        "1627171500": 60,
        "1627172100": 7,
        "1627172700": 77,
        "1627173300": 24,
        "1627173900": 30,
        "1627174500": 21,
        "1627175100": 21,
        "1627175700": 6,
        "1627176300": 12,
        "1627176900": 13,
        "1627177500": 16,
        "1627178100": 7,
        "1627178700": 11,
        "1627179300": 4,
        "1627179900": 19,
        "1627180500": 7,
        "1627181100": 17,
        "1627181700": 9,
        "1627182300": 10,
        "1627182900": 3,
        "1627183500": 7,
        "1627184100": 1,
        "1627184700": 39,
        "1627185300": 9,
        "1627185900": 21,
        "1627186500": 7,
        "1627187100": 7,
        "1627187700": 5,
        "1627188300": 15,
        "1627188900": 14,
        "1627189500": 12,
        "1627190100": 14,
        "1627190700": 10,
        "1627191300": 10,
        "1627191900": 7,
        "1627192500": 16,
        "1627193100": 36,
        "1627193700": 9,
        "1627194300": 10,
        "1627194900": 40,
        "1627195500": 58,
        "1627196100": 25,
        "1627196700": 81,
        "1627197300": 28,
        "1627197900": 12,
        "1627198500": 89,
        "1627199100": 195,
        "1627199700": 180,
        "1627200300": 180,
        "1627200900": 213,
        "1627201500": 150,
        "1627202100": 144,
        "1627202700": 159,
        "1627203300": 70,
        "1627203900": 242,
        "1627204500": 106,
        "1627205100": 186,
        "1627205700": 156,
        "1627206300": 185,
        "1627206900": 95,
        "1627207500": 213,
        "1627208100": 117,
        "1627208700": 165,
        "1627209300": 188,
        "1627209900": 227,
        "1627210500": 77,
        "1627211100": 120,
        "1627211700": 163,
        "1627212300": 132,
        "1627212900": 94,
        "1627213500": 122,
        "1627214100": 188,
        "1627214700": 144,
        "1627215300": 129,
        "1627215900": 136,
        "1627216500": 63,
        "1627217100": 46,
        "1627217700": 29,
        "1627218300": 41,
        "1627218900": 114,
        "1627219500": 66,
        "1627220100": 237,
        "1627220700": 68,
        "1627221300": 125,
        "1627221900": 62,
        "1627222500": 92,
        "1627223100": 110,
        "1627223700": 202
      },
      "ads_over_time": {
        "1627139100": 7,
        "1627139700": 13,
        "1627140300": 20,
        "1627140900": 15,
        "1627141500": 12,
        "1627142100": 11,
        "1627142700": 46,
        "1627143300": 25,
        "1627143900": 15,
        "1627144500": 24,
        "1627145100": 29,
        "1627145700": 30,
        "1627146300": 31,
        "1627146900": 14,
        "1627147500": 10,
        "1627148100": 13,
        "1627148700": 7,
        "1627149300": 18,
        "1627149900": 44,
        "1627150500": 19,
        "1627151100": 33,
        "1627151700": 13,
        "1627152300": 25,
        "1627152900": 82,
        "1627153500": 43,
        "1627154100": 22,
        "1627154700": 49,
        "1627155300": 78,
        "1627155900": 105,
        "1627156500": 154,
        "1627157100": 74,
        "1627157700": 71,
        "1627158300": 90,
        "1627158900": 35,
        "1627159500": 32,
        "1627160100": 50,
        "1627160700": 10,
        "1627161300": 6,
        "1627161900": 85,
        "1627162500": 87,
        "1627163100": 58,
        "1627163700": 80,
        "1627164300": 87,
        "1627164900": 75,
        "1627165500": 30,
        "1627166100": 24,
        "1627166700": 50,
        "1627167300": 56,
        "1627167900": 20,
        "1627168500": 133,
        "1627169100": 88,
        "1627169700": 43,
        "1627170300": 47,
        "1627170900": 0,
        "1627171500": 4,
        "1627172100": 1,
        "1627172700": 18,
        "1627173300": 7,
        "1627173900": 2,
        "1627174500": 4,
        "1627175100": 0,
        "1627175700": 0,
        "1627176300": 0,
        "1627176900": 0,
        "1627177500": 1,
        "1627178100": 1,
        "1627178700": 1,
        "1627179300": 0,
        "1627179900": 6,
        "1627180500": 1,
        "1627181100": 0,
        "1627181700": 0,
        "1627182300": 1,
        "1627182900": 0,
        "1627183500": 0,
        "1627184100": 0,
        "1627184700": 3,
        "1627185300": 1,
        "1627185900": 2,
        "1627186500": 2,
        "1627187100": 1,
        "1627187700": 1,
        "1627188300": 0,
        "1627188900": 0,
        "1627189500": 0,
        "1627190100": 1,
        "1627190700": 0,
        "1627191300": 2,
        "1627191900": 0,
        "1627192500": 0,
        "1627193100": 8,
        "1627193700": 3,
        "1627194300": 0,
        "1627194900": 5,
        "1627195500": 13,
        "1627196100": 11,
        "1627196700": 18,
        "1627197300": 6,
        "1627197900": 5,
        "1627198500": 26,
        "1627199100": 63,
        "1627199700": 61,
        "1627200300": 61,
        "1627200900": 59,
        "1627201500": 52,
        "1627202100": 68,
        "1627202700": 47,
        "1627203300": 25,
        "1627203900": 57,
        "1627204500": 40,
        "1627205100": 96,
        "1627205700": 62,
        "1627206300": 101,
        "1627206900": 47,
        "1627207500": 84,
        "1627208100": 41,
        "1627208700": 72,
        "1627209300": 94,
        "1627209900": 45,
        "1627210500": 28,
        "1627211100": 38,
        "1627211700": 53,
        "1627212300": 37,
        "1627212900": 32,
        "1627213500": 34,
        "1627214100": 72,
        "1627214700": 45,
        "1627215300": 44,
        "1627215900": 37,
        "1627216500": 13,
        "1627217100": 2,
        "1627217700": 7,
        "1627218300": 6,
        "1627218900": 18,
        "1627219500": 12,
        "1627220100": 69,
        "1627220700": 11,
        "1627221300": 57,
        "1627221900": 14,
        "1627222500": 11,
        "1627223100": 11,
        "1627223700": 48
      }
    };
    await Future.delayed(Duration(seconds: 2));

    count++;

    if (count % 2 == 0) throw 'nopeee';

    return PiQueriesOverTimeModel.fromJson(j).entity;
  }

  @override
  Future<List<QueryItem>> fetchQueryItems(
      CancelToken cancelToken, int maxResults) async {
    return [];
  }

  @override
  Future<PiQueryTypes> fetchQueryTypes(CancelToken cancelToken) async {
    return PiQueryTypes(types: {});
  }

  int dnsQueriesToday = 50;
  int adsBlockedToday = 3;

  @override
  Future<PiSummary> fetchSummary(CancelToken cancelToken) async {
    await Future.delayed(const Duration(milliseconds: 500));

    dnsQueriesToday += _random.nextInt(10);
    adsBlockedToday += _random.nextInt(5);

    // throw PiholeApiFailure.hostname();

    return PiSummary(
      domainsBeingBlocked: 123456,
      dnsQueriesToday: dnsQueriesToday,
      adsBlockedToday: adsBlockedToday,
      adsPercentageToday: (adsBlockedToday / dnsQueriesToday) * 100,
      uniqueDomains: 5,
      queriesForwarded: 6,
      queriesCached: 7,
      clientsEverSeen: 8,
      uniqueClients: 9,
      dnsQueriesAllTypes: 10,
      replyNoData: 11,
      replyNxDomain: 12,
      replyCName: 13,
      replyIP: 14,
      privacyLevel: 15,
      status: PiholeStatus.enabled(),
    );
  }

  @override
  Future<TopItems> fetchTopItems(CancelToken cancelToken) async {
    return TopItems(topQueries: {}, topAds: {});
  }

  @override
  Future<PiVersions> fetchVersions(CancelToken cancelToken) async {
    return PiVersions(
      hasCoreUpdate: false,
      hasWebUpdate: false,
      hasFtlUpdate: true,
      currentCoreVersion: '1.2.3',
      currentWebVersion: '1.2.3',
      currentFtlVersion: '1.2.3',
      latestCoreVersion: '1.2.3',
      latestWebVersion: '1.2.3',
      latestFtlVersion: '1.3.4',
      coreBranch: 'master',
      webBranch: 'develop',
      ftlBranch: 'master',
    );
  }

  @override
  Future<PiholeStatus> ping(CancelToken cancelToken) async {
    return const PiholeStatus.enabled();
  }

  @override
  Future<PiholeStatus> sleep(Duration duration, CancelToken cancelToken) async {
    return PiholeStatus.sleeping(duration, clock.now());
  }
}
