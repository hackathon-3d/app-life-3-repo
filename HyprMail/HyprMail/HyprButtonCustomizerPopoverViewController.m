//
//  HyprButtonCustomizerPopoverViewController.m
//  HyprMail
//
//  Created by Brendan Lee on 8/24/13.
//  Copyright (c) 2013 52apps. All rights reserved.
//

#import "UIColor+HexString.h"
#import "HyprButtonWidget.h"

#import "HyprButtonCustomizerPopoverViewController.h"

@interface HyprButtonCustomizerPopoverViewController ()

@end

@implementation HyprButtonCustomizerPopoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Button Settings";
    self.contentSizeForViewInPopover = CGSizeMake(320, 300);
    self.fontSizeStepper.value = self.widget.font.pointSize;
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = nil;
    cell.accessoryView = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"Title";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"Link";
            
            if (!self.widget.link) {
                self.widget.link = @"";
            }
            
            UILabel *preparedLabel = [self preparedLabel];
            preparedLabel.frame = CGRectMake(0, 0, 200, 44.0);
            preparedLabel.text = [self.widget.link  stringByAppendingString:@"  "];
            cell.accessoryView = preparedLabel;
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"Font";
            
            UILabel *preparedLabel = [self preparedLabel];
            preparedLabel.frame = CGRectMake(0, 0, 200, 44.0);
            preparedLabel.text = [self.widget.font.fontName  stringByAppendingString:@"  "];
            cell.accessoryView = preparedLabel;
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"Text Color";
            
            UILabel *preparedLabel = [self preparedLabel];
            
            preparedLabel.font = [UIFont fontWithName:[self.widget.font.fontName stringByAppendingString:@"-Bold"] size:preparedLabel.font.pointSize];
            preparedLabel.textColor = self.widget.color;
            preparedLabel.text = [[self.widget.color htmlFromUIColor] stringByAppendingString:@"  "];
            
            cell.accessoryView = preparedLabel;
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"Background Color";
            
            UILabel *preparedLabel = [self preparedLabel];
            preparedLabel.font = [UIFont fontWithName:[self.widget.font.fontName stringByAppendingString:@"-Bold"] size:preparedLabel.font.pointSize];
            preparedLabel.textColor = self.widget.buttonColor;
            preparedLabel.text = [[self.widget.buttonColor htmlFromUIColor]  stringByAppendingString:@"  "];
            cell.accessoryView = preparedLabel;
        }
            break;
        case 5:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%d pts  ", (int)self.widget.font.pointSize];
            cell.accessoryView = self.fontSizeStepper;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
            break;
        
            
        default:
            break;
    }
    
    return cell;
}

-(UILabel*)preparedLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44.0)];
    label.textColor = [UIColor colorWithHexString:@"#374C7C" withAlpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Avenir" size:15.0];
    label.textAlignment = NSTextAlignmentRight;
    
    return label;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    switch (indexPath.row) {
        case 0:
        {
            indexBeingChanged = 0;
            
            HyprSettingsTextFieldViewController *textSettings = [[HyprSettingsTextFieldViewController alloc] initWithNibName:@"HyprSettingsTextFieldViewController" bundle:nil];
            textSettings.textDelegate = self;
            
            [self.navigationController pushViewController:textSettings animated:YES];
            textSettings.textView.text = self.widget.text;
        }
            break;
        case 1:
        {
            indexBeingChanged = 1;
            
            HyprSettingsTextFieldViewController *textSettings = [[HyprSettingsTextFieldViewController alloc] initWithNibName:@"HyprSettingsTextFieldViewController" bundle:nil];
            textSettings.textDelegate = self;
            
            [self.navigationController pushViewController:textSettings animated:YES];
            textSettings.textView.text = self.widget.link;
        }
            break;
        case 2:
        {
            indexBeingChanged = 2;
            FontSelectorMenu *fontSel = [[FontSelectorMenu alloc] initWithNibName:@"FontSelectorMenu" bundle:nil];
            
            fontSel.callback = self;
            [self.navigationController pushViewController:fontSel animated:YES];
        }
            break;
        case 3:
        {
            indexBeingChanged = 3;
            
            FCColorPickerViewController * picker = [[FCColorPickerViewController alloc] initWithNibName:@"FCColorPickerViewController" bundle:nil];
            picker.delegate = self;
            [self.navigationController pushViewController:picker animated:YES];
            picker.color = self.widget.color;
        }
            break;
        case 4:
        {
            indexBeingChanged = 4;
            FCColorPickerViewController * picker = [[FCColorPickerViewController alloc] initWithNibName:@"FCColorPickerViewController" bundle:nil];
            picker.delegate = self;
            
            [self.navigationController pushViewController:picker animated:YES];
            picker.color = self.widget.buttonColor;

        }
            break;
        case 5:
        {
            indexBeingChanged = 5;
        }
            break;
            
            
        default:
            break;
    }
}

-(IBAction)updatePointSize:(id)sender
{
    self.widget.font = [UIFont fontWithName:self.widget.font.fontName size:self.fontSizeStepper.value];
    
    [self.widget.view.contentView setNeedsDisplay];
    [self.tableView reloadData];
}

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color
{
    switch (indexBeingChanged) {
        case 3:
            self.widget.color = color;
            [self.widget.view.contentView setNeedsDisplay];
            break;
        case 4:
            self.widget.buttonColor = color;
            [self.widget.view.contentView setNeedsDisplay];
            break;
            
        default:
            break;
    }
    
    colorPicker.delegate = nil;
    [self.tableView reloadData];
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    colorPicker.delegate = nil;
}

-(void)textDidChangeTo:(NSString *)text fromEditor:(HyprSettingsTextFieldViewController*)editor
{
    switch (indexBeingChanged) {
        case 0:
            self.widget.text = text;
            [self.widget.view.contentView setNeedsDisplay];
            break;
        case 1:
            self.widget.link = text;
            [self.widget.view.contentView setNeedsDisplay];
            break;
            
        default:
            break;
    }
    
    editor.textDelegate = nil;
    [self.tableView reloadData];
}

-(void)setCurrentFont:(NSString *)font fromEditor:(FontSelectorMenu *)editor
{
    switch (indexBeingChanged) {
        case 2:
            self.widget.font = [UIFont fontWithName:font size:self.widget.font.pointSize];
            [self.widget.view.contentView setNeedsDisplay];
            break;
            
        default:
            break;
    }
    
    editor.callback = nil;
    [self.tableView reloadData];
}
@end
