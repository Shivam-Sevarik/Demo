//
//  ExpandableTableView.m
//  Demo
//
//  Created by EcoMail on 01/04/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import "ExpandableTableView.h"
#import "ExpandableCell.h"


@interface ExpandableTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *marrayParentData,*marrayChildData;
    NSIndexPath *indexPathRows;
    BOOL Expand;
}
@property(strong,nonatomic) IBOutlet UITableView *tableExpandable;
@property(strong,nonatomic) IBOutlet UIView *headerView;
@property(strong,nonatomic) IBOutlet UILabel *headerLabel;
@property(strong,nonatomic) IBOutlet UIImageView *headerArrow;
@end

@implementation ExpandableTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    marrayParentData = [[NSMutableArray alloc] init];
    marrayChildData = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < [self numberOfParentRowsInTableview]; i++)
    {
        NSString *strP = [NSString stringWithFormat:@"Parent Header %i",i];
        NSMutableDictionary *mdict = [[NSMutableDictionary alloc] init];
        
        NSInteger rowCount = [self numberOfChildRowsInParent:i];
        
        [mdict setValue:strP forKey:@"ParentTitle"];
        [mdict setValue:[NSNumber numberWithInteger:rowCount]  forKey:@"rowCount"];
        
        [marrayParentData addObject:mdict];
        
    }
    
    
    Expand = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionHeaderButton:(id)sender
{
    
}

- (NSInteger)numberOfParentRowsInTableview
{
    return 2;
}

- (NSString *)titleForChildRowsInParent:(NSInteger)Parent
{
    if (Parent == 0)
    {
        marrayChildData = [[NSMutableArray alloc] initWithObjects:@"one", nil];
        return [marrayChildData objectAtIndex:Parent];
    }
    else
    {
        marrayChildData = [[NSMutableArray alloc] initWithObjects:@"one",@"two",@"three", nil];
        return [marrayChildData objectAtIndex:Parent];
    }
    
}


- (NSString *)titleForParentRowAtIndex:(NSInteger)index
{
    return [[marrayParentData objectAtIndex:index] valueForKey:@"ParentTitle"];
}

- (NSInteger)numberOfChildRowsInParent:(NSInteger)Parent
{
    if (Parent == 0)
    {
        return 1;
    }
    else
    {
        return 3;
    }
}

- (NSInteger)getNumberOfChildRowsForSection:(NSInteger)section
{
    return [[[marrayParentData objectAtIndex:section]valueForKey:@"rowCount"] integerValue];
    ;
}

- (void)headerButtonTappedInSection:(UIGestureRecognizer *)section
{
    NSInteger sectionTag = section.view.tag;
    NSString *childRow = [NSString stringWithFormat:@"Child Row %lu",(long)sectionTag + 1];
    [marrayChildData addObject:childRow];
    
    
    [self.tableExpandable reloadData];
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
    return marrayParentData.count;
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
    
    cell.lbl.text = [self titleForChildRowsInParent:indexPath.row];
    
    
    return cell;
}

#pragma mark - UITableView Editing

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
