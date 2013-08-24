//
//  HyprImageWidget.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprWidget.h"

@interface HyprImageWidget : HyprWidget<UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property(nonatomic,strong)UIImagePickerController *picker;

@property(nonatomic,strong)UIImage *image;

-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location withImage:(UIImage*)image;

@end
