//
//  ExpandableTableView.h
//  Demo
//
//  Created by EcoMail on 01/04/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableTableView : UITableViewController


- (NSMutableArray *)getParentRowsData;
- (NSMutableArray *)getChildRowsDataInParent:(NSInteger)Parent;
- (void)didSelectParentAtIndex:(NSInteger)Parent;
- (void)didSelectChildRow:(NSInteger)Child InParent:(NSInteger)Parent;


@end
