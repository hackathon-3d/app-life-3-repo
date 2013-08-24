//
//  HyprYoutubeWidget.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprYoutubeWidget.h"
#import "AFNetworking.h"
#import "HyprYoutubeWidgetRenderingView.h"
#import "SessionManager.h"
#import "NSURL+DictionaryURLValue.h"


@implementation HyprYoutubeWidget

-(id)initWithDocumentEditor:(HyprEditorViewController*)editor withInitialLocation:(CGRect)location withImage:(UIImage*)image
{
    self = [super initWithDocumentEditor:editor withInitialLocation:location];
    
    if (self) {
        self.image = image;
        
        
        HyprYoutubeWidgetRenderingView *imageView = [[HyprYoutubeWidgetRenderingView alloc] initWithFrame:location];
        imageView.widget = self;
        
        self.view.contentView = imageView;
        
        self.typeName = @"Video";
        
    }
    
    return self;
}

-(void)openSettings
{
    [self clearPopover];
    
    HyprYoutubeWidgetSettingsViewController *settings = [[HyprYoutubeWidgetSettingsViewController alloc] initWithNibName:@"HyprYoutubeWidgetSettingsViewController" bundle:nil];
    settings.settingsDelegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:settings];
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    self.popover.delegate = self;
    [self.popover presentPopoverFromRect:self.view.frame inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight animated:YES];
    
    settings.urlLink.text = self.link;
}

-(void)youtubeLinkDidChangeTo:(NSString *)link forSettings:(HyprYoutubeWidgetSettingsViewController *)settings
{
    settings.settingsDelegate = nil;
    
    [self setYoutubeImageURL:link];
}
-(void)setYoutubeImageURL:(NSString *)youtubeImageURL
{
    self.link = youtubeImageURL;
    __block NSString *discoveredKeyword = nil;
    
    NSDictionary *brokenUp = [[NSURL URLWithString:youtubeImageURL] dictionaryValue];
    
    discoveredKeyword = brokenUp[@"v"];
    
    if (discoveredKeyword) {
        NSString *imageURL = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", discoveredKeyword];
        
        //Download this image
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
        
        AFHTTPRequestOperation *downloadRequest = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [downloadRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.youTubeImage = [UIImage imageWithData:responseObject];
            
            [self.view.contentView setNeedsDisplay];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Youtube Error: %@", error.localizedFailureReason] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }];
        
        [[[SessionManager sharedSession] APIClient] enqueueHTTPRequestOperation:downloadRequest];
    }
    else
    {
        if (youtubeImageURL && youtubeImageURL.length != 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid YouTube video URL." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}
@end
