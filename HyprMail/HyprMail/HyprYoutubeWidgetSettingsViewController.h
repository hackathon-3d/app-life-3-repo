//
//  HyprYoutubeWidgetSettingsViewController.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HyprYoutubeWidgetSettingsViewController;

@protocol HyprYoutubeWidgetSettingsProtocol <NSObject>

-(void)youtubeLinkDidChangeTo:(NSString*)link forSettings:(HyprYoutubeWidgetSettingsViewController*)settings;

@end
@interface HyprYoutubeWidgetSettingsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *urlLink;
@property (nonatomic,strong) id<HyprYoutubeWidgetSettingsProtocol> settingsDelegate;
@end
