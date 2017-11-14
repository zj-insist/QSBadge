//
//  QSBDConfiguration.m
//  Pods-QSBadgeButton_Example
//
//  Created by ZJ-Jie on 2017/11/13.
//

#import "QSBDConfiguration.h"



@implementation QSBDConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _qsbdStyle = QSBDViewBadgeStyleDot;
        _qsbdBgColor = [UIColor redColor];
        _qsbdTextColor = [UIColor clearColor];
        _qsbdBorderColor = [UIColor clearColor];
        _qsbdSize = CGSizeMake(8, 8);
        _qsbdBorderWidth = 0;
        _qsbdRadius = _qsbdSize.height / 2;
        _qsbdCenterOffset = CGPointMake(0, 0);
        _qsbdTextFont = [UIFont systemFontOfSize:10];
        _qsbdMaxNumDisplay = 99;
        _qsbdUserInteractionEnabled = NO;
    }
    return self;
}

- (instancetype)initWithBadgeStyle:(QSBDViewBadgeStyle)style {
    self = [self init];
    if (self) {
        switch (style) {
            case QSBDViewBadgeStyleTextWithFill:
            {
                _qsbdStyle = QSBDViewBadgeStyleTextWithFill;
                _qsbdTextColor = [UIColor whiteColor];
                _qsbdSize = CGSizeMake(16, 16);
                _qsbdRadius = _qsbdSize.height / 2;
                break;
            }
            case QSBDViewBadgeStyleTextWithBorder:
            {
                _qsbdStyle = QSBDViewBadgeStyleTextWithBorder;
                _qsbdSize = CGSizeMake(16, 16);
                _qsbdRadius = _qsbdSize.height / 2;
                _qsbdBorderColor = [UIColor redColor];
                _qsbdBorderWidth = 1.f;
                _qsbdBgColor = [UIColor whiteColor];
                _qsbdTextColor = [UIColor redColor];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

- (void)setQsbdSize:(CGSize)qsbdSize {
    _qsbdSize = qsbdSize;
    _qsbdRadius = qsbdSize.height / 2;
}

@end
