//
//  ViewController.m
//  EASafeKeyboard
//
//  Created by eAssh on 2019/11/8.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import "ViewController.h"
#import "EASafeTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EASafeTextField *textField = [[EASafeTextField alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    textField.placeholder = @"自定义安全键盘";
    textField.eKeyboardType = EASKTextFieldSafeKeyboard;
    textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:textField];
}


@end
