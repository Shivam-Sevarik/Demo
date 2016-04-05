//
//  ExpandableTable.m
//  Demo
//
//  Created by EcoMail on 05/04/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import "ExpandableTable.h"

@implementation ExpandableTable


@synthesize marrayChildData;
@synthesize marrayParentData;

- (NSMutableArray *)getParentRowsData
{
    return marrayParentData;
}

-(NSMutableArray *)getChildRowsDataInParent:(NSInteger)Parent
{
    return marrayChildData;
}
- (void)didSelectParentAtIndex:(NSInteger)Parent
{
    
}
- (void)didSelectChildRow:(NSInteger)Child InParent:(NSInteger)Parent
{
    
}


@end
