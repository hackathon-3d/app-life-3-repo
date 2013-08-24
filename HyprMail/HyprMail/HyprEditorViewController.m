//
//  HyprEditorViewController.m
//  HyprMail
//
//  Created by Brendan Lee on 8/23/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "HyprEditorViewController.h"
#import "HyprImageWidget.h"
#import "HyprTextWidget.h"
#import "HyprButtonWidget.h"
#import "HyprEditorWidgetCell.h"
#import "UIColor+HexString.h"
#import "SessionManager.h"
#import "HyprYoutubeWidget.h"
#import "MBProgressHUD.h"

#import "HyprNewsGroupsPickerViewController.h"


@interface HyprEditorViewController ()

@end

@implementation HyprEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withThemePack:(NSDictionary*)theme
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.availableWidgets = [NSMutableArray array];
        
        [self.availableWidgets addObject:@{@"title": @"Text", @"icon" : @"tileText.png", @"drag-large" : @"previewText.png"}];
        [self.availableWidgets addObject:@{@"title": @"Button", @"icon" : @"tileButton.png", @"drag-large" : @"buttonPreview.png"}];
        [self.availableWidgets addObject:@{@"title": @"Image", @"icon" : @"tileImage.png", @"drag-large" : @"previewImage.png"}];
        [self.availableWidgets addObject:@{@"title": @"Video", @"icon" : @"tileVideo.png", @"drag-large" : @"previewVideo.png"}];
        
        self.onscreenWidgets = [NSMutableArray array];
        
        self.theme = theme;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.widgetTableView registerNib:[UINib nibWithNibName:@"HyprEditorWidgetCell" bundle:nil] forCellReuseIdentifier:@"HyprEditorWidgetCell"];
    self.widgetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = self.theme[@"initial-document-background-color"];
    self.contentScrollView.backgroundColor = self.theme[@"initial-page-background-color"];
    
    UILongPressGestureRecognizer *longPresser = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressInTableView:)];
    longPresser.minimumPressDuration = 0.001;
    longPresser.delegate = self;
    
    [self.widgetTableView addGestureRecognizer:longPresser];
    
    UITapGestureRecognizer *doubleTapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapInPage:)];
    doubleTapper.numberOfTapsRequired = 2;
    
    [self.contentScrollView addGestureRecognizer:doubleTapper];
    
    self.title = @"Design Email";
    
    self.contentScrollView.contentInset = UIEdgeInsetsMake(60.0, 0.0, 60.0, 0.0);
    self.contentScrollView.scrollIndicatorInsets = self.contentScrollView.contentInset;
    self.contentScrollView.contentSize = CGSizeMake(600, 2000);
    
    //Page illusions
    self.pageTopIllusionView = [[UIView alloc] initWithFrame:CGRectMake(0, -500.0, self.contentScrollView.frame.size.width, 500.0)];
    
    self.pageTopIllusionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.pageTopIllusionView.backgroundColor = self.view.backgroundColor;
    
    [self.contentScrollView addSubview:self.pageTopIllusionView];
    
    
    self.pageBottomIllusionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentScrollView.contentSize.height, self.contentScrollView.frame.size.width, 500.0)];
    
    self.pageBottomIllusionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.pageBottomIllusionView.backgroundColor = self.view.backgroundColor;
    
    [self.contentScrollView addSubview:self.pageBottomIllusionView];
    
    self.pageColor = self.theme[@"initial-page-background-color"];
    self.documentColor = self.theme[@"initial-document-background-color"];
    
    self.widgetTableView.backgroundColor = [UIColor colorWithHexString:@"#222222" withAlpha:1.0];
    self.widgetTableView.backgroundView = [[UIView alloc] init];
    self.widgetTableView.backgroundView.backgroundColor = self.widgetTableView.backgroundColor;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(next)];
}

-(void)cancel
{
    //Animate it out and dismiss
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.contentScrollView.frame = CGRectMake(112, 768, 600, 704);
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];

}

-(void)next
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText = @"Uploading Email";
    [self.view addSubview:hud];
    [hud show:YES];
    

        
        UIImage *canvasImage = [self renderCanvasToImage];
        
//        NSString *filePath = [[NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]] stringByAppendingPathExtension:@"png"];
//        NSString *htmlPath = [[NSTemporaryDirectory() stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]] stringByAppendingPathExtension:@"html"];
    
        //[UIImageJPEGRepresentation(canvasImage, 0.8) writeToFile:filePath atomically:NO];
        
        
        NSURLRequest *formUploadRequest = [[[SessionManager sharedSession] APIClient] multipartFormRequestWithMethod:@"POST" path:@"upload.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:UIImagePNGRepresentation(canvasImage) name:@"file" fileName:@"email-image.png" mimeType:@"image/png"];
        }];
        
        AFJSONRequestOperation *uploadRequest = [AFJSONRequestOperation JSONRequestOperationWithRequest:formUploadRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            NSLog(@"%@",JSON);
            
            NSDictionary *JSONDic = (NSDictionary*)JSON;
            
            if (JSONDic && [JSONDic[@"status"] isEqualToString:@"Good"]) {
                //Time to ready the HTML!
                
                NSString *html = [self generateHTMLWithMainImageFileURL:JSONDic[@"file_url"]];
                
                //[[html dataUsingEncoding:NSUTF8StringEncoding] writeToFile:htmlPath atomically:NO];
                
                HyprNewsGroupsPickerViewController *newsGroup = [[HyprNewsGroupsPickerViewController alloc] initWithNibName:@"HyprNewsGroupsPickerViewController" bundle:nil];
                
                newsGroup.htmlContent = html;
                
                // NSLog(html);
                
                    [hud hide:YES];
                    [self.navigationController pushViewController:newsGroup animated:YES]; 
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:JSONDic[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }];
    
    [uploadRequest setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        double totalBytesD = (double)totalBytesRead;
        double totalBytesExpectedD = (double)totalBytesExpectedToRead;
        
        hud.progress = totalBytesD/totalBytesExpectedD;
    }];
        
        uploadRequest.JSONReadingOptions = NSJSONReadingAllowFragments;
        
        [[[SessionManager sharedSession] APIClient] enqueueHTTPRequestOperation:uploadRequest];
        
    
    
    
    
    //Animate it out and next screen

    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        self.contentScrollView.frame = CGRectMake(112, 768, 600, 704);
//        
//    } completion:^(BOOL finished) {
        
//    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Prep animation
    
    self.contentScrollView.frame = CGRectMake(112, 768, 600, 704);
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //Run animation
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentScrollView.frame = CGRectMake(112, 0.0, 600, 704);
    } completion:^(BOOL finished) {
        
    }];
}



-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        if (self.tempDragActive) {
            return NO;
        }
    }
    
    return YES;
}

-(void)doubleTapInPage:(UITapGestureRecognizer*)tapper
{
    //Turn all widgets to 'no resizing'
    
    
    BOOL isInsideWidget = NO;
    
    NSArray *fastEnum = [self.onscreenWidgets copy];
    
    for (HyprWidget *widget in fastEnum) {
        
        if (CGRectContainsPoint(CGRectMake(widget.x, widget.y, widget.width, widget.height), [tapper locationInView:self.contentScrollView])) {
            isInsideWidget = YES;
        }
        
    }
    
    if (!isInsideWidget) {
        for (HyprWidget *widget in fastEnum) {
            
            [widget endResizing];
            
        }
    }
    
    
}

-(void)longPressInTableView:(UILongPressGestureRecognizer*)panRecog
{
    
    
    if (panRecog.state == UIGestureRecognizerStateBegan)
    {
        //Discover proper cell
        CGPoint p = [panRecog locationInView:self.widgetTableView];
        NSIndexPath *indexPath = [self.widgetTableView indexPathForRowAtPoint:p];
        
        if (indexPath != nil) {
            
            self.tempDragIndex = indexPath.row;
            
            if (indexPath.row<0 || self.tempDragIndex>self.availableWidgets.count) {
                return;
            }
            
            NSDictionary *info = self.availableWidgets[self.tempDragIndex];
            
            self.tempDragImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
            self.tempDragImageView.image = [UIImage imageNamed:info[@"icon"]];
            
            self.tempDragImageView.center = [panRecog locationInView:self.view];
            
            self.tempDragImageView.alpha = 0.0;
            
            [self.view addSubview:self.tempDragImageView];
            
            [self.view bringSubviewToFront:self.tempDragImageView];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.tempDragImageView.alpha = 1.0;
            }];
            
            self.tempDrawWasLastInTableView = YES;
            self.tempDragActive = YES;
            
            return;
            
        }
        else
        {
            self.tempDragIndex = -1;
            self.tempDrawWasLastInTableView = NO;
            self.tempDragActive = NO;
            [self.tempDragImageView removeFromSuperview];
            self.tempDragImageView = nil;
        }
    }
    
    if (panRecog.state == UIGestureRecognizerStateChanged)
    {
        if (self.tempDragActive) {
            
            self.tempDragImageView.center = [panRecog locationInView:self.view];
            
            //If we crossed the tableview boundary, time to morph!
            
            NSDictionary *info = self.availableWidgets[self.tempDragIndex];
            
            BOOL currentlyInsideTableView = [panRecog locationInView:self.widgetTableView].x >=0;
            
            if (currentlyInsideTableView != self.tempDrawWasLastInTableView) {
                
                if (currentlyInsideTableView) {
                    //Morph back into smaller size
                    
                    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
                        
                        self.tempDragImageView.bounds = CGRectMake(0, 0, 75, 75);
                        self.tempDragImageView.center = [panRecog locationInView:self.view];
                        
                    } completion:^(BOOL finished) {
                        self.tempDragImageView.image = [UIImage imageNamed:info[@"icon"]];
                    }];
                }
                else
                {
                    //Morph into bigger size
                    self.tempDragImageView.image = [UIImage imageNamed:info[@"drag-large"]];
                    
                    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
                        
                        self.tempDragImageView.bounds = CGRectMake(0, 0, self.tempDragImageView.image.size.width, self.tempDragImageView.image.size.height);
                        self.tempDragImageView.center = [panRecog locationInView:self.view];
                        
                    } completion:^(BOOL finished) {
                    }];
                }
                
                self.tempDrawWasLastInTableView = currentlyInsideTableView;
            }
            
            return;
            
        }
    }
    
    if (panRecog.state == UIGestureRecognizerStateEnded)
    {
        CGPoint locInsidePage = [panRecog locationInView:self.contentScrollView];
        
        if (locInsidePage.x-((self.tempDragImageView.image.size.width)/2.0)>=0 && locInsidePage.x+((self.tempDragImageView.image.size.width)/2.0)<self.contentScrollView.frame.size.width && self.tempDragImageView.frame.origin.y>=60 && locInsidePage.y+((self.tempDragImageView.image.size.height)/2.0)<self.contentScrollView.contentSize.height) {
            
            //We can accept this one!
            NSDictionary *info = self.availableWidgets[self.tempDragIndex];
            
            HyprWidget * newWidget = [self createItem:info atLocation:[self.contentScrollView convertRect:self.tempDragImageView.frame fromView:self.view]];
            
            [self.contentScrollView addSubview:newWidget.view];
            
            [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
                
                self.tempDragImageView.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                //Cleanup
                self.tempDragIndex = -1;
                self.tempDrawWasLastInTableView = NO;
                self.tempDragActive = NO;
                [self.tempDragImageView removeFromSuperview];
                self.tempDragImageView = nil;
            }];
            
        }
        else
        {
            //Nope, send it on back!
            
            HyprEditorWidgetCell *editorCell = (HyprEditorWidgetCell*)[self.widgetTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.tempDragIndex inSection:0]];
            
            CGRect animateEndLocation = [self.view convertRect:editorCell.widgetImage.frame fromView:editorCell];
            
            [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
                
                self.tempDragImageView.frame = animateEndLocation;
                self.tempDragImageView.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                //Cleanup
                self.tempDragIndex = -1;
                self.tempDrawWasLastInTableView = NO;
                self.tempDragActive = NO;
                [self.tempDragImageView removeFromSuperview];
                self.tempDragImageView = nil;
            }];
        }
    }
    
    if (panRecog.state == UIGestureRecognizerStateCancelled) {
        
        HyprEditorWidgetCell *editorCell = (HyprEditorWidgetCell*)[self.widgetTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.tempDragIndex inSection:0]];
        
        CGRect animateEndLocation = [self.view convertRect:editorCell.widgetImage.frame fromView:editorCell];
        
        [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
            
            self.tempDragImageView.frame = animateEndLocation;
            self.tempDragImageView.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            //Cleanup
            self.tempDragIndex = -1;
            self.tempDrawWasLastInTableView = NO;
            self.tempDragActive = NO;
            [self.tempDragImageView removeFromSuperview];
            self.tempDragImageView = nil;
        }];
        
    }
}

-(HyprWidget*)createItem:(NSDictionary*)item atLocation:(CGRect)location
{
    location = CGRectMake(location.origin.x-10, location.origin.y-10, location.size.width+20, location.size.height+20);
    
    if ([item[@"title"] isEqualToString:@"Image"]) {
        
        HyprImageWidget *imageWid= [[HyprImageWidget alloc] initWithDocumentEditor:self withInitialLocation:location withImage:[UIImage imageNamed:item[@"drag-large"]]];
        
        [self.onscreenWidgets addObject:imageWid];
        //[self.contentScrollView addSubview:imageWid.view];
        
        return imageWid;
    }
    
    if ([item[@"title"] isEqualToString:@"Text"]) {
        HyprTextWidget *textWid = [[HyprTextWidget alloc] initWithDocumentEditor:self withInitialLocation:location initialText:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit." initialColor:self.theme[@"initial-text-color"] initialFont:self.theme[@"initial-text-font"]];
        
        [self.onscreenWidgets addObject:textWid];
        //[self.contentScrollView addSubview:textWid.view];
        
        return textWid;
    }
    
    if ([item[@"title"] isEqualToString:@"Button"]) {
        HyprButtonWidget *buttonWid = [[HyprButtonWidget alloc] initWithDocumentEditor:self withInitialLocation:location initialText:@"New Button" initialColor:self.theme[@"initial-button-text-color"] initialFont:self.theme[@"initial-button-text-font"] initialButtonColor:self.theme[@"initial-button-background-color"]];
        
        [self.onscreenWidgets addObject:buttonWid];
        //[self.contentScrollView addSubview:buttonWid.view];
        
        //buttonWid.link = @"http://google.com";
        
        return buttonWid;
    }
    
    if ([item[@"title"] isEqualToString:@"Video"]) {
        
        HyprYoutubeWidget *imageWid= [[HyprYoutubeWidget alloc] initWithDocumentEditor:self withInitialLocation:location withImage:nil];
        
        [self.onscreenWidgets addObject:imageWid];
        //[self.contentScrollView addSubview:imageWid.view];
        
        return imageWid;
    }
    
    return nil;
}

-(IBAction)showPageOptionsActionSheet:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Page Color", @"Background Color", nil];
    [action showFromRect:[sender bounds] inView:sender animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
        documentPropertiesAlter = buttonIndex;
    
    if (documentPropertiesAlter>=0) {
        FCColorPickerViewController * picker = [[FCColorPickerViewController alloc] initWithNibName:@"FCColorPickerViewController" bundle:nil];
        picker.delegate = self;
        
        if (documentPropertiesAlter==1) {
            picker.color = self.pageColor;
        }
        else
        {
            picker.color = self.documentColor;
        }
        
        [self clearPopover];
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        self.popover.delegate = self;
        
        [self.popover presentPopoverFromRect:self.pageSettignsButton.bounds inView:self.pageSettignsButton permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self clearPopover];
}

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color
{
    if (documentPropertiesAlter==1) {
        self.pageColor = color;
        self.view.backgroundColor = self.pageColor;
        
        self.pageBottomIllusionView.backgroundColor = self.pageColor;
        self.pageTopIllusionView.backgroundColor = self.pageColor;
    }
    
    if (documentPropertiesAlter==0) {
        self.documentColor = color;
        self.contentScrollView.backgroundColor = self.documentColor;
    }
    
    colorPicker.delegate = nil;
    
    
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    colorPicker.delegate = nil;
}

-(void)clearPopover
{
    if (self.popover) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        self.popover.delegate = nil;
        self.popover = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.availableWidgets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HyprEditorWidgetCell";
    HyprEditorWidgetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *info = self.availableWidgets[indexPath.row];
    
    cell.widgetImage.image = [UIImage imageNamed:info[@"icon"]];
    cell.widgetTitle.text = info[@"title"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

-(UIImage*)renderCanvasToImage
{
    NSArray *fastEnum = [self.onscreenWidgets copy];
    
    float lowestPoint = 0.0;
    
    for (HyprWidget *widget in fastEnum) {
        
        if (widget.y+widget.height+20 > lowestPoint) {
            lowestPoint = widget.y+widget.height+20;
        }
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(self.contentScrollView.frame.size.width, lowestPoint));
    
    [self.pageColor set];
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.contentScrollView.frame.size.width, lowestPoint));
    
    //Time for fast enum for elements! Hazzah!
    for (HyprWidget *widget in fastEnum) {
        
        if (widget.view) {
            
            if ([widget.view.contentView isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView*)widget.view.contentView;
                
                [imageView.image drawInRect:CGRectMake(widget.x, widget.y, widget.width, widget.height)];
            }
            else
            {
                [widget.view.contentView drawRect:CGRectMake(widget.x, widget.y, widget.width, widget.height)];
            }
        }
    }
    
    
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    return imageResult;
}

-(NSString*)generateHTMLWithMainImageFileURL:(NSString*)fileURL
{
    NSMutableString *html = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"<body style=\"min-width: 100%%\" bgcolor=\"%@\"><center><img width=\"600\" src=\"%@\" usemap=\"#email_map\"/><map name=\"email_map\">", [self.documentColor htmlFromUIColor], fileURL]];
    
    //Now we need to process image maps for all of these things.
    
    NSArray *fastEnum = [self.onscreenWidgets copy];
    
    for (HyprWidget *widget in fastEnum) {
        
        if (widget.link && widget.link.length>0) {
            [html appendString:[NSString stringWithFormat:@"<area shape=\"rect\" coords=\"%d,%d,%d,%d\" href=\"%@\" title=\"%@\" alt=\"%@\">", (int)widget.x, (int)widget.y, (int)(widget.x+widget.width), (int)(widget.y+widget.height), widget.link, widget.typeName, widget.typeName]];
        }
    }
    
    [html appendString:@"</map></center></body>"];
    
    return html;
}

-(IBAction)testRenderCanvas:(id)sender
{

}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
