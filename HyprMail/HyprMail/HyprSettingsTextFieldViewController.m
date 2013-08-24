//
//  HyprSettingsTextFieldViewController.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprSettingsTextFieldViewController.h"

@interface HyprSettingsTextFieldViewController ()

@end

@implementation HyprSettingsTextFieldViewController

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
    
    self.contentSizeForViewInPopover = CGSizeMake(320, 300);
    self.title = @"Text";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.textDelegate) {
        [self.textDelegate textDidChangeTo:self.textView.text fromEditor:self];
    }
}

@end
