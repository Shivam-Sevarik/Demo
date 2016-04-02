//
//  WritingTestsViewController.m
//  Demo
//
//  Created by EcoMail on 29/03/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import "WritingTestsViewController.h"

@interface WritingTestsViewController ()<UITextFieldDelegate>
{
    NSString *result;
}
@property (strong, nonatomic) IBOutlet UILabel *lnlResult;
@property (strong, nonatomic) IBOutlet UITextField *txtf;

@end

@implementation WritingTestsViewController

- (IBAction)findFactorial:(id)sender
{
    self.lnlResult.text = [NSString stringWithFormat:@"%d",[self getFactorialofNumber:[self.txtf.text intValue]]];
}

- (int)getFactorialofNumber:(int)number
{
    int factor = number;
    int res = 1;
    
    for (int i = 1; i <= factor ; i++ )
    {
        res = res*i;
    }
    
    return res;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)headerButton
{
    NSLog(@"headerButton");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
