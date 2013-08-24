//
//  UIInsetTextField.m
//  


#import "UIInsetTextField.h"

@implementation UIInsetTextField

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 8 , 0 );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 8 , 0 );
}
@end
