//
//  FontSelectorMenu.h

#import <UIKit/UIKit.h>

@class FontSelectorMenu;

@protocol FontSelectorDelegate <NSObject>

-(void)setCurrentFont:(NSString*)font fromEditor:(FontSelectorMenu*)editor;

@end

@interface FontSelectorMenu : UITableViewController
{
    NSMutableArray *fontFamilies;
    NSMutableArray *familyNames;
    
    id<FontSelectorDelegate> callback;
}
@property(nonatomic,strong)id callback;
@end
