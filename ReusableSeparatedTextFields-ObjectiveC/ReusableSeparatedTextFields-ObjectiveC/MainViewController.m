//
//  MainViewController.m
//  ReusableSeparatedTextFields-ObjectiveC
//
//  Created by Soniya Patwa on 06/10/17.
//  Copyright © 2017 myOrganization. All rights reserved.
//

#import "MainViewController.h"
#import "ReusableOTPView.h"

@interface MainViewController ()
{
    ReusableOTPView *reusableOTPView;
}
@property (weak, nonatomic) IBOutlet UILabel *enterOTPLabel;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadOTPView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadOTPView
{
    //load OTP view
    reusableOTPView = [[[NSBundle mainBundle] loadNibNamed:@"ReusableOTPView" owner:self options:nil] objectAtIndex:0];
    reusableOTPView.frame = CGRectMake(self.view.frame.size.width/2 - (self.view.frame.size.width - 100)/2, self.enterOTPLabel.frame.origin.y + self.enterOTPLabel.frame.size.height + 20, self.view.frame.size.width - 100, 50);
    [reusableOTPView loadViewWithNumberOfTextFields:4 andSize:CGSizeMake(reusableOTPView.frame.size.width, reusableOTPView.frame.size.height)];
    reusableOTPView.textFieldOTPActionDelegate = (id)self;
    reusableOTPView.backgroundColor = [UIColor clearColor];
    reusableOTPView.clipsToBounds=YES;
    [self.view addSubview:reusableOTPView];
}

- (void)textFieldOTPActionCallBack:(NSString *)textFieldContent
{
    NSLog(@"*************Call back successful************ value = %@", textFieldContent);
    
//    NSArray *tempViewArray = reusableOTPView.subviews;
//    UIView *tempView = (UIView *)tempViewArray[0];
//    for (UIView *subViews in tempView.subviews)
//    {
//        if([subViews isKindOfClass:[UITextField class]])
//        {
//            UITextField *textFeild = (UITextField *)subViews;
//            textFeild.text  = @"";
//            if(textFeild.tag == 1)
//               [textFeild becomeFirstResponder];
//        }
//    }
    
    [reusableOTPView removeFromSuperview];
    [self loadOTPView];
    self.enterOTPLabel.text = [NSString stringWithFormat:@"Entered OTP is %@", textFieldContent];
}
@end
