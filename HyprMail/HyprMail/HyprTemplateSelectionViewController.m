//
//  HyprTemplateSelectionViewController.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprTemplateSelectionViewController.h"
#import "NSTimer+Blocks.h"
#import "HyprEditorViewController.h"
#import "AppDelegate.h"

#import "HyprImageWidget.h"
#import "HyprTextWidget.h"
#import "HyprButtonWidget.h"
#import "UIColor+HexString.h"

@interface HyprTemplateSelectionViewController ()

@end

@implementation HyprTemplateSelectionViewController

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
    
    //First, let's piece the scrollview together.
    
    self.templatesContainer.frame = CGRectMake((self.scrollView.frame.size.width-self.templatesContainer.frame.size.width)/2.0, 60.0, 600.0, self.templatesContainer.frame.size.height);
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.templatesContainer.frame.size.height+60.0)];
    
    [self.scrollView addSubview:self.templatesContainer];
    
    self.scrollView.frame = CGRectMake(0, 44.0, 1024, 704);
    
    [self.view addSubview:self.scrollView];
    
    UIImage *coralIm = [[UIImage imageNamed:@"buttonCoralSmall.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    [self.templateButton1 setBackgroundImage:coralIm forState:UIControlStateNormal];
    [self.templateButton2 setBackgroundImage:coralIm forState:UIControlStateNormal];
    [self.templateButton3 setBackgroundImage:coralIm forState:UIControlStateNormal];
    [self.templateButton4 setBackgroundImage:coralIm forState:UIControlStateNormal];

    
}

-(IBAction)newBlankTemplate:(id)sender
{
    NSDictionary *theme = @{
                            @"initial-text-color" : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                            @"initial-text-font" : [UIFont systemFontOfSize:17.0],
                            @"initial-button-text-color" : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                            @"initial-button-text-font" : [UIFont systemFontOfSize:13.0],
                            @"initial-button-background-color" : [UIColor darkGrayColor],
                            @"initial-document-background-color" : [UIColor lightGrayColor],
                            @"initial-page-background-color" : [UIColor whiteColor]
                            };

    
    HyprEditorViewController * editor = [[HyprEditorViewController alloc] initWithNibName:@"HyprEditorViewController" bundle:nil withThemePack:theme];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editor];
    
    //We need to move out the scrollview
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.scrollView.frame = CGRectMake(0, 768, 1024, 704);
        self.chalkDrawing.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nav animated:YES completion:nil];
        
    }];
}

-(IBAction)loadTemplate1:(id)sender
{
    NSDictionary *theme = @{
                            @"initial-text-color" : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                            @"initial-text-font" : [UIFont  fontWithName:@"Avenir" size:17.0],
                            @"initial-button-text-color" :[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                            @"initial-button-text-font" : [UIFont systemFontOfSize:13.0],
                            @"initial-button-background-color" : [UIColor darkGrayColor],
                            @"initial-document-background-color" : [UIColor darkGrayColor],
                            @"initial-page-background-color" : [UIColor colorWithWhite:1.000 alpha:1.000]
                            };
    
    
    HyprEditorViewController * editor = [[HyprEditorViewController alloc] initWithNibName:@"HyprEditorViewController" bundle:nil withThemePack:theme];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editor];
    
    //We need to move out the scrollview
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.scrollView.frame = CGRectMake(0, 768, 1024, 704);
        self.chalkDrawing.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nav animated:YES completion:nil];
        
                
        UIGraphicsBeginImageContext(CGSizeMake(600, 126));
        [[UIColor colorWithRed:0.338 green:0.253 blue:0.593 alpha:1.000] set];
        
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, 600, 126));
        
        UIImage *purpleBanner = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        HyprImageWidget *image = [[HyprImageWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(0, 0, 600, 126) withImage:purpleBanner];
        
        [editor.onscreenWidgets addObject:image];
        [editor.contentScrollView addSubview:image.view];
        
        //Load in template elements
        HyprTextWidget *banner = [[HyprTextWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(0, 48, 600, 100) initialText:@"Today In History" initialColor:[UIColor whiteColor] initialFont:[UIFont fontWithName:@"Avenir-Heavy" size:60.0]];
        
        banner.textAlign = NSTextAlignmentCenter;
        
        [editor.onscreenWidgets addObject:banner];
        [editor.contentScrollView addSubview:banner.view];

        HyprImageWidget *topPhoto = [[HyprImageWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(40, 166, 330, 193) withImage:[UIImage imageNamed:@"brawl.png"]];
        
        [editor.onscreenWidgets addObject:topPhoto];
        [editor.contentScrollView addSubview:topPhoto.view];
        
        HyprTextWidget *paragraph1 = [[HyprTextWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(393, 166, 166, 130) initialText:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua" initialColor:[UIColor colorWithHexString:@"#222222" withAlpha:1.0] initialFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0]];
        
        paragraph1.textAlign = NSTextAlignmentLeft;
        
        [editor.onscreenWidgets addObject:paragraph1];
        [editor.contentScrollView addSubview:paragraph1.view];
        
        
        HyprButtonWidget *button = [[HyprButtonWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(393, 316, 166, 44) initialText:@"Click Me" initialColor:[UIColor whiteColor] initialFont:[UIFont fontWithName:@"Avenir-Heavy" size:14.0] initialButtonColor:[UIColor colorWithRed:0.335 green:0.253 blue:0.589 alpha:1.000]];
        
        button.link = @"http://en.wikipedia.org/wiki/Houdini";
        
        [editor.onscreenWidgets addObject:button];
        [editor.contentScrollView addSubview:button.view];
        
        HyprTextWidget *paragaph2 = [[HyprTextWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(40, 391, 520, 70) initialText:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua" initialColor:[UIColor colorWithHexString:@"#222222" withAlpha:1.0] initialFont:[UIFont fontWithName:@"Avenir-Oblique" size:16.0]];
        
        paragaph2.textAlign = NSTextAlignmentLeft;
        
        [editor.onscreenWidgets addObject:paragaph2];
        [editor.contentScrollView addSubview:paragaph2.view];
        
        HyprImageWidget *houd1 = [[HyprImageWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(40, 460, 160, 160) withImage:[UIImage imageNamed:@"houdini1.png"]];
        
        [editor.onscreenWidgets addObject:houd1];
        [editor.contentScrollView addSubview:houd1.view];
        
        HyprImageWidget *houd2 = [[HyprImageWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(220, 460, 160, 160) withImage:[UIImage imageNamed:@"houdini2.png"]];
        
        [editor.onscreenWidgets addObject:houd2];
        [editor.contentScrollView addSubview:houd2.view];
        
        HyprImageWidget *houd3 = [[HyprImageWidget alloc] initWithDocumentEditor:editor withInitialLocation:CGRectMake(400, 460, 160, 160) withImage:[UIImage imageNamed:@"houdini3.png"]];
        
        [editor.onscreenWidgets addObject:houd3];
        [editor.contentScrollView addSubview:houd3.view];
    }];

}

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
};

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Prep animation
    
    self.scrollView.frame = CGRectMake(0, 768, 1024, 704);
    self.chalkDrawing.alpha = 0.0;

}

-(void)viewDidAppear:(BOOL)animated
{
    //Run animation
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.frame = CGRectMake(0, 44.0, 1024, 704);
        self.chalkDrawing.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        [NSTimer scheduledTimerWithTimeInterval:5.0 block:^{
            
            [UIView animateWithDuration:1.0 animations:^{
                self.chalkDrawing.alpha = 0.0;
            }];
            
        } repeats:NO];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
