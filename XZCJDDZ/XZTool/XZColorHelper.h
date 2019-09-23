

#ifndef Capsule_DDZZYYColorHelper_h
#define Capsule_DDZZYYColorHelper_h

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 \
alpha:(a)]

#define RGBACOLORCG(r,g,b,a) [[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 \
alpha:(a)] CGColor]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]

#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0, (g)/255.0, (b)/255.0, (a)

#define kColor4cc1a4         UIColorFromRGB(0x4cc1a4)
#define kColordyRed           UIColorFromRGB(0xf86161)
#define kColor414755            UIColorFromRGB(0x414755)

#define kFont(fontSize)            [UIFont systemFontOfSize:fontSize]

#endif
