//
//  ReusableOTPViewController.m
//  ShoppingCart
//
//  Created by Soniya Patwa on 26/04/17.
//  Copyright © 2017 RJio. All rights reserved.
//

#import "ReusableOTPView.h"
@interface ReusableOTPView()
{
    NSInteger n;
    CGSize viewSize;
    int textFieldCount;
    NSMutableDictionary *dictOTP;
}
@end

@implementation ReusableOTPView

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    [self loadViewWithNumberOfTextFields:n andSize:viewSize];
//}

- (void)loadViewWithNumberOfTextFields:(NSInteger)numberOfTextFields andSize:(CGSize)size
{
    n = numberOfTextFields;
    viewSize = size;
    dictOTP = [[NSMutableDictionary alloc] init];
    for(int i=1; i<=n; i++)
    {
        [dictOTP setValue:@"" forKey:[NSString stringWithFormat:@"%i",i]];
    }
    self.strTextFieldContent = [NSMutableString stringWithFormat:@""];
    
    UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, size.height)];
    [self addSubview:viewContainer];
    
    for(int i=1; i<=n; i++)
    {
        CGFloat width = viewContainer.frame.size.width/(numberOfTextFields*1.4);
        CGFloat xPosition = (viewContainer.frame.size.width/(numberOfTextFields*4)) + (viewContainer.frame.size.width/numberOfTextFields) * (i-1);
        
        UITextField *textFieldForOTP = [[UITextField alloc] initWithFrame:CGRectMake(xPosition, 0 ,width ,viewContainer.frame.size.height - 10)];
        textFieldForOTP.tag = i;
        textFieldForOTP.borderStyle = UITextBorderStyleNone;
        textFieldForOTP.backgroundColor = [UIColor clearColor];
        textFieldForOTP.textColor = [UIColor whiteColor];
        textFieldForOTP.textAlignment = NSTextAlignmentCenter;
        textFieldForOTP.userInteractionEnabled = YES;
        textFieldForOTP.delegate = self;
        textFieldForOTP.text = @"";
        [viewContainer addSubview:textFieldForOTP];
        
        UIView *underlineView = [[UITextField alloc] initWithFrame:CGRectMake(textFieldForOTP.frame.origin.x, textFieldForOTP.frame.size.height - 1, textFieldForOTP.frame.size.width, 1)];
        underlineView.backgroundColor = [UIColor whiteColor];
        [viewContainer addSubview:underlineView];
    }
    UIResponder *nextResponder = [self viewWithTag:1];
    [nextResponder becomeFirstResponder];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if(string.length > 0)
//    {
//        UIResponder *nextResponder ;
//        NSInteger tag = textField.tag + 1;
//        if(textFieldCount<=n)
//        {
//            textField.text = string;
//            [self.strTextFieldContent appendString:string];
//            if(textFieldCount == n)
//            {
//                textField.text = string;
//                [self.strTextFieldContent appendString:string];
//                
//                //call delegate method to return the entered text
//                NSLog(@"last text field filled");
//                [self.textFieldOTPActionDelegate textFieldOTPActionCallBack:self.strTextFieldContent];
//            }
//            textFieldCount = textFieldCount + 1;
//        }
//        if (!nextResponder) {
//            nextResponder = [self viewWithTag:tag];
//        }
//        if (nextResponder) {
//            [nextResponder becomeFirstResponder];
//        }
//        return NO;
//    }
//    if(string.length == 0 && textField.text.length == 1)
//    {
//        textField.text = @"";
//        UIResponder *nextResponder ;
//        NSInteger tag = textField.tag - 1;
//        textFieldCount = textFieldCount - 1;
//        if (!nextResponder) {
//            nextResponder = [self viewWithTag:tag];
//        }
//        if (nextResponder) {
//            [nextResponder becomeFirstResponder];
//        }
//        return NO;
//    }
//    return YES;
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(string.length > 0)
    {
        UIResponder *nextResponder ;
        NSInteger tag = textField.tag;
        if(tag<=n)
        {
            [dictOTP setValue:string forKey:[NSString stringWithFormat:@"%li",(long)tag]];
            tag = tag + 1;
            textField.text = string;
            
            textFieldCount = 0;
            for(int i=1; i<=n; i++)
            {
                if(![[dictOTP objectForKey:[NSString stringWithFormat:@"%i",i]] isEqualToString:@""])
                    textFieldCount = textFieldCount + 1;
            }
            
            if(textFieldCount == n)
            {
                textField.text = string;
                self.strTextFieldContent = [NSMutableString stringWithFormat:@""];
                for(int i=1; i<=n; i++)
                {
                    if(![[dictOTP objectForKey:[NSString stringWithFormat:@"%i",i]] isEqualToString:@""])
                        [self.strTextFieldContent appendString:[dictOTP objectForKey:[NSString stringWithFormat:@"%i",i]]];
                }
                
                //call delegate method to return the entered text
                NSLog(@"all textfield filled");
                [self.textFieldOTPActionDelegate textFieldOTPActionCallBack:self.strTextFieldContent];
            }
        }
        if (!nextResponder) {
            nextResponder = [self viewWithTag:tag];
        }
        if (nextResponder) {
            [nextResponder becomeFirstResponder];
        }
        return NO;
    }
    if(string.length == 0 && textField.text.length == 1)
    {
        textField.text = @"";
        UIResponder *nextResponder ;
        NSInteger tag = textField.tag;
        [dictOTP setValue:@"" forKey:[NSString stringWithFormat:@"%li",(long)tag]];
        tag = tag - 1;
        if (!nextResponder) {
            nextResponder = [self viewWithTag:tag];
        }
        if (nextResponder) {
            [nextResponder becomeFirstResponder];
        }
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return NO;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    UIResponder *nextResponder ;
    if([textField.text isEqualToString:@""])
    {
        NSInteger tag = textField.tag;
        tag = tag - 1;
        if (!nextResponder) {
            nextResponder = [self viewWithTag:tag];
        }
        if (nextResponder) {
            [nextResponder becomeFirstResponder];
        }
        return NO;
    }
        return YES;
}

@end
