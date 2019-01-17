//
//  PersonInfoDetailViewController.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/7/19.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "PersonInfoDetailViewController.h"
#import "XDTextView.h"

@interface PersonInfoDetailViewController ()
@property (nonatomic, strong) UITextField    *textField;
@property (nonatomic, strong) XDTextView     *textView;
@property (nonatomic, assign) InputType      type;
@property (nonatomic, copy)   NSString      *text;

@end

@implementation PersonInfoDetailViewController
- (instancetype)initWithType:(InputType)type andText:(NSString *)text{
    self = [super init];
    if (self) {
        _type = type;
        _text = text;
    }
    return self;
}

- (instancetype)init{
    return [self initWithType:InputTypeTextField andText:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedSave)];
    
    if (self.type == InputTypeTextField) {
        [self setupTextField];
    }else{
        [self setupTextView];
    }


    
    // Do any additional setup after loading the view.
}


- (void)setupTextField{
    
    self.view.backgroundColor = XGCOLOR(228, 228, 228);
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 35)];
    textfield.text = self.text;
    textfield.backgroundColor = [UIColor whiteColor];
    textfield.borderStyle = UITextBorderStyleNone;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSpace * 1.5, kSpace)];
    textfield.leftView = leftView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    //    textfield.rightView = leftView;
    textfield.clearButtonMode = UITextFieldViewModeAlways;
    _textField = textfield;
    [self.view addSubview:textfield];
}

- (void)setupTextView{
    XDTextView *textView = [[XDTextView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 100)];
    textView.text = self.text;
    textView.font = [UIFont systemFontOfSize:15];
    textView.backgroundColor = XGCOLOR(228, 228, 228);
    textView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView = textView;
    [self.view addSubview:textView];
}

- (void)didClickedSave{
    if (self.saveBlock) {
        NSString *text = self.type == InputTypeTextField?self.textField.text:self.textView.text;
        self.saveBlock(text);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
