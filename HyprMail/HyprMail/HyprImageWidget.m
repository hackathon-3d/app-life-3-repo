//
//  HyprImageWidget.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprImageWidget.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation HyprImageWidget

-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location withImage:(UIImage*)image
{
    self = [super initWithDocumentEditor:editor withInitialLocation:location];
    
    if (self) {
        self.image = image;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:location];
        imageView.image = image;
        imageView.userInteractionEnabled = NO;
        
        self.view.contentView = imageView;
        
        self.typeName = @"Image";

    }
    
    return self;
}

-(void)openSettings
{
    [self clearPopover];
    
    if (self.picker) {
        self.picker.delegate = nil;
        self.picker = nil;
    }
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil];
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.delegate = self;
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:self.picker];
    
    self.popover.delegate = self;
    [self.popover presentPopoverFromRect:self.view.frame inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self clearPopover];
    
    self.picker.delegate = nil;
    self.picker = nil;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];
    
    self.image = pickedImage;
    UIImageView *imageView = (UIImageView*)self.view.contentView;
    imageView.image = pickedImage;
    
    [self clearPopover];
    
    self.picker.delegate = nil;
    self.picker = nil;
}
@end
