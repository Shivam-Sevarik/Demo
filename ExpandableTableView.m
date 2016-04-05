//
//  ExpandableTableView.m
//  Demo
//
//  Created by EcoMail on 01/04/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import "ExpandableTableView.h"
#import "ExpandableCell.h"
#import "ExpandableTable.h"

@interface ExpandableTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *marrayParentData,*marrayChildData,*marrayTableData,*marrayExpandedSections;
    NSIndexPath *indexPathRows;
    BOOL isExpanded;
    NSInteger expandedSection,currentSection;
}
@property(strong,nonatomic) IBOutlet UITableView *tableExpandable;
@property(strong,nonatomic) IBOutlet UIView *headerView;
@property(strong,nonatomic) IBOutlet UILabel *headerLabel;
@property(strong,nonatomic) IBOutlet UIImageView *headerArrow;
@end

@implementation ExpandableTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    marrayTableData = [[NSMutableArray alloc] init];
    marrayExpandedSections = [[NSMutableArray alloc] init];
    
    
    marrayParentData = [[NSMutableArray alloc] initWithObjects:@"Parent Header 1",@"Parent Header 2", nil];
    marrayChildData = [[NSMutableArray alloc] initWithObjects:@"Child Row 1",@"Child Row 2",@"Child Row 3", nil];
    
    for (int i = 0 ; i < [[self getParentRowsData] count]; i++)
    {
        NSMutableDictionary *mdict = [[NSMutableDictionary alloc] init];
        
        
        [mdict setValue:[[self getParentRowsData] objectAtIndex:i] forKey:@"ParentTitle"];
        [mdict setValue:[self getChildRowsDataInParent:i] forKey:@"childData"];
        
        [marrayTableData addObject:mdict];
    }
    
    isExpanded = NO;
    expandedSection = currentSection = -1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionHeaderButton:(id)sender
{
    
}



- (NSMutableArray *)getParentRowsData
{
    
    return marrayParentData;
}

- (NSMutableArray *)getChildRowsDataInParent:(NSInteger)Parent
{
    if (Parent == 0)
    {
        return marrayChildData;
    }
    else
    {
        NSArray *arr = @[@"Second",@"third"];
        return (NSMutableArray *)arr;
    }
    
}



- (NSArray *)getChildTitleArrayForParent:(NSInteger)Parent
{
    return [[marrayTableData valueForKey:@"childData"] objectAtIndex:Parent];
}


- (NSString *)titleForParentRowAtIndex:(NSInteger)index
{
    
    return [[marrayTableData objectAtIndex:index] valueForKey:@"ParentTitle"];
}


- (NSInteger)getNumberOfChildRowsForSection:(NSInteger)section
{
 if ([marrayExpandedSections containsObject:[NSNumber numberWithInteger:section]])
    {
        return [[[marrayTableData objectAtIndex:section]valueForKey:@"childData"] count];
    }
    else
    {
        return 0;
    }
    
}

- (void)headerButtonTappedInSection:(UIGestureRecognizer *)section
{
    
    NSInteger sectionTag = section.view.tag;
    
    NSRange range;
    range.location = 0;
    NSInteger count = [[[marrayTableData objectAtIndex:sectionTag] valueForKey:@"childData"] count];
    
    range.length = count - 1;
    
    if (sectionTag == 1)
    {
        range.length = count;
    }
    
    
    NSMutableArray *marrayIndexP = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:sectionTag];
        [marrayIndexP addObject:path];
    }
    
    
    
    if ([marrayExpandedSections containsObject:[NSNumber numberWithInteger:sectionTag]])
    {
        [marrayExpandedSections removeObject:[NSNumber numberWithInteger:sectionTag]];
//        isExpanded = NO;
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            anyview.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
//        }];
        //expandedSection = -1;
        //[self.tableExpandable reloadRowsAtIndexPaths:(NSArray *)marrayIndexP withRowAnimation:UITableViewRowAnimationTop];
        //[self.tableExpandable reloadSections:[NSIndexSet indexSetWithIndexesInRange:range] withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [marrayExpandedSections addObject:[NSNumber numberWithInteger:sectionTag]];
//        isExpanded = YES;
        //expandedSection = sectionTag;
        //[self.tableExpandable reloadRowsAtIndexPaths:@[indp1] withRowAnimation:UITableViewRowAnimationTop];
        //[self.tableExpandable reloadSections:[NSIndexSet indexSetWithIndexesInRange:range] withRowAnimation:UITableViewRowAnimationBottom];
    }
    
    [self.tableExpandable reloadData];
    [self didSelectParentAtIndex:sectionTag];
}

- (void)didSelectParentAtIndex:(NSInteger)Parent
{
    NSLog(@"didSelectParentAtIndex = %lu",Parent);
}

- (UIView *)getViewForHeaderForSection:(NSInteger)section
{
    UIView *viewh = [UIView new];
    viewh.frame = CGRectMake(0, 400, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    viewh.backgroundColor = [UIColor grayColor];
    viewh.tag = section;
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(viewh.bounds), CGRectGetHeight(viewh.bounds) - 10 )];
    [headerLabel setTextColor:[UIColor whiteColor]];
   
    headerLabel.text = [self titleForParentRowAtIndex:section];

//    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(viewh.bounds) - 50, 5, 30, 30 )];
//    [arrow setImage:[UIImage imageNamed:@"Arrow.png"]];
//    [viewh addSubview:arrow];
    
    [viewh addSubview:headerLabel];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [gesture setNumberOfTapsRequired:1];
    [gesture setNumberOfTouchesRequired:1];
    [gesture addTarget:self action:@selector(headerButtonTappedInSection:)];
    
    [viewh addGestureRecognizer:gesture];
    
    return viewh;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[marrayTableData valueForKey:@"ParentTitle"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return [self getViewForHeaderForSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getNumberOfChildRowsForSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ExpandableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExpandableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSArray *title = [self getChildTitleArrayForParent:indexPath.section];
    cell.lbl.text = [title objectAtIndex:indexPath.row];;
    
    
    return cell;
}

- (void)didSelectChildRow:(NSInteger)Child InParent:(NSInteger)Parent
{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self didSelectChildRow:indexPath.row InParent:indexPath.section];
}
#pragma mark - UITableView Editing

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
