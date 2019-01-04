//
//  ViewController.m
//  DzwGuidenceView
//
//  Created by dzw on 2018/10/29.
//  Copyright © 2018 dzw. All rights reserved.
//

#import "ViewController.h"
#import "DzwGuidenceView.h"
#import <Lottie/Lottie.h>

@interface ViewController ()
@property (nonatomic, strong) UILabel *aLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.aLabel = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.text = @"test";
        label;
    });
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    DzwGuidenceView *guidenceView = [[DzwGuidenceView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    guidenceView.backgroundColor = [UIColor whiteColor];
    guidenceView.animationsGroup = @[@"man_and_chat",@"man_and_phone",@"man_and_pay_with_credit_card",@"man_and_travel"];
    guidenceView.textGroup = @[@"看看驴友评价",@"找个靠谱攻略",@"在线支付安排行程",@"走起 ——~ "];
    __weak typeof(self) weakSelf = self;
    guidenceView.nextAction = ^(UIButton * _Nonnull button) {
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"" message:@"引导完成,跳出引导页" preferredStyle:1];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"✔️" style:0 handler:nil];
        [alert addAction:ok];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
    [self.view addSubview:guidenceView];


    
}


@end
