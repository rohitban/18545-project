

module pwm_thresholder_16k
(input  logic [9:0] mult_val,
 output logic [12:0] pwm_thresh);

 always_comb begin
    case(mult_val)
       10'h0: pwm_thresh = 13'd0;
       10'h1: pwm_thresh = 13'd6;
       10'h2: pwm_thresh = 13'd12;
       10'h3: pwm_thresh = 13'd18;
       10'h4: pwm_thresh = 13'd24;
       10'h5: pwm_thresh = 13'd30;
       10'h6: pwm_thresh = 13'd36;
       10'h7: pwm_thresh = 13'd42;
       10'h8: pwm_thresh = 13'd48;
       10'h9: pwm_thresh = 13'd54;
       10'ha: pwm_thresh = 13'd61;
       10'hb: pwm_thresh = 13'd67;
       10'hc: pwm_thresh = 13'd73;
       10'hd: pwm_thresh = 13'd79;
       10'he: pwm_thresh = 13'd85;
       10'hf: pwm_thresh = 13'd91;
       10'h10: pwm_thresh = 13'd97;
       10'h11: pwm_thresh = 13'd103;
       10'h12: pwm_thresh = 13'd109;
       10'h13: pwm_thresh = 13'd116;
       10'h14: pwm_thresh = 13'd122;
       10'h15: pwm_thresh = 13'd128;
       10'h16: pwm_thresh = 13'd134;
       10'h17: pwm_thresh = 13'd140;
       10'h18: pwm_thresh = 13'd146;
       10'h19: pwm_thresh = 13'd152;
       10'h1a: pwm_thresh = 13'd158;
       10'h1b: pwm_thresh = 13'd164;
       10'h1c: pwm_thresh = 13'd171;
       10'h1d: pwm_thresh = 13'd177;
       10'h1e: pwm_thresh = 13'd183;
       10'h1f: pwm_thresh = 13'd189;
       10'h20: pwm_thresh = 13'd195;
       10'h21: pwm_thresh = 13'd201;
       10'h22: pwm_thresh = 13'd207;
       10'h23: pwm_thresh = 13'd213;
       10'h24: pwm_thresh = 13'd219;
       10'h25: pwm_thresh = 13'd226;
       10'h26: pwm_thresh = 13'd232;
       10'h27: pwm_thresh = 13'd238;
       10'h28: pwm_thresh = 13'd244;
       10'h29: pwm_thresh = 13'd250;
       10'h2a: pwm_thresh = 13'd256;
       10'h2b: pwm_thresh = 13'd262;
       10'h2c: pwm_thresh = 13'd268;
       10'h2d: pwm_thresh = 13'd274;
       10'h2e: pwm_thresh = 13'd281;
       10'h2f: pwm_thresh = 13'd287;
       10'h30: pwm_thresh = 13'd293;
       10'h31: pwm_thresh = 13'd299;
       10'h32: pwm_thresh = 13'd305;
       10'h33: pwm_thresh = 13'd311;
       10'h34: pwm_thresh = 13'd317;
       10'h35: pwm_thresh = 13'd323;
       10'h36: pwm_thresh = 13'd329;
       10'h37: pwm_thresh = 13'd336;
       10'h38: pwm_thresh = 13'd342;
       10'h39: pwm_thresh = 13'd348;
       10'h3a: pwm_thresh = 13'd354;
       10'h3b: pwm_thresh = 13'd360;
       10'h3c: pwm_thresh = 13'd366;
       10'h3d: pwm_thresh = 13'd372;
       10'h3e: pwm_thresh = 13'd378;
       10'h3f: pwm_thresh = 13'd384;
       10'h40: pwm_thresh = 13'd391;
       10'h41: pwm_thresh = 13'd397;
       10'h42: pwm_thresh = 13'd403;
       10'h43: pwm_thresh = 13'd409;
       10'h44: pwm_thresh = 13'd415;
       10'h45: pwm_thresh = 13'd421;
       10'h46: pwm_thresh = 13'd427;
       10'h47: pwm_thresh = 13'd433;
       10'h48: pwm_thresh = 13'd439;
       10'h49: pwm_thresh = 13'd445;
       10'h4a: pwm_thresh = 13'd452;
       10'h4b: pwm_thresh = 13'd458;
       10'h4c: pwm_thresh = 13'd464;
       10'h4d: pwm_thresh = 13'd470;
       10'h4e: pwm_thresh = 13'd476;
       10'h4f: pwm_thresh = 13'd482;
       10'h50: pwm_thresh = 13'd488;
       10'h51: pwm_thresh = 13'd494;
       10'h52: pwm_thresh = 13'd500;
       10'h53: pwm_thresh = 13'd507;
       10'h54: pwm_thresh = 13'd513;
       10'h55: pwm_thresh = 13'd519;
       10'h56: pwm_thresh = 13'd525;
       10'h57: pwm_thresh = 13'd531;
       10'h58: pwm_thresh = 13'd537;
       10'h59: pwm_thresh = 13'd543;
       10'h5a: pwm_thresh = 13'd549;
       10'h5b: pwm_thresh = 13'd555;
       10'h5c: pwm_thresh = 13'd562;
       10'h5d: pwm_thresh = 13'd568;
       10'h5e: pwm_thresh = 13'd574;
       10'h5f: pwm_thresh = 13'd580;
       10'h60: pwm_thresh = 13'd586;
       10'h61: pwm_thresh = 13'd592;
       10'h62: pwm_thresh = 13'd598;
       10'h63: pwm_thresh = 13'd604;
       10'h64: pwm_thresh = 13'd610;
       10'h65: pwm_thresh = 13'd617;
       10'h66: pwm_thresh = 13'd623;
       10'h67: pwm_thresh = 13'd629;
       10'h68: pwm_thresh = 13'd635;
       10'h69: pwm_thresh = 13'd641;
       10'h6a: pwm_thresh = 13'd647;
       10'h6b: pwm_thresh = 13'd653;
       10'h6c: pwm_thresh = 13'd659;
       10'h6d: pwm_thresh = 13'd665;
       10'h6e: pwm_thresh = 13'd672;
       10'h6f: pwm_thresh = 13'd678;
       10'h70: pwm_thresh = 13'd684;
       10'h71: pwm_thresh = 13'd690;
       10'h72: pwm_thresh = 13'd696;
       10'h73: pwm_thresh = 13'd702;
       10'h74: pwm_thresh = 13'd708;
       10'h75: pwm_thresh = 13'd714;
       10'h76: pwm_thresh = 13'd720;
       10'h77: pwm_thresh = 13'd727;
       10'h78: pwm_thresh = 13'd733;
       10'h79: pwm_thresh = 13'd739;
       10'h7a: pwm_thresh = 13'd745;
       10'h7b: pwm_thresh = 13'd751;
       10'h7c: pwm_thresh = 13'd757;
       10'h7d: pwm_thresh = 13'd763;
       10'h7e: pwm_thresh = 13'd769;
       10'h7f: pwm_thresh = 13'd775;
       10'h80: pwm_thresh = 13'd782;
       10'h81: pwm_thresh = 13'd788;
       10'h82: pwm_thresh = 13'd794;
       10'h83: pwm_thresh = 13'd800;
       10'h84: pwm_thresh = 13'd806;
       10'h85: pwm_thresh = 13'd812;
       10'h86: pwm_thresh = 13'd818;
       10'h87: pwm_thresh = 13'd824;
       10'h88: pwm_thresh = 13'd830;
       10'h89: pwm_thresh = 13'd836;
       10'h8a: pwm_thresh = 13'd843;
       10'h8b: pwm_thresh = 13'd849;
       10'h8c: pwm_thresh = 13'd855;
       10'h8d: pwm_thresh = 13'd861;
       10'h8e: pwm_thresh = 13'd867;
       10'h8f: pwm_thresh = 13'd873;
       10'h90: pwm_thresh = 13'd879;
       10'h91: pwm_thresh = 13'd885;
       10'h92: pwm_thresh = 13'd891;
       10'h93: pwm_thresh = 13'd898;
       10'h94: pwm_thresh = 13'd904;
       10'h95: pwm_thresh = 13'd910;
       10'h96: pwm_thresh = 13'd916;
       10'h97: pwm_thresh = 13'd922;
       10'h98: pwm_thresh = 13'd928;
       10'h99: pwm_thresh = 13'd934;
       10'h9a: pwm_thresh = 13'd940;
       10'h9b: pwm_thresh = 13'd946;
       10'h9c: pwm_thresh = 13'd953;
       10'h9d: pwm_thresh = 13'd959;
       10'h9e: pwm_thresh = 13'd965;
       10'h9f: pwm_thresh = 13'd971;
       10'ha0: pwm_thresh = 13'd977;
       10'ha1: pwm_thresh = 13'd983;
       10'ha2: pwm_thresh = 13'd989;
       10'ha3: pwm_thresh = 13'd995;
       10'ha4: pwm_thresh = 13'd1001;
       10'ha5: pwm_thresh = 13'd1008;
       10'ha6: pwm_thresh = 13'd1014;
       10'ha7: pwm_thresh = 13'd1020;
       10'ha8: pwm_thresh = 13'd1026;
       10'ha9: pwm_thresh = 13'd1032;
       10'haa: pwm_thresh = 13'd1038;
       10'hab: pwm_thresh = 13'd1044;
       10'hac: pwm_thresh = 13'd1050;
       10'had: pwm_thresh = 13'd1056;
       10'hae: pwm_thresh = 13'd1063;
       10'haf: pwm_thresh = 13'd1069;
       10'hb0: pwm_thresh = 13'd1075;
       10'hb1: pwm_thresh = 13'd1081;
       10'hb2: pwm_thresh = 13'd1087;
       10'hb3: pwm_thresh = 13'd1093;
       10'hb4: pwm_thresh = 13'd1099;
       10'hb5: pwm_thresh = 13'd1105;
       10'hb6: pwm_thresh = 13'd1111;
       10'hb7: pwm_thresh = 13'd1118;
       10'hb8: pwm_thresh = 13'd1124;
       10'hb9: pwm_thresh = 13'd1130;
       10'hba: pwm_thresh = 13'd1136;
       10'hbb: pwm_thresh = 13'd1142;
       10'hbc: pwm_thresh = 13'd1148;
       10'hbd: pwm_thresh = 13'd1154;
       10'hbe: pwm_thresh = 13'd1160;
       10'hbf: pwm_thresh = 13'd1166;
       10'hc0: pwm_thresh = 13'd1173;
       10'hc1: pwm_thresh = 13'd1179;
       10'hc2: pwm_thresh = 13'd1185;
       10'hc3: pwm_thresh = 13'd1191;
       10'hc4: pwm_thresh = 13'd1197;
       10'hc5: pwm_thresh = 13'd1203;
       10'hc6: pwm_thresh = 13'd1209;
       10'hc7: pwm_thresh = 13'd1215;
       10'hc8: pwm_thresh = 13'd1221;
       10'hc9: pwm_thresh = 13'd1228;
       10'hca: pwm_thresh = 13'd1234;
       10'hcb: pwm_thresh = 13'd1240;
       10'hcc: pwm_thresh = 13'd1246;
       10'hcd: pwm_thresh = 13'd1252;
       10'hce: pwm_thresh = 13'd1258;
       10'hcf: pwm_thresh = 13'd1264;
       10'hd0: pwm_thresh = 13'd1270;
       10'hd1: pwm_thresh = 13'd1276;
       10'hd2: pwm_thresh = 13'd1282;
       10'hd3: pwm_thresh = 13'd1289;
       10'hd4: pwm_thresh = 13'd1295;
       10'hd5: pwm_thresh = 13'd1301;
       10'hd6: pwm_thresh = 13'd1307;
       10'hd7: pwm_thresh = 13'd1313;
       10'hd8: pwm_thresh = 13'd1319;
       10'hd9: pwm_thresh = 13'd1325;
       10'hda: pwm_thresh = 13'd1331;
       10'hdb: pwm_thresh = 13'd1337;
       10'hdc: pwm_thresh = 13'd1344;
       10'hdd: pwm_thresh = 13'd1350;
       10'hde: pwm_thresh = 13'd1356;
       10'hdf: pwm_thresh = 13'd1362;
       10'he0: pwm_thresh = 13'd1368;
       10'he1: pwm_thresh = 13'd1374;
       10'he2: pwm_thresh = 13'd1380;
       10'he3: pwm_thresh = 13'd1386;
       10'he4: pwm_thresh = 13'd1392;
       10'he5: pwm_thresh = 13'd1399;
       10'he6: pwm_thresh = 13'd1405;
       10'he7: pwm_thresh = 13'd1411;
       10'he8: pwm_thresh = 13'd1417;
       10'he9: pwm_thresh = 13'd1423;
       10'hea: pwm_thresh = 13'd1429;
       10'heb: pwm_thresh = 13'd1435;
       10'hec: pwm_thresh = 13'd1441;
       10'hed: pwm_thresh = 13'd1447;
       10'hee: pwm_thresh = 13'd1454;
       10'hef: pwm_thresh = 13'd1460;
       10'hf0: pwm_thresh = 13'd1466;
       10'hf1: pwm_thresh = 13'd1472;
       10'hf2: pwm_thresh = 13'd1478;
       10'hf3: pwm_thresh = 13'd1484;
       10'hf4: pwm_thresh = 13'd1490;
       10'hf5: pwm_thresh = 13'd1496;
       10'hf6: pwm_thresh = 13'd1502;
       10'hf7: pwm_thresh = 13'd1509;
       10'hf8: pwm_thresh = 13'd1515;
       10'hf9: pwm_thresh = 13'd1521;
       10'hfa: pwm_thresh = 13'd1527;
       10'hfb: pwm_thresh = 13'd1533;
       10'hfc: pwm_thresh = 13'd1539;
       10'hfd: pwm_thresh = 13'd1545;
       10'hfe: pwm_thresh = 13'd1551;
       10'hff: pwm_thresh = 13'd1557;
       10'h100: pwm_thresh = 13'd1564;
       10'h101: pwm_thresh = 13'd1570;
       10'h102: pwm_thresh = 13'd1576;
       10'h103: pwm_thresh = 13'd1582;
       10'h104: pwm_thresh = 13'd1588;
       10'h105: pwm_thresh = 13'd1594;
       10'h106: pwm_thresh = 13'd1600;
       10'h107: pwm_thresh = 13'd1606;
       10'h108: pwm_thresh = 13'd1612;
       10'h109: pwm_thresh = 13'd1619;
       10'h10a: pwm_thresh = 13'd1625;
       10'h10b: pwm_thresh = 13'd1631;
       10'h10c: pwm_thresh = 13'd1637;
       10'h10d: pwm_thresh = 13'd1643;
       10'h10e: pwm_thresh = 13'd1649;
       10'h10f: pwm_thresh = 13'd1655;
       10'h110: pwm_thresh = 13'd1661;
       10'h111: pwm_thresh = 13'd1667;
       10'h112: pwm_thresh = 13'd1673;
       10'h113: pwm_thresh = 13'd1680;
       10'h114: pwm_thresh = 13'd1686;
       10'h115: pwm_thresh = 13'd1692;
       10'h116: pwm_thresh = 13'd1698;
       10'h117: pwm_thresh = 13'd1704;
       10'h118: pwm_thresh = 13'd1710;
       10'h119: pwm_thresh = 13'd1716;
       10'h11a: pwm_thresh = 13'd1722;
       10'h11b: pwm_thresh = 13'd1728;
       10'h11c: pwm_thresh = 13'd1735;
       10'h11d: pwm_thresh = 13'd1741;
       10'h11e: pwm_thresh = 13'd1747;
       10'h11f: pwm_thresh = 13'd1753;
       10'h120: pwm_thresh = 13'd1759;
       10'h121: pwm_thresh = 13'd1765;
       10'h122: pwm_thresh = 13'd1771;
       10'h123: pwm_thresh = 13'd1777;
       10'h124: pwm_thresh = 13'd1783;
       10'h125: pwm_thresh = 13'd1790;
       10'h126: pwm_thresh = 13'd1796;
       10'h127: pwm_thresh = 13'd1802;
       10'h128: pwm_thresh = 13'd1808;
       10'h129: pwm_thresh = 13'd1814;
       10'h12a: pwm_thresh = 13'd1820;
       10'h12b: pwm_thresh = 13'd1826;
       10'h12c: pwm_thresh = 13'd1832;
       10'h12d: pwm_thresh = 13'd1838;
       10'h12e: pwm_thresh = 13'd1845;
       10'h12f: pwm_thresh = 13'd1851;
       10'h130: pwm_thresh = 13'd1857;
       10'h131: pwm_thresh = 13'd1863;
       10'h132: pwm_thresh = 13'd1869;
       10'h133: pwm_thresh = 13'd1875;
       10'h134: pwm_thresh = 13'd1881;
       10'h135: pwm_thresh = 13'd1887;
       10'h136: pwm_thresh = 13'd1893;
       10'h137: pwm_thresh = 13'd1900;
       10'h138: pwm_thresh = 13'd1906;
       10'h139: pwm_thresh = 13'd1912;
       10'h13a: pwm_thresh = 13'd1918;
       10'h13b: pwm_thresh = 13'd1924;
       10'h13c: pwm_thresh = 13'd1930;
       10'h13d: pwm_thresh = 13'd1936;
       10'h13e: pwm_thresh = 13'd1942;
       10'h13f: pwm_thresh = 13'd1948;
       10'h140: pwm_thresh = 13'd1955;
       10'h141: pwm_thresh = 13'd1961;
       10'h142: pwm_thresh = 13'd1967;
       10'h143: pwm_thresh = 13'd1973;
       10'h144: pwm_thresh = 13'd1979;
       10'h145: pwm_thresh = 13'd1985;
       10'h146: pwm_thresh = 13'd1991;
       10'h147: pwm_thresh = 13'd1997;
       10'h148: pwm_thresh = 13'd2003;
       10'h149: pwm_thresh = 13'd2010;
       10'h14a: pwm_thresh = 13'd2016;
       10'h14b: pwm_thresh = 13'd2022;
       10'h14c: pwm_thresh = 13'd2028;
       10'h14d: pwm_thresh = 13'd2034;
       10'h14e: pwm_thresh = 13'd2040;
       10'h14f: pwm_thresh = 13'd2046;
       10'h150: pwm_thresh = 13'd2052;
       10'h151: pwm_thresh = 13'd2058;
       10'h152: pwm_thresh = 13'd2065;
       10'h153: pwm_thresh = 13'd2071;
       10'h154: pwm_thresh = 13'd2077;
       10'h155: pwm_thresh = 13'd2083;
       10'h156: pwm_thresh = 13'd2089;
       10'h157: pwm_thresh = 13'd2095;
       10'h158: pwm_thresh = 13'd2101;
       10'h159: pwm_thresh = 13'd2107;
       10'h15a: pwm_thresh = 13'd2113;
       10'h15b: pwm_thresh = 13'd2119;
       10'h15c: pwm_thresh = 13'd2126;
       10'h15d: pwm_thresh = 13'd2132;
       10'h15e: pwm_thresh = 13'd2138;
       10'h15f: pwm_thresh = 13'd2144;
       10'h160: pwm_thresh = 13'd2150;
       10'h161: pwm_thresh = 13'd2156;
       10'h162: pwm_thresh = 13'd2162;
       10'h163: pwm_thresh = 13'd2168;
       10'h164: pwm_thresh = 13'd2174;
       10'h165: pwm_thresh = 13'd2181;
       10'h166: pwm_thresh = 13'd2187;
       10'h167: pwm_thresh = 13'd2193;
       10'h168: pwm_thresh = 13'd2199;
       10'h169: pwm_thresh = 13'd2205;
       10'h16a: pwm_thresh = 13'd2211;
       10'h16b: pwm_thresh = 13'd2217;
       10'h16c: pwm_thresh = 13'd2223;
       10'h16d: pwm_thresh = 13'd2229;
       10'h16e: pwm_thresh = 13'd2236;
       10'h16f: pwm_thresh = 13'd2242;
       10'h170: pwm_thresh = 13'd2248;
       10'h171: pwm_thresh = 13'd2254;
       10'h172: pwm_thresh = 13'd2260;
       10'h173: pwm_thresh = 13'd2266;
       10'h174: pwm_thresh = 13'd2272;
       10'h175: pwm_thresh = 13'd2278;
       10'h176: pwm_thresh = 13'd2284;
       10'h177: pwm_thresh = 13'd2291;
       10'h178: pwm_thresh = 13'd2297;
       10'h179: pwm_thresh = 13'd2303;
       10'h17a: pwm_thresh = 13'd2309;
       10'h17b: pwm_thresh = 13'd2315;
       10'h17c: pwm_thresh = 13'd2321;
       10'h17d: pwm_thresh = 13'd2327;
       10'h17e: pwm_thresh = 13'd2333;
       10'h17f: pwm_thresh = 13'd2339;
       10'h180: pwm_thresh = 13'd2346;
       10'h181: pwm_thresh = 13'd2352;
       10'h182: pwm_thresh = 13'd2358;
       10'h183: pwm_thresh = 13'd2364;
       10'h184: pwm_thresh = 13'd2370;
       10'h185: pwm_thresh = 13'd2376;
       10'h186: pwm_thresh = 13'd2382;
       10'h187: pwm_thresh = 13'd2388;
       10'h188: pwm_thresh = 13'd2394;
       10'h189: pwm_thresh = 13'd2401;
       10'h18a: pwm_thresh = 13'd2407;
       10'h18b: pwm_thresh = 13'd2413;
       10'h18c: pwm_thresh = 13'd2419;
       10'h18d: pwm_thresh = 13'd2425;
       10'h18e: pwm_thresh = 13'd2431;
       10'h18f: pwm_thresh = 13'd2437;
       10'h190: pwm_thresh = 13'd2443;
       10'h191: pwm_thresh = 13'd2449;
       10'h192: pwm_thresh = 13'd2456;
       10'h193: pwm_thresh = 13'd2462;
       10'h194: pwm_thresh = 13'd2468;
       10'h195: pwm_thresh = 13'd2474;
       10'h196: pwm_thresh = 13'd2480;
       10'h197: pwm_thresh = 13'd2486;
       10'h198: pwm_thresh = 13'd2492;
       10'h199: pwm_thresh = 13'd2498;
       10'h19a: pwm_thresh = 13'd2504;
       10'h19b: pwm_thresh = 13'd2510;
       10'h19c: pwm_thresh = 13'd2517;
       10'h19d: pwm_thresh = 13'd2523;
       10'h19e: pwm_thresh = 13'd2529;
       10'h19f: pwm_thresh = 13'd2535;
       10'h1a0: pwm_thresh = 13'd2541;
       10'h1a1: pwm_thresh = 13'd2547;
       10'h1a2: pwm_thresh = 13'd2553;
       10'h1a3: pwm_thresh = 13'd2559;
       10'h1a4: pwm_thresh = 13'd2565;
       10'h1a5: pwm_thresh = 13'd2572;
       10'h1a6: pwm_thresh = 13'd2578;
       10'h1a7: pwm_thresh = 13'd2584;
       10'h1a8: pwm_thresh = 13'd2590;
       10'h1a9: pwm_thresh = 13'd2596;
       10'h1aa: pwm_thresh = 13'd2602;
       10'h1ab: pwm_thresh = 13'd2608;
       10'h1ac: pwm_thresh = 13'd2614;
       10'h1ad: pwm_thresh = 13'd2620;
       10'h1ae: pwm_thresh = 13'd2627;
       10'h1af: pwm_thresh = 13'd2633;
       10'h1b0: pwm_thresh = 13'd2639;
       10'h1b1: pwm_thresh = 13'd2645;
       10'h1b2: pwm_thresh = 13'd2651;
       10'h1b3: pwm_thresh = 13'd2657;
       10'h1b4: pwm_thresh = 13'd2663;
       10'h1b5: pwm_thresh = 13'd2669;
       10'h1b6: pwm_thresh = 13'd2675;
       10'h1b7: pwm_thresh = 13'd2682;
       10'h1b8: pwm_thresh = 13'd2688;
       10'h1b9: pwm_thresh = 13'd2694;
       10'h1ba: pwm_thresh = 13'd2700;
       10'h1bb: pwm_thresh = 13'd2706;
       10'h1bc: pwm_thresh = 13'd2712;
       10'h1bd: pwm_thresh = 13'd2718;
       10'h1be: pwm_thresh = 13'd2724;
       10'h1bf: pwm_thresh = 13'd2730;
       10'h1c0: pwm_thresh = 13'd2737;
       10'h1c1: pwm_thresh = 13'd2743;
       10'h1c2: pwm_thresh = 13'd2749;
       10'h1c3: pwm_thresh = 13'd2755;
       10'h1c4: pwm_thresh = 13'd2761;
       10'h1c5: pwm_thresh = 13'd2767;
       10'h1c6: pwm_thresh = 13'd2773;
       10'h1c7: pwm_thresh = 13'd2779;
       10'h1c8: pwm_thresh = 13'd2785;
       10'h1c9: pwm_thresh = 13'd2792;
       10'h1ca: pwm_thresh = 13'd2798;
       10'h1cb: pwm_thresh = 13'd2804;
       10'h1cc: pwm_thresh = 13'd2810;
       10'h1cd: pwm_thresh = 13'd2816;
       10'h1ce: pwm_thresh = 13'd2822;
       10'h1cf: pwm_thresh = 13'd2828;
       10'h1d0: pwm_thresh = 13'd2834;
       10'h1d1: pwm_thresh = 13'd2840;
       10'h1d2: pwm_thresh = 13'd2847;
       10'h1d3: pwm_thresh = 13'd2853;
       10'h1d4: pwm_thresh = 13'd2859;
       10'h1d5: pwm_thresh = 13'd2865;
       10'h1d6: pwm_thresh = 13'd2871;
       10'h1d7: pwm_thresh = 13'd2877;
       10'h1d8: pwm_thresh = 13'd2883;
       10'h1d9: pwm_thresh = 13'd2889;
       10'h1da: pwm_thresh = 13'd2895;
       10'h1db: pwm_thresh = 13'd2902;
       10'h1dc: pwm_thresh = 13'd2908;
       10'h1dd: pwm_thresh = 13'd2914;
       10'h1de: pwm_thresh = 13'd2920;
       10'h1df: pwm_thresh = 13'd2926;
       10'h1e0: pwm_thresh = 13'd2932;
       10'h1e1: pwm_thresh = 13'd2938;
       10'h1e2: pwm_thresh = 13'd2944;
       10'h1e3: pwm_thresh = 13'd2950;
       10'h1e4: pwm_thresh = 13'd2956;
       10'h1e5: pwm_thresh = 13'd2963;
       10'h1e6: pwm_thresh = 13'd2969;
       10'h1e7: pwm_thresh = 13'd2975;
       10'h1e8: pwm_thresh = 13'd2981;
       10'h1e9: pwm_thresh = 13'd2987;
       10'h1ea: pwm_thresh = 13'd2993;
       10'h1eb: pwm_thresh = 13'd2999;
       10'h1ec: pwm_thresh = 13'd3005;
       10'h1ed: pwm_thresh = 13'd3011;
       10'h1ee: pwm_thresh = 13'd3018;
       10'h1ef: pwm_thresh = 13'd3024;
       10'h1f0: pwm_thresh = 13'd3030;
       10'h1f1: pwm_thresh = 13'd3036;
       10'h1f2: pwm_thresh = 13'd3042;
       10'h1f3: pwm_thresh = 13'd3048;
       10'h1f4: pwm_thresh = 13'd3054;
       10'h1f5: pwm_thresh = 13'd3060;
       10'h1f6: pwm_thresh = 13'd3066;
       10'h1f7: pwm_thresh = 13'd3073;
       10'h1f8: pwm_thresh = 13'd3079;
       10'h1f9: pwm_thresh = 13'd3085;
       10'h1fa: pwm_thresh = 13'd3091;
       10'h1fb: pwm_thresh = 13'd3097;
       10'h1fc: pwm_thresh = 13'd3103;
       10'h1fd: pwm_thresh = 13'd3109;
       10'h1fe: pwm_thresh = 13'd3115;
       10'h1ff: pwm_thresh = 13'd3121;
       10'h200: pwm_thresh = 13'd3128;
       10'h201: pwm_thresh = 13'd3134;
       10'h202: pwm_thresh = 13'd3140;
       10'h203: pwm_thresh = 13'd3146;
       10'h204: pwm_thresh = 13'd3152;
       10'h205: pwm_thresh = 13'd3158;
       10'h206: pwm_thresh = 13'd3164;
       10'h207: pwm_thresh = 13'd3170;
       10'h208: pwm_thresh = 13'd3176;
       10'h209: pwm_thresh = 13'd3183;
       10'h20a: pwm_thresh = 13'd3189;
       10'h20b: pwm_thresh = 13'd3195;
       10'h20c: pwm_thresh = 13'd3201;
       10'h20d: pwm_thresh = 13'd3207;
       10'h20e: pwm_thresh = 13'd3213;
       10'h20f: pwm_thresh = 13'd3219;
       10'h210: pwm_thresh = 13'd3225;
       10'h211: pwm_thresh = 13'd3231;
       10'h212: pwm_thresh = 13'd3238;
       10'h213: pwm_thresh = 13'd3244;
       10'h214: pwm_thresh = 13'd3250;
       10'h215: pwm_thresh = 13'd3256;
       10'h216: pwm_thresh = 13'd3262;
       10'h217: pwm_thresh = 13'd3268;
       10'h218: pwm_thresh = 13'd3274;
       10'h219: pwm_thresh = 13'd3280;
       10'h21a: pwm_thresh = 13'd3286;
       10'h21b: pwm_thresh = 13'd3293;
       10'h21c: pwm_thresh = 13'd3299;
       10'h21d: pwm_thresh = 13'd3305;
       10'h21e: pwm_thresh = 13'd3311;
       10'h21f: pwm_thresh = 13'd3317;
       10'h220: pwm_thresh = 13'd3323;
       10'h221: pwm_thresh = 13'd3329;
       10'h222: pwm_thresh = 13'd3335;
       10'h223: pwm_thresh = 13'd3341;
       10'h224: pwm_thresh = 13'd3347;
       10'h225: pwm_thresh = 13'd3354;
       10'h226: pwm_thresh = 13'd3360;
       10'h227: pwm_thresh = 13'd3366;
       10'h228: pwm_thresh = 13'd3372;
       10'h229: pwm_thresh = 13'd3378;
       10'h22a: pwm_thresh = 13'd3384;
       10'h22b: pwm_thresh = 13'd3390;
       10'h22c: pwm_thresh = 13'd3396;
       10'h22d: pwm_thresh = 13'd3402;
       10'h22e: pwm_thresh = 13'd3409;
       10'h22f: pwm_thresh = 13'd3415;
       10'h230: pwm_thresh = 13'd3421;
       10'h231: pwm_thresh = 13'd3427;
       10'h232: pwm_thresh = 13'd3433;
       10'h233: pwm_thresh = 13'd3439;
       10'h234: pwm_thresh = 13'd3445;
       10'h235: pwm_thresh = 13'd3451;
       10'h236: pwm_thresh = 13'd3457;
       10'h237: pwm_thresh = 13'd3464;
       10'h238: pwm_thresh = 13'd3470;
       10'h239: pwm_thresh = 13'd3476;
       10'h23a: pwm_thresh = 13'd3482;
       10'h23b: pwm_thresh = 13'd3488;
       10'h23c: pwm_thresh = 13'd3494;
       10'h23d: pwm_thresh = 13'd3500;
       10'h23e: pwm_thresh = 13'd3506;
       10'h23f: pwm_thresh = 13'd3512;
       10'h240: pwm_thresh = 13'd3519;
       10'h241: pwm_thresh = 13'd3525;
       10'h242: pwm_thresh = 13'd3531;
       10'h243: pwm_thresh = 13'd3537;
       10'h244: pwm_thresh = 13'd3543;
       10'h245: pwm_thresh = 13'd3549;
       10'h246: pwm_thresh = 13'd3555;
       10'h247: pwm_thresh = 13'd3561;
       10'h248: pwm_thresh = 13'd3567;
       10'h249: pwm_thresh = 13'd3574;
       10'h24a: pwm_thresh = 13'd3580;
       10'h24b: pwm_thresh = 13'd3586;
       10'h24c: pwm_thresh = 13'd3592;
       10'h24d: pwm_thresh = 13'd3598;
       10'h24e: pwm_thresh = 13'd3604;
       10'h24f: pwm_thresh = 13'd3610;
       10'h250: pwm_thresh = 13'd3616;
       10'h251: pwm_thresh = 13'd3622;
       10'h252: pwm_thresh = 13'd3629;
       10'h253: pwm_thresh = 13'd3635;
       10'h254: pwm_thresh = 13'd3641;
       10'h255: pwm_thresh = 13'd3647;
       10'h256: pwm_thresh = 13'd3653;
       10'h257: pwm_thresh = 13'd3659;
       10'h258: pwm_thresh = 13'd3665;
       10'h259: pwm_thresh = 13'd3671;
       10'h25a: pwm_thresh = 13'd3677;
       10'h25b: pwm_thresh = 13'd3684;
       10'h25c: pwm_thresh = 13'd3690;
       10'h25d: pwm_thresh = 13'd3696;
       10'h25e: pwm_thresh = 13'd3702;
       10'h25f: pwm_thresh = 13'd3708;
       10'h260: pwm_thresh = 13'd3714;
       10'h261: pwm_thresh = 13'd3720;
       10'h262: pwm_thresh = 13'd3726;
       10'h263: pwm_thresh = 13'd3732;
       10'h264: pwm_thresh = 13'd3739;
       10'h265: pwm_thresh = 13'd3745;
       10'h266: pwm_thresh = 13'd3751;
       10'h267: pwm_thresh = 13'd3757;
       10'h268: pwm_thresh = 13'd3763;
       10'h269: pwm_thresh = 13'd3769;
       10'h26a: pwm_thresh = 13'd3775;
       10'h26b: pwm_thresh = 13'd3781;
       10'h26c: pwm_thresh = 13'd3787;
       10'h26d: pwm_thresh = 13'd3793;
       10'h26e: pwm_thresh = 13'd3800;
       10'h26f: pwm_thresh = 13'd3806;
       10'h270: pwm_thresh = 13'd3812;
       10'h271: pwm_thresh = 13'd3818;
       10'h272: pwm_thresh = 13'd3824;
       10'h273: pwm_thresh = 13'd3830;
       10'h274: pwm_thresh = 13'd3836;
       10'h275: pwm_thresh = 13'd3842;
       10'h276: pwm_thresh = 13'd3848;
       10'h277: pwm_thresh = 13'd3855;
       10'h278: pwm_thresh = 13'd3861;
       10'h279: pwm_thresh = 13'd3867;
       10'h27a: pwm_thresh = 13'd3873;
       10'h27b: pwm_thresh = 13'd3879;
       10'h27c: pwm_thresh = 13'd3885;
       10'h27d: pwm_thresh = 13'd3891;
       10'h27e: pwm_thresh = 13'd3897;
       10'h27f: pwm_thresh = 13'd3903;
       10'h280: pwm_thresh = 13'd3910;
       10'h281: pwm_thresh = 13'd3916;
       10'h282: pwm_thresh = 13'd3922;
       10'h283: pwm_thresh = 13'd3928;
       10'h284: pwm_thresh = 13'd3934;
       10'h285: pwm_thresh = 13'd3940;
       10'h286: pwm_thresh = 13'd3946;
       10'h287: pwm_thresh = 13'd3952;
       10'h288: pwm_thresh = 13'd3958;
       10'h289: pwm_thresh = 13'd3965;
       10'h28a: pwm_thresh = 13'd3971;
       10'h28b: pwm_thresh = 13'd3977;
       10'h28c: pwm_thresh = 13'd3983;
       10'h28d: pwm_thresh = 13'd3989;
       10'h28e: pwm_thresh = 13'd3995;
       10'h28f: pwm_thresh = 13'd4001;
       10'h290: pwm_thresh = 13'd4007;
       10'h291: pwm_thresh = 13'd4013;
       10'h292: pwm_thresh = 13'd4020;
       10'h293: pwm_thresh = 13'd4026;
       10'h294: pwm_thresh = 13'd4032;
       10'h295: pwm_thresh = 13'd4038;
       10'h296: pwm_thresh = 13'd4044;
       10'h297: pwm_thresh = 13'd4050;
       10'h298: pwm_thresh = 13'd4056;
       10'h299: pwm_thresh = 13'd4062;
       10'h29a: pwm_thresh = 13'd4068;
       10'h29b: pwm_thresh = 13'd4075;
       10'h29c: pwm_thresh = 13'd4081;
       10'h29d: pwm_thresh = 13'd4087;
       10'h29e: pwm_thresh = 13'd4093;
       10'h29f: pwm_thresh = 13'd4099;
       10'h2a0: pwm_thresh = 13'd4105;
       10'h2a1: pwm_thresh = 13'd4111;
       10'h2a2: pwm_thresh = 13'd4117;
       10'h2a3: pwm_thresh = 13'd4123;
       10'h2a4: pwm_thresh = 13'd4130;
       10'h2a5: pwm_thresh = 13'd4136;
       10'h2a6: pwm_thresh = 13'd4142;
       10'h2a7: pwm_thresh = 13'd4148;
       10'h2a8: pwm_thresh = 13'd4154;
       10'h2a9: pwm_thresh = 13'd4160;
       10'h2aa: pwm_thresh = 13'd4166;
       10'h2ab: pwm_thresh = 13'd4172;
       10'h2ac: pwm_thresh = 13'd4178;
       10'h2ad: pwm_thresh = 13'd4184;
       10'h2ae: pwm_thresh = 13'd4191;
       10'h2af: pwm_thresh = 13'd4197;
       10'h2b0: pwm_thresh = 13'd4203;
       10'h2b1: pwm_thresh = 13'd4209;
       10'h2b2: pwm_thresh = 13'd4215;
       10'h2b3: pwm_thresh = 13'd4221;
       10'h2b4: pwm_thresh = 13'd4227;
       10'h2b5: pwm_thresh = 13'd4233;
       10'h2b6: pwm_thresh = 13'd4239;
       10'h2b7: pwm_thresh = 13'd4246;
       10'h2b8: pwm_thresh = 13'd4252;
       10'h2b9: pwm_thresh = 13'd4258;
       10'h2ba: pwm_thresh = 13'd4264;
       10'h2bb: pwm_thresh = 13'd4270;
       10'h2bc: pwm_thresh = 13'd4276;
       10'h2bd: pwm_thresh = 13'd4282;
       10'h2be: pwm_thresh = 13'd4288;
       10'h2bf: pwm_thresh = 13'd4294;
       10'h2c0: pwm_thresh = 13'd4301;
       10'h2c1: pwm_thresh = 13'd4307;
       10'h2c2: pwm_thresh = 13'd4313;
       10'h2c3: pwm_thresh = 13'd4319;
       10'h2c4: pwm_thresh = 13'd4325;
       10'h2c5: pwm_thresh = 13'd4331;
       10'h2c6: pwm_thresh = 13'd4337;
       10'h2c7: pwm_thresh = 13'd4343;
       10'h2c8: pwm_thresh = 13'd4349;
       10'h2c9: pwm_thresh = 13'd4356;
       10'h2ca: pwm_thresh = 13'd4362;
       10'h2cb: pwm_thresh = 13'd4368;
       10'h2cc: pwm_thresh = 13'd4374;
       10'h2cd: pwm_thresh = 13'd4380;
       10'h2ce: pwm_thresh = 13'd4386;
       10'h2cf: pwm_thresh = 13'd4392;
       10'h2d0: pwm_thresh = 13'd4398;
       10'h2d1: pwm_thresh = 13'd4404;
       10'h2d2: pwm_thresh = 13'd4411;
       10'h2d3: pwm_thresh = 13'd4417;
       10'h2d4: pwm_thresh = 13'd4423;
       10'h2d5: pwm_thresh = 13'd4429;
       10'h2d6: pwm_thresh = 13'd4435;
       10'h2d7: pwm_thresh = 13'd4441;
       10'h2d8: pwm_thresh = 13'd4447;
       10'h2d9: pwm_thresh = 13'd4453;
       10'h2da: pwm_thresh = 13'd4459;
       10'h2db: pwm_thresh = 13'd4466;
       10'h2dc: pwm_thresh = 13'd4472;
       10'h2dd: pwm_thresh = 13'd4478;
       10'h2de: pwm_thresh = 13'd4484;
       10'h2df: pwm_thresh = 13'd4490;
       10'h2e0: pwm_thresh = 13'd4496;
       10'h2e1: pwm_thresh = 13'd4502;
       10'h2e2: pwm_thresh = 13'd4508;
       10'h2e3: pwm_thresh = 13'd4514;
       10'h2e4: pwm_thresh = 13'd4521;
       10'h2e5: pwm_thresh = 13'd4527;
       10'h2e6: pwm_thresh = 13'd4533;
       10'h2e7: pwm_thresh = 13'd4539;
       10'h2e8: pwm_thresh = 13'd4545;
       10'h2e9: pwm_thresh = 13'd4551;
       10'h2ea: pwm_thresh = 13'd4557;
       10'h2eb: pwm_thresh = 13'd4563;
       10'h2ec: pwm_thresh = 13'd4569;
       10'h2ed: pwm_thresh = 13'd4576;
       10'h2ee: pwm_thresh = 13'd4582;
       10'h2ef: pwm_thresh = 13'd4588;
       10'h2f0: pwm_thresh = 13'd4594;
       10'h2f1: pwm_thresh = 13'd4600;
       10'h2f2: pwm_thresh = 13'd4606;
       10'h2f3: pwm_thresh = 13'd4612;
       10'h2f4: pwm_thresh = 13'd4618;
       10'h2f5: pwm_thresh = 13'd4624;
       10'h2f6: pwm_thresh = 13'd4630;
       10'h2f7: pwm_thresh = 13'd4637;
       10'h2f8: pwm_thresh = 13'd4643;
       10'h2f9: pwm_thresh = 13'd4649;
       10'h2fa: pwm_thresh = 13'd4655;
       10'h2fb: pwm_thresh = 13'd4661;
       10'h2fc: pwm_thresh = 13'd4667;
       10'h2fd: pwm_thresh = 13'd4673;
       10'h2fe: pwm_thresh = 13'd4679;
       10'h2ff: pwm_thresh = 13'd4685;
       10'h300: pwm_thresh = 13'd4692;
       10'h301: pwm_thresh = 13'd4698;
       10'h302: pwm_thresh = 13'd4704;
       10'h303: pwm_thresh = 13'd4710;
       10'h304: pwm_thresh = 13'd4716;
       10'h305: pwm_thresh = 13'd4722;
       10'h306: pwm_thresh = 13'd4728;
       10'h307: pwm_thresh = 13'd4734;
       10'h308: pwm_thresh = 13'd4740;
       10'h309: pwm_thresh = 13'd4747;
       10'h30a: pwm_thresh = 13'd4753;
       10'h30b: pwm_thresh = 13'd4759;
       10'h30c: pwm_thresh = 13'd4765;
       10'h30d: pwm_thresh = 13'd4771;
       10'h30e: pwm_thresh = 13'd4777;
       10'h30f: pwm_thresh = 13'd4783;
       10'h310: pwm_thresh = 13'd4789;
       10'h311: pwm_thresh = 13'd4795;
       10'h312: pwm_thresh = 13'd4802;
       10'h313: pwm_thresh = 13'd4808;
       10'h314: pwm_thresh = 13'd4814;
       10'h315: pwm_thresh = 13'd4820;
       10'h316: pwm_thresh = 13'd4826;
       10'h317: pwm_thresh = 13'd4832;
       10'h318: pwm_thresh = 13'd4838;
       10'h319: pwm_thresh = 13'd4844;
       10'h31a: pwm_thresh = 13'd4850;
       10'h31b: pwm_thresh = 13'd4857;
       10'h31c: pwm_thresh = 13'd4863;
       10'h31d: pwm_thresh = 13'd4869;
       10'h31e: pwm_thresh = 13'd4875;
       10'h31f: pwm_thresh = 13'd4881;
       10'h320: pwm_thresh = 13'd4887;
       10'h321: pwm_thresh = 13'd4893;
       10'h322: pwm_thresh = 13'd4899;
       10'h323: pwm_thresh = 13'd4905;
       10'h324: pwm_thresh = 13'd4912;
       10'h325: pwm_thresh = 13'd4918;
       10'h326: pwm_thresh = 13'd4924;
       10'h327: pwm_thresh = 13'd4930;
       10'h328: pwm_thresh = 13'd4936;
       10'h329: pwm_thresh = 13'd4942;
       10'h32a: pwm_thresh = 13'd4948;
       10'h32b: pwm_thresh = 13'd4954;
       10'h32c: pwm_thresh = 13'd4960;
       10'h32d: pwm_thresh = 13'd4967;
       10'h32e: pwm_thresh = 13'd4973;
       10'h32f: pwm_thresh = 13'd4979;
       10'h330: pwm_thresh = 13'd4985;
       10'h331: pwm_thresh = 13'd4991;
       10'h332: pwm_thresh = 13'd4997;
       10'h333: pwm_thresh = 13'd5003;
       10'h334: pwm_thresh = 13'd5009;
       10'h335: pwm_thresh = 13'd5015;
       10'h336: pwm_thresh = 13'd5021;
       10'h337: pwm_thresh = 13'd5028;
       10'h338: pwm_thresh = 13'd5034;
       10'h339: pwm_thresh = 13'd5040;
       10'h33a: pwm_thresh = 13'd5046;
       10'h33b: pwm_thresh = 13'd5052;
       10'h33c: pwm_thresh = 13'd5058;
       10'h33d: pwm_thresh = 13'd5064;
       10'h33e: pwm_thresh = 13'd5070;
       10'h33f: pwm_thresh = 13'd5076;
       10'h340: pwm_thresh = 13'd5083;
       10'h341: pwm_thresh = 13'd5089;
       10'h342: pwm_thresh = 13'd5095;
       10'h343: pwm_thresh = 13'd5101;
       10'h344: pwm_thresh = 13'd5107;
       10'h345: pwm_thresh = 13'd5113;
       10'h346: pwm_thresh = 13'd5119;
       10'h347: pwm_thresh = 13'd5125;
       10'h348: pwm_thresh = 13'd5131;
       10'h349: pwm_thresh = 13'd5138;
       10'h34a: pwm_thresh = 13'd5144;
       10'h34b: pwm_thresh = 13'd5150;
       10'h34c: pwm_thresh = 13'd5156;
       10'h34d: pwm_thresh = 13'd5162;
       10'h34e: pwm_thresh = 13'd5168;
       10'h34f: pwm_thresh = 13'd5174;
       10'h350: pwm_thresh = 13'd5180;
       10'h351: pwm_thresh = 13'd5186;
       10'h352: pwm_thresh = 13'd5193;
       10'h353: pwm_thresh = 13'd5199;
       10'h354: pwm_thresh = 13'd5205;
       10'h355: pwm_thresh = 13'd5211;
       10'h356: pwm_thresh = 13'd5217;
       10'h357: pwm_thresh = 13'd5223;
       10'h358: pwm_thresh = 13'd5229;
       10'h359: pwm_thresh = 13'd5235;
       10'h35a: pwm_thresh = 13'd5241;
       10'h35b: pwm_thresh = 13'd5248;
       10'h35c: pwm_thresh = 13'd5254;
       10'h35d: pwm_thresh = 13'd5260;
       10'h35e: pwm_thresh = 13'd5266;
       10'h35f: pwm_thresh = 13'd5272;
       10'h360: pwm_thresh = 13'd5278;
       10'h361: pwm_thresh = 13'd5284;
       10'h362: pwm_thresh = 13'd5290;
       10'h363: pwm_thresh = 13'd5296;
       10'h364: pwm_thresh = 13'd5303;
       10'h365: pwm_thresh = 13'd5309;
       10'h366: pwm_thresh = 13'd5315;
       10'h367: pwm_thresh = 13'd5321;
       10'h368: pwm_thresh = 13'd5327;
       10'h369: pwm_thresh = 13'd5333;
       10'h36a: pwm_thresh = 13'd5339;
       10'h36b: pwm_thresh = 13'd5345;
       10'h36c: pwm_thresh = 13'd5351;
       10'h36d: pwm_thresh = 13'd5358;
       10'h36e: pwm_thresh = 13'd5364;
       10'h36f: pwm_thresh = 13'd5370;
       10'h370: pwm_thresh = 13'd5376;
       10'h371: pwm_thresh = 13'd5382;
       10'h372: pwm_thresh = 13'd5388;
       10'h373: pwm_thresh = 13'd5394;
       10'h374: pwm_thresh = 13'd5400;
       10'h375: pwm_thresh = 13'd5406;
       10'h376: pwm_thresh = 13'd5413;
       10'h377: pwm_thresh = 13'd5419;
       10'h378: pwm_thresh = 13'd5425;
       10'h379: pwm_thresh = 13'd5431;
       10'h37a: pwm_thresh = 13'd5437;
       10'h37b: pwm_thresh = 13'd5443;
       10'h37c: pwm_thresh = 13'd5449;
       10'h37d: pwm_thresh = 13'd5455;
       10'h37e: pwm_thresh = 13'd5461;
       10'h37f: pwm_thresh = 13'd5467;
       10'h380: pwm_thresh = 13'd5474;
       10'h381: pwm_thresh = 13'd5480;
       10'h382: pwm_thresh = 13'd5486;
       10'h383: pwm_thresh = 13'd5492;
       10'h384: pwm_thresh = 13'd5498;
       10'h385: pwm_thresh = 13'd5504;
       10'h386: pwm_thresh = 13'd5510;
       10'h387: pwm_thresh = 13'd5516;
       10'h388: pwm_thresh = 13'd5522;
       10'h389: pwm_thresh = 13'd5529;
       10'h38a: pwm_thresh = 13'd5535;
       10'h38b: pwm_thresh = 13'd5541;
       10'h38c: pwm_thresh = 13'd5547;
       10'h38d: pwm_thresh = 13'd5553;
       10'h38e: pwm_thresh = 13'd5559;
       10'h38f: pwm_thresh = 13'd5565;
       10'h390: pwm_thresh = 13'd5571;
       10'h391: pwm_thresh = 13'd5577;
       10'h392: pwm_thresh = 13'd5584;
       10'h393: pwm_thresh = 13'd5590;
       10'h394: pwm_thresh = 13'd5596;
       10'h395: pwm_thresh = 13'd5602;
       10'h396: pwm_thresh = 13'd5608;
       10'h397: pwm_thresh = 13'd5614;
       10'h398: pwm_thresh = 13'd5620;
       10'h399: pwm_thresh = 13'd5626;
       10'h39a: pwm_thresh = 13'd5632;
       10'h39b: pwm_thresh = 13'd5639;
       10'h39c: pwm_thresh = 13'd5645;
       10'h39d: pwm_thresh = 13'd5651;
       10'h39e: pwm_thresh = 13'd5657;
       10'h39f: pwm_thresh = 13'd5663;
       10'h3a0: pwm_thresh = 13'd5669;
       10'h3a1: pwm_thresh = 13'd5675;
       10'h3a2: pwm_thresh = 13'd5681;
       10'h3a3: pwm_thresh = 13'd5687;
       10'h3a4: pwm_thresh = 13'd5694;
       10'h3a5: pwm_thresh = 13'd5700;
       10'h3a6: pwm_thresh = 13'd5706;
       10'h3a7: pwm_thresh = 13'd5712;
       10'h3a8: pwm_thresh = 13'd5718;
       10'h3a9: pwm_thresh = 13'd5724;
       10'h3aa: pwm_thresh = 13'd5730;
       10'h3ab: pwm_thresh = 13'd5736;
       10'h3ac: pwm_thresh = 13'd5742;
       10'h3ad: pwm_thresh = 13'd5749;
       10'h3ae: pwm_thresh = 13'd5755;
       10'h3af: pwm_thresh = 13'd5761;
       10'h3b0: pwm_thresh = 13'd5767;
       10'h3b1: pwm_thresh = 13'd5773;
       10'h3b2: pwm_thresh = 13'd5779;
       10'h3b3: pwm_thresh = 13'd5785;
       10'h3b4: pwm_thresh = 13'd5791;
       10'h3b5: pwm_thresh = 13'd5797;
       10'h3b6: pwm_thresh = 13'd5804;
       10'h3b7: pwm_thresh = 13'd5810;
       10'h3b8: pwm_thresh = 13'd5816;
       10'h3b9: pwm_thresh = 13'd5822;
       10'h3ba: pwm_thresh = 13'd5828;
       10'h3bb: pwm_thresh = 13'd5834;
       10'h3bc: pwm_thresh = 13'd5840;
       10'h3bd: pwm_thresh = 13'd5846;
       10'h3be: pwm_thresh = 13'd5852;
       10'h3bf: pwm_thresh = 13'd5858;
       10'h3c0: pwm_thresh = 13'd5865;
       10'h3c1: pwm_thresh = 13'd5871;
       10'h3c2: pwm_thresh = 13'd5877;
       10'h3c3: pwm_thresh = 13'd5883;
       10'h3c4: pwm_thresh = 13'd5889;
       10'h3c5: pwm_thresh = 13'd5895;
       10'h3c6: pwm_thresh = 13'd5901;
       10'h3c7: pwm_thresh = 13'd5907;
       10'h3c8: pwm_thresh = 13'd5913;
       10'h3c9: pwm_thresh = 13'd5920;
       10'h3ca: pwm_thresh = 13'd5926;
       10'h3cb: pwm_thresh = 13'd5932;
       10'h3cc: pwm_thresh = 13'd5938;
       10'h3cd: pwm_thresh = 13'd5944;
       10'h3ce: pwm_thresh = 13'd5950;
       10'h3cf: pwm_thresh = 13'd5956;
       10'h3d0: pwm_thresh = 13'd5962;
       10'h3d1: pwm_thresh = 13'd5968;
       10'h3d2: pwm_thresh = 13'd5975;
       10'h3d3: pwm_thresh = 13'd5981;
       10'h3d4: pwm_thresh = 13'd5987;
       10'h3d5: pwm_thresh = 13'd5993;
       10'h3d6: pwm_thresh = 13'd5999;
       10'h3d7: pwm_thresh = 13'd6005;
       10'h3d8: pwm_thresh = 13'd6011;
       10'h3d9: pwm_thresh = 13'd6017;
       10'h3da: pwm_thresh = 13'd6023;
       10'h3db: pwm_thresh = 13'd6030;
       10'h3dc: pwm_thresh = 13'd6036;
       10'h3dd: pwm_thresh = 13'd6042;
       10'h3de: pwm_thresh = 13'd6048;
       10'h3df: pwm_thresh = 13'd6054;
       10'h3e0: pwm_thresh = 13'd6060;
       10'h3e1: pwm_thresh = 13'd6066;
       10'h3e2: pwm_thresh = 13'd6072;
       10'h3e3: pwm_thresh = 13'd6078;
       10'h3e4: pwm_thresh = 13'd6085;
       10'h3e5: pwm_thresh = 13'd6091;
       10'h3e6: pwm_thresh = 13'd6097;
       10'h3e7: pwm_thresh = 13'd6103;
       10'h3e8: pwm_thresh = 13'd6109;
       10'h3e9: pwm_thresh = 13'd6115;
       10'h3ea: pwm_thresh = 13'd6121;
       10'h3eb: pwm_thresh = 13'd6127;
       10'h3ec: pwm_thresh = 13'd6133;
       10'h3ed: pwm_thresh = 13'd6140;
       10'h3ee: pwm_thresh = 13'd6146;
       10'h3ef: pwm_thresh = 13'd6152;
       10'h3f0: pwm_thresh = 13'd6158;
       10'h3f1: pwm_thresh = 13'd6164;
       10'h3f2: pwm_thresh = 13'd6170;
       10'h3f3: pwm_thresh = 13'd6176;
       10'h3f4: pwm_thresh = 13'd6182;
       10'h3f5: pwm_thresh = 13'd6188;
       10'h3f6: pwm_thresh = 13'd6195;
       10'h3f7: pwm_thresh = 13'd6201;
       10'h3f8: pwm_thresh = 13'd6207;
       10'h3f9: pwm_thresh = 13'd6213;
       10'h3fa: pwm_thresh = 13'd6219;
       10'h3fb: pwm_thresh = 13'd6225;
       10'h3fc: pwm_thresh = 13'd6231;
       10'h3fd: pwm_thresh = 13'd6237;
       10'h3fe: pwm_thresh = 13'd6243;
       10'h3ff: pwm_thresh = 13'd6250;
    endcase
 end

endmodule: pwm_thresholder_16k