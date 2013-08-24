//
//  HyprButtonWidget.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprTextWidget.h"

@interface HyprButtonWidget : HyprTextWidget

@property(nonatomic,strong)UIColor *buttonColor;

//link property inherited from HyprTextWidget

-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location initialText:(NSString*)text initialColor:(UIColor*)color initialFont:(UIFont*)font initialButtonColor:(UIColor*)buttonColor;


@end
