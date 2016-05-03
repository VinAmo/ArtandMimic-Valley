//
//  VAPalette.m
//
//
//  Created by V on 15/6/19.
//  Copyright (c) 2015 V. All rights reserved.
//

#import "VAPalette.h"

#define Toning(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define Extract(hexRGB) [UIColor colorWithRed:((hexRGB&0xFF) >> 16)/255.0 green:((hexRGB&0xFF) >> 8)/255.0 blue:(hexRGB&0xFF)/255.0 alpha:1.0]

@implementation VAPalette

#pragma mark + Red

+ (UIColor *)redMagenta    { return Toning(207, 0,   112); }
+ (UIColor *)redCarmine    { return Toning(215, 0,   64);  }
+ (UIColor *)redRuby       { return Toning(200, 8,   82);  }
+ (UIColor *)redRose       { return Toning(230, 27,  100); }
+ (UIColor *)redCamellia   { return Toning(220, 90,  111); }
+ (UIColor *)redRosePink   { return Toning(238, 134, 154); }
+ (UIColor *)redSpinel     { return Toning(240, 145, 146); }
+ (UIColor *)redOperaMauve { return Toning(225, 152, 192); }
+ (UIColor *)redCoralPink  { return Toning(241, 156, 159); }
+ (UIColor *)redFlamingo   { return Toning(245, 178, 178); }
+ (UIColor *)redPalePink   { return Toning(247, 200, 207); }
+ (UIColor *)redShellPink  { return Toning(248, 198, 181); }
+ (UIColor *)redBabyPink   { return Toning(252, 229, 223); }
+ (UIColor *)redSalmonPink { return Toning(242, 155, 135); }
+ (UIColor *)redVermilion  { return Toning(233, 71,  41);  }
+ (UIColor *)redScarlet    { return Toning(230, 0,   18);  }
+ (UIColor *)redStrong     { return Toning(216, 0,   15);  }
+ (UIColor *)redCardinal   { return Toning(164, 0,   39);  }
+ (UIColor *)redBuraunby   { return Toning(102, 25,  45);  }
+ (UIColor *)redOldRose    { return Toning(194, 115, 127); }

#pragma mark + Orange

+ (UIColor *)orangeTangerine     { return Toning(234, 85,  32);  }
+ (UIColor *)orangePersimmom     { return Toning(237, 110, 61);  }
+ (UIColor *)orange              { return Toning(237, 109, 0);   }
+ (UIColor *)orangeSun           { return Toning(241, 141, 0);   }
+ (UIColor *)orangeTropical      { return Toning(243, 152, 57);  }
+ (UIColor *)orangeHoney         { return Toning(249, 194, 112); }
+ (UIColor *)orangeApricot       { return Toning(229, 169, 107); }
+ (UIColor *)orangeSandbeige     { return Toning(236, 214, 202); }
+ (UIColor *)orangeBeige         { return Toning(227, 204, 169); }
+ (UIColor *)orangePaleOcre      { return Toning(211, 181, 148); }
+ (UIColor *)orangeCamel         { return Toning(181, 134, 84);  }
+ (UIColor *)orangeCoconetsBrown { return Toning(106, 51,  21);  }
+ (UIColor *)orangeBrown         { return Toning(113, 59,  18);  }
+ (UIColor *)orangeCoffee        { return Toning(106, 75,  35);  }

#pragma mark + Yellow

+ (UIColor *)yellowMarigold  { return Toning(247, 171, 0);   }
+ (UIColor *)yellowChrome    { return Toning(253, 208, 0);   }
+ (UIColor *)yellowJasmine   { return Toning(254, 221, 120); }
+ (UIColor *)yellowCream     { return Toning(255, 234, 180); }
+ (UIColor *)yellowIvory     { return Toning(235, 229, 209); }
+ (UIColor *)yellowChampagne { return Toning(255, 249, 177); }
+ (UIColor *)yellowMoon      { return Toning(255, 244, 99);  }
+ (UIColor *)yellowCanaria   { return Toning(255, 241, 0);   }
+ (UIColor *)yellowMimosa    { return Toning(237, 212, 67);  }
+ (UIColor *)yellowMustard   { return Toning(214, 197, 96);  }
+ (UIColor *)yellowOchre     { return Toning(196, 143, 0);   }
+ (UIColor *)yellowKhaki     { return Toning(176, 136, 39);  }

#pragma mark + Green

+ (UIColor *)greenYellow      { return Toning(196, 215, 0);   }
+ (UIColor *)greenApple       { return Toning(158, 189, 25);  }
+ (UIColor *)greenFreshLeaves { return Toning(169, 208, 107); }
+ (UIColor *)greenFoliage     { return Toning(135, 162, 86);  }
+ (UIColor *)greenGrass       { return Toning(170, 196, 104); }
+ (UIColor *)greenMoss        { return Toning(136, 134, 55);  }
+ (UIColor *)greenOlive       { return Toning(98,  90,  5);   }
+ (UIColor *)greenIvy         { return Toning(61,  125, 83);  }
+ (UIColor *)greenCobalt      { return Toning(106, 189, 120); }
+ (UIColor *)greenEmerald     { return Toning(21,  174, 103); }
+ (UIColor *)greenTurquoise   { return Toning(66,  171, 145); }
+ (UIColor *)greenCeladon     { return Toning(123, 185, 155); }
+ (UIColor *)greenMalachite   { return Toning(0,   142, 87);  }
+ (UIColor *)greenMint        { return Toning(0,   120, 80);  }
+ (UIColor *)greenViridian    { return Toning(0,   101, 80);  }
+ (UIColor *)greenPeacoke     { return Toning(0,   128, 119); }

#pragma mark + Blue

+ (UIColor *)blueHorizon     { return Toning(176, 220, 213); }
+ (UIColor *)blueLightSky    { return Toning(161, 216, 230); }
+ (UIColor *)blueAqua        { return Toning(89,  195, 226); }
+ (UIColor *)blueAzure       { return Toning(34,  174, 230); }
+ (UIColor *)blueSky         { return Toning(148, 198, 221); }
+ (UIColor *)blueBaby        { return Toning(177, 212, 219); }
+ (UIColor *)bluePale        { return Toning(139, 176, 205); }
+ (UIColor *)blueSaxe        { return Toning(82,  129, 172); }
+ (UIColor *)blueAquamarine  { return Toning(41,  131, 177); }
+ (UIColor *)blueTurquoise   { return Toning(0,   164, 197); }
+ (UIColor *)blueCyan        { return Toning(0,   136, 144); }
+ (UIColor *)bluePeacock     { return Toning(0,   105, 128); }
+ (UIColor *)blueCerulean    { return Toning(0,   123, 187); }
+ (UIColor *)blueCobalt      { return Toning(0,   93,  172); }
+ (UIColor *)blueUltramarine { return Toning(0,   64,  152); }
+ (UIColor *)blueRoyal       { return Toning(30,  80,  162); }
+ (UIColor *)blueLapislazuli { return Toning(19,  64,  152); }
+ (UIColor *)blueSalvia      { return Toning(91,  119, 175); }
+ (UIColor *)blueWedgwood    { return Toning(102, 132, 176); }
+ (UIColor *)blueSlate       { return Toning(100, 121, 151); }
+ (UIColor *)blueSapphire    { return Toning(0,   87,  137); }
+ (UIColor *)blueMineral     { return Toning(0,   81,  120); }
+ (UIColor *)blueStrong      { return Toning(0,   89,  120); }
+ (UIColor *)blueMarine      { return Toning(0,   69,  107); }
+ (UIColor *)blueNavy        { return Toning(0,   28,  84);  }
+ (UIColor *)blueIndigo      { return Toning(0,   46,  90);  }
+ (UIColor *)blueDarkMineral { return Toning(56,  66,  106); }
+ (UIColor *)blueMidnight    { return Toning(4,   22,  58);  }

#pragma mark + Purple

+ (UIColor *)purpleWisteria      { return Toning(115, 91,  159); }
+ (UIColor *)purpleMauve         { return Toning(124, 80,  157); }
+ (UIColor *)purpleClematis      { return Toning(216, 191, 203); }
+ (UIColor *)purpleLilac         { return Toning(187, 161, 203); }
+ (UIColor *)purpleLavender      { return Toning(166, 136, 177); }
+ (UIColor *)purpleAmethyst      { return Toning(126, 73,  133); }
+ (UIColor *)purple              { return Toning(146, 61,  146); }
+ (UIColor *)purpleHeliotrope    { return Toning(111, 25,  111); }
+ (UIColor *)purpleMineralViolet { return Toning(197, 175, 192); }
+ (UIColor *)purplePansy         { return Toning(139, 0,   98);  }
+ (UIColor *)purpleMallow        { return Toning(211, 105, 164); }
+ (UIColor *)purpleOrchid        { return Toning(209, 136, 168); }
+ (UIColor *)purplePaleLilac     { return Toning(237, 244, 230); }
+ (UIColor *)purpleGray          { return Toning(157, 137, 157); }

@end
