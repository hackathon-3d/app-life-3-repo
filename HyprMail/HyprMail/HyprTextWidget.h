//
//  HyprTextWidget.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprWidget.h"

@interface HyprTextWidget : HyprWidget

@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,assign)NSTextAlignment textAlign;


-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location initialText:(NSString*)text initialColor:(UIColor*)color initialFont:(UIFont*)font;

@end
