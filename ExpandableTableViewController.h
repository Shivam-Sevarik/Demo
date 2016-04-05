//
//  ExpandableTableViewController.h
//  Demo
//
//  Created by EcoMail on 05/04/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpandableTableViewDelegate <NSObject>

@required
- (NSMutableArray *)getParentRowsData;
- (NSMutableArray *)getChildRowsDataInParent:(NSInteger)Parent;

@optional
- (void)didSelectParentAtIndex:(NSInteger)Parent;
- (void)didSelectChildRow:(NSInteger)Child InParent:(NSInteger)Parent;

@end

@interface ExpandableTableViewController : UITableViewController
{
    id < ExpandableTableViewDelegate > delegate;
}

@property(strong,nonatomic) NSMutableArray *marrayParentData;
@property(strong,nonatomic) NSMutableArray *marrayChildData;

@end
