//
//  ViewController.m
//  HyprMail
//
//  Created by Brendan Lee on 8/23/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "ViewController.h"
#import "HyprEditorViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)openEditor:(id)sender
{
    NSDictionary *theme = @{
                            @"initial-text-color" : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                            @"initial-text-font" : [UIFont systemFontOfSize:17.0],
                            @"initial-button-text-color" : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                            @"initial-button-text-font" : [UIFont systemFontOfSize:13.0],
                            @"initial-button-background-color" : [UIColor yellowColor],
                            @"initial-document-background-color" : [UIColor lightGrayColor],
                            @"initial-page-background-color" : [UIColor whiteColor]
                            };
    HyprEditorViewController *editor = [[HyprEditorViewController alloc] initWithNibName:@"HyprEditorViewController" bundle:nil withThemePack:theme];
    
    [self presentViewController:editor animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
