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
    NSMutableArray *marraySections,*marrayRows,*marrayParentData,*marrayChildData;
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
    
    marraySections = [[NSMutableArray alloc] initWithObjects:@"Section", nil];
    marrayRows = [[NSMutableArray alloc] initWithObjects:@"Rows", nil];
    
    marrayParentData = [[NSMutableArray alloc] init];
    marrayChildData = [[NSMutableArray alloc] initWithObjects:@"Child Row", nil];
    
    Expand = NO;
    
    self.headerLabel.text = @"Header";
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
    //[self.tableExpandable setEditing:YES animated:YES];
    
// for reloading section
//    NSRange range;
//    range.location = 0;
//    range.length = 1;
//    [self.tableExpandable reloadSections:[NSIndexSet indexSetWithIndexesInRange:range] withRowAnimation:UITableViewRowAnimationBottom];

// for reloading rows
    NSIndexPath *idp = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableExpandable reloadRowsAtIndexPaths:@[idp] withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)headerButtonTappedInSection:(UIGestureRecognizer *)section
{
    [marrayChildData addObject:@"Expanded Child Row"];
    
    //[self.tableExpandable reloadRowsAtIndexPaths:ind withRowAnimation:UITableViewRowAnimationBottom];
    
    NSRange range;
    range.location = 0;
    range.length = marrayChildData.count;
    
    [self tableView:self.tableExpandable commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPathRows];
    //[self.tableExpandable reloadSections:[NSIndexSet indexSetWithIndexesInRange:range] withRowAnimation:UITableViewRowAnimationBottom];
}

- (UIView *)getViewForHeaderForSection:(NSInteger)section
{
    UIView *viewh = [UIView new];
    viewh.frame = CGRectMake(0, 400, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    viewh.backgroundColor = [UIColor grayColor];
    viewh.tag = section;
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(viewh.bounds), CGRectGetHeight(viewh.bounds) - 10 )];
    [headerLabel setTextColor:[UIColor whiteColor]];
   
    headerLabel.text = @"Header";  // pass parent array here [array objectatindex section];
    
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"viewForHeaderInSection %ld",(long)section);
    
    return [self getViewForHeaderForSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return marrayChildData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ExpandableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExpandableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lbl.text = [marrayChildData objectAtIndex:indexPath.row];
    
    
    return cell;
}

#pragma mark - UITableView Editing

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [marrayChildData removeObjectAtIndex:indexPath.row];
        
        [self.tableExpandable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        indexPathRows = indexPath;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Title" message:@"Add Title For Row" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            [marrayChildData addObject:textField.text];
        }];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
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
