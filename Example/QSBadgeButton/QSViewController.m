//
//  QSViewController.m
//  QSBadgeButton
//
//  Created by zj_lostself@163.com on 11/02/2017.
//  Copyright (c) 2017 zj_lostself@163.com. All rights reserved.
//

#import "QSViewController.h"
#import <QSBadgeButton/QSBadge.h>

@interface QSViewController ()

@end

@implementation QSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150, 200, 50, 50)];
    btn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn];
    
    QSBDConfiguration *con = [[QSBDConfiguration alloc] initWithBadgeStyle:QSBDViewBadgeStyleTextWithBorder];
    [btn qsbd_showBadgeWithConfiguration:con message:@"11"];
}


@end
