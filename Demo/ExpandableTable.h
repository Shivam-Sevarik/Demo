//
//  ExpandableTable.h
//  Demo
//
//  Created by EcoMail on 05/04/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpandableTable : NSObject

@property(strong,nonatomic) NSMutableArray *marrayParentData;
@property(strong,nonatomic) NSMutableArray *marrayChildData;

- (NSMutableArray *)getParentRowsData;
- (NSMutableArray *)getChildRowsDataInParent:(NSInteger)Parent;
- (void)didSelectParentAtIndex:(NSInteger)Parent;
- (void)didSelectChildRow:(NSInteger)Child InParent:(NSInteger)Parent;

@end
