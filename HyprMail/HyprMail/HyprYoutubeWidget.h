//
//  HyprYoutubeWidget.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprImageWidget.h"
#import "HyprYoutubeWidgetSettingsViewController.h"

@interface HyprYoutubeWidget : HyprImageWidget<HyprYoutubeWidgetSettingsProtocol>

@property(nonatomic,strong)UIImage *youTubeImage;
@property(nonatomic,strong)NSString *youtubeImageURL;
@end
