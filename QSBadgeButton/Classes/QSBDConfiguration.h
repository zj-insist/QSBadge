//
//  QSBDConfiguration.h
//  Pods-QSBadgeButton_Example
//
//  Created by ZJ-Jie on 2017/11/13.
//

#import "QSBadgeProtocol.h"
@import UIKit;

@interface QSBDConfiguration : NSObject

@property(nonatomic, assign, readonly) QSBDViewBadgeStyle qsbdStyle;
@property(nonatomic, strong) UIColor *qsbdBgColor;
@property(nonatomic, strong) UIColor *qsbdTextColor;
@property(nonatomic, strong) UIColor *qsbdBorderColor;
@property(nonatomic, assign) CGFloat qsbdBorderWidth;
@property(nonatomic, assign) CGFloat qsbdRadius;
@property(nonatomic, strong) UIFont *qsbdTextFont;
@property(nonatomic, assign) CGSize qsbdSize;
@property(nonatomic, assign) CGPoint qsbdCenterOffset;
@property(nonatomic, strong) UIView *qsbdCustomView;
@property(nonatomic, assign) NSInteger qsbdMaxNumDisplay;
@property(nonatomic, assign) QSBDBadgeAnimalType qsbdAnimalType;
@property(nonatomic, assign) BOOL qsbdUserInteractionEnabled;

- (instancetype)initWithBadgeStyle:(QSBDViewBadgeStyle)style;

@end

