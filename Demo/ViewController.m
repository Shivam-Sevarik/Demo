//
//  ViewController.m
//  Demo
//
//  Created by EcoMail on 17/03/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import "ViewController.h"
#import "ExpandableTableViewController.h"

@interface ViewController ()<UITextFieldDelegate,ExpandableTableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property(strong,nonatomic) IBOutlet UILabel *lbl1,*lbl2;
@property (strong, nonatomic) IBOutlet UITextField *txtstring;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)action_Btn1:(id)sender
{
    self.lbl1.text = self.txtstring.text;
}
- (IBAction)action_Btn2:(id)sender
{
    
}

- (NSMutableArray *)getParentRowsData
{
    return (NSMutableArray *)@[@"one",@"two"];
}
- (NSMutableArray *)getChildRowsDataInParent:(NSInteger)Parent
{
    return (NSMutableArray *)@[@"one",@"two",@"three",@"four"];
}
- (void)didSelectChildRow:(NSInteger)Child InParent:(NSInteger)Parent
{
    NSLog(@"didSelectChildRow = ");
}

//- (NSInteger)getNumberOfLines:(NSString *)text andFrame:(CGRect)frame
//{
//    NSInteger lines;
//    
//    NSInteger length = text.length;
//    
//    CGSize s = [text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
//    
//    return lines;
//}

@end
