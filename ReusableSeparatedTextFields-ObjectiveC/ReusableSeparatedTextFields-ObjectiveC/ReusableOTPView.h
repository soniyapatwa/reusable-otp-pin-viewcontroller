//
//  ReusableOTPViewController.h
//  ShoppingCart
//
//  Created by Soniya Patwa on 26/04/17.
//  Copyright © 2017 RJio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextFieldOTPActionDelegate <NSObject>

- (void)textFieldOTPActionCallBack:(NSString *)textFieldContent;

@end

@interface ReusableOTPView : UIView<UITextFieldDelegate>

@property (nonatomic,weak) id <TextFieldOTPActionDelegate> textFieldOTPActionDelegate;
@property(nonatomic, strong) NSMutableString *strTextFieldContent;

- (void)loadViewWithNumberOfTextFields:(NSInteger)numberOfTextFields andSize:(CGSize)size;

@end
