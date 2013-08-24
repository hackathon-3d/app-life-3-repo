//
//  HyprYoutubeWidgetSettingsViewController.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprYoutubeWidgetSettingsViewController.h"

@interface HyprYoutubeWidgetSettingsViewController ()

@end

@implementation HyprYoutubeWidgetSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"YouTube";
    self.contentSizeForViewInPopover = CGSizeMake(320, 250);
    
    [self.urlLink becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.settingsDelegate youtubeLinkDidChangeTo:self.urlLink.text forSettings:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
