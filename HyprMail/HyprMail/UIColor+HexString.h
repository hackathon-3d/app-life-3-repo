//
//  UIColor+HexString.h
//  Canary
//
//  Created by Brendan Lee on 8/27/12.
//
//

#import <Foundation/Foundation.h>

@interface UIColor(HexString)

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;
+ (UIColor *) colorWithHexString: (NSString *) hexString withAlpha:(float)alpha;
- (NSString *) htmlFromUIColor;
@end


@implementation UIColor(HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString withAlpha:(float)alpha{
    
    @try {
        NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
        CGFloat red, blue, green;
        switch ([colorString length]) {
            case 3: // #RGB
                    //alpha = 1.0f;
                red   = [self colorComponentFrom: colorString start: 0 length: 1];
                green = [self colorComponentFrom: colorString start: 1 length: 1];
                blue  = [self colorComponentFrom: colorString start: 2 length: 1];
                break;
            case 4: // #ARGB
                    //alpha = [self colorComponentFrom: colorString start: 0 length: 1];
                red   = [self colorComponentFrom: colorString start: 1 length: 1];
                green = [self colorComponentFrom: colorString start: 2 length: 1];
                blue  = [self colorComponentFrom: colorString start: 3 length: 1];
                break;
            case 6: // #RRGGBB
                    //alpha = 1.0f;
                red   = [self colorComponentFrom: colorString start: 0 length: 2];
                green = [self colorComponentFrom: colorString start: 2 length: 2];
                blue  = [self colorComponentFrom: colorString start: 4 length: 2];
                break;
            case 8: // #AARRGGBB
                    //alpha = [self colorComponentFrom: colorString start: 0 length: 2];
                red   = [self colorComponentFrom: colorString start: 2 length: 2];
                green = [self colorComponentFrom: colorString start: 4 length: 2];
                blue  = [self colorComponentFrom: colorString start: 6 length: 2];
                break;
            default:
                // [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
                
                return [UIColor blackColor];
                break;
        }
        return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
    }
    @catch (NSException *exception) {
        return [UIColor blackColor];
    }
    @finally {
        
    }

}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (NSString *) htmlFromUIColor {
    UIColor *_color = self;
    
    if (CGColorGetNumberOfComponents(_color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(_color.CGColor);
        _color = [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(_color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(_color.CGColor))[0]*255.0), (int)((CGColorGetComponents(_color.CGColor))[1]*255.0), (int)((CGColorGetComponents(_color.CGColor))[2]*255.0)];
}

@end