//
//  HyprTemplateSelectionViewController.h
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HyprTemplateSelectionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *templatesContainer;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *chalkDrawing;
@property (strong, nonatomic) IBOutlet UIButton *templateButton1;
@property (strong, nonatomic) IBOutlet UIButton *templateButton2;
@property (strong, nonatomic) IBOutlet UIButton *templateButton3;
@property (strong, nonatomic) IBOutlet UIButton *templateButton4;

@end
