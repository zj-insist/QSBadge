//
//  UIView+QSBadge.m
//  Pods-QSBadgeButton_Example
//
//  Created by ZJ-Jie on 2017/11/13.
//

#import "UIView+QSBadge.h"
#import <objc/runtime.h>
#import "QSBDConfiguration.h"

static char qsbdMessageKey;

@interface UIView()

@property(nonatomic, strong) QSBDConfiguration *qsbdConfiguration;
@property(nonatomic, assign) CGSize qsbdSize;
@property(nonatomic, strong) UIFont *qsbdTextFont;

@property(nonatomic, copy) NSString *message;

@end

@implementation UIView (QSBadge)

#pragma mark - lift cycle

- (void)fixBadgeCenter {
    self.qsbdBadge.center = CGPointMake(self.frame.size.width + self.qsbdCenterOffset.x,  self.qsbdCenterOffset.y);
}

#pragma mark - public methods

- (void)qsbd_showBadge{
    [self setupBadge];
    [self.qsbdBadge setHidden:NO];
    
    [self fixBadgeCenter];
}

- (void)qsbd_showBadgeWithConfiguration:(QSBDConfiguration *)configuration message:(NSString *)message {
    self.qsbdConfiguration = configuration;
    
    //dot类型直接调用
    if (!message || configuration.qsbdStyle == QSBDViewBadgeStyleDot) {
        [self qsbd_showBadge];
        return;
    }
    
    if (!message || message.length == 0 || ([self isPureInt:message] && [message integerValue] <= 0)) {
        [self.qsbdBadge setHidden:YES];
        return;
    }
    
    [self setupBadge];
    self.message = message;
    NSString *str = message;
    if ([self isPureInt:str] && [str integerValue] > self.qsbdMaxNumDisplay) {
        str = [[@(self.qsbdMaxNumDisplay) stringValue] stringByAppendingString:@"+"];
    }
    
    CGFloat width = ([self getWidthWithText:str] + 10) < QSBDMaxSize.width ? ([self getWidthWithText:str] + 10) : QSBDMaxSize.width;
    self.qsbdSize = CGSizeMake(width, self.qsbdSize.height);
    
    [self.qsbdBadge setText:str];
    [self fixBadgeCenter];
}

- (void)qsbd_showBadgeWithNum:(NSInteger)num {
    [self qsbd_showBadgeWithMessage:[@(num) stringValue]];
}

- (void)qsbd_showBadgeWithMessage:(NSString *)message{
    [self qsbd_showBadgeWithConfiguration:[[QSBDConfiguration alloc] initWithBadgeStyle:QSBDViewBadgeStyleTextWithFill] message:message];
}

- (void)qsbd_showBadgeWithConfiguration:(QSBDConfiguration *)configuration num:(NSInteger)num {
    [self qsbd_showBadgeWithConfiguration:configuration message:[@(num) stringValue]];
}

- (void)qsbd_clearBadge {
    [self.qsbdBadge setHidden:YES];
}

- (void)qsbd_resumeBadge {
    if (self.qsbdBadge && self.qsbdBadge.isHidden) {
        [self.qsbdBadge setHidden:NO];
    }
}

#pragma mark - private methods

- (void)setupBadge {
    if (!self.qsbdConfiguration) {
        self.qsbdConfiguration = [QSBDConfiguration new];
    }
    
    if (!self.qsbdBadge) {
        self.qsbdBadge = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.qsbdBadge];
        
        self.qsbdBadge.textAlignment = NSTextAlignmentCenter;
        self.qsbdBadge.layer.masksToBounds = YES;
        [self bringSubviewToFront:self.qsbdBadge];
    }
    
    //最先设置size
    self.qsbdSize = self.qsbdConfiguration.qsbdSize;
    self.qsbdTextFont = self.qsbdConfiguration.qsbdTextFont;
    
    //区分设置权限
    [self.qsbdBadge setBackgroundColor:(self.qsbdBgColor ? : self.qsbdConfiguration.qsbdBgColor)];
    self.qsbdBadge.layer.borderColor = (self.qsbdBorderColor ? : self.qsbdConfiguration.qsbdBorderColor).CGColor;
    [self.qsbdBadge setTextColor:(self.qsbdTextColor ? : self.qsbdConfiguration.qsbdTextColor)];
    self.qsbdBadge.layer.cornerRadius = (self.qsbdRadius ? : self.qsbdConfiguration.qsbdRadius);
    self.qsbdBadge.layer.borderWidth = (self.qsbdBorderWidth ? : self.qsbdConfiguration.qsbdBorderWidth);
    if (CGPointEqualToPoint(self.qsbdCenterOffset, CGPointZero)) {
        self.qsbdBadge.center = CGPointMake(CGRectGetWidth(self.frame) + self.qsbdCenterOffset.x, self.qsbdCenterOffset.y);
    } else {
        self.qsbdBadge.center = CGPointMake(CGRectGetWidth(self.frame) + self.qsbdConfiguration.qsbdCenterOffset.x, self.qsbdConfiguration.qsbdCenterOffset.y);
    }
    
    if (!self.qsbdCustomView) {
        self.qsbdCustomView = self.qsbdConfiguration.qsbdCustomView;
    }
    
    self.qsbdMaxNumDisplay = self.qsbdMaxNumDisplay ? : self.qsbdConfiguration.qsbdMaxNumDisplay;
    
//    self.qsbdBgColor = self.qsbdConfiguration.qsbdBgColor;
//    self.qsbdBorderColor = self.qsbdConfiguration.qsbdBorderColor;
//    self.qsbdTextColor = self.qsbdConfiguration.qsbdTextColor;
//    self.qsbdRadius = self.qsbdConfiguration.qsbdRadius;
//    self.qsbdBorderWidth = self.qsbdConfiguration.qsbdBorderWidth;
//    if (CGPointEqualToPoint(self.qsbdCenterOffset, CGPointZero)) {
//        self.qsbdCenterOffset = self.qsbdConfiguration.qsbdCenterOffset;
//    }
//    self.qsbdCustomView = self.qsbdConfiguration.qsbdCustomView;
}

//判断一个字符串是不是纯数字
- (BOOL)isPureInt:(NSString *)str {
    NSScanner *scan = [NSScanner scannerWithString:str];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (CGFloat)getWidthWithText:(NSString *)text {
    if (!text.length) {
        return 0;
    }
    CGSize size = [text boundingRectWithSize:CGSizeMake(QSBDMaxSize.width, self.qsbdSize.height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.qsbdTextFont} context:nil].size;
    size.height = ceilf(size.height);
    return size.width;
}

#pragma mark - getter and setter

- (QSBDConfiguration *)qsbdConfiguration {
    return objc_getAssociatedObject(self, &qsbdConfigurationKey);
}

- (void)setQsbdConfiguration:(QSBDConfiguration *)qsbdConfiguration {
    objc_setAssociatedObject(self, &qsbdConfigurationKey, qsbdConfiguration, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel *)qsbdBadge {
    return objc_getAssociatedObject(self, &qsbdLabelKey);
}

- (void)setQsbdBadge:(UILabel *)qsbdBadge {
    objc_setAssociatedObject(self, &qsbdLabelKey, qsbdBadge, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)qsbdBgColor {
    return objc_getAssociatedObject(self, &qsbdBgColorKey);
}

- (void)setQsbdBgColor:(UIColor *)qsbdBgColor {
    objc_setAssociatedObject(self, &qsbdBgColorKey, qsbdBgColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    if (self.qsbdCustomView) return;
    self.qsbdBadge.backgroundColor = qsbdBgColor;
}

- (UIColor *)qsbdTextColor {
    return objc_getAssociatedObject(self, &qsbdTextColorKey);
}

- (void)setQsbdTextColor:(UIColor *)qsbdTextColor {
    objc_setAssociatedObject(self, &qsbdTextColorKey, qsbdTextColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    if (self.qsbdCustomView) return;
    self.qsbdBadge.textColor = qsbdTextColor;
}

- (UIColor *)qsbdBorderColor {
    return objc_getAssociatedObject(self, &qsbdBorderColorKey);
}

- (void)setQsbdBorderColor:(UIColor *)qsbdBorderColor {
    objc_setAssociatedObject(self, &qsbdBorderColorKey, qsbdBorderColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    
    if (self.qsbdCustomView) return;
    self.qsbdBadge.layer.borderColor = qsbdBorderColor.CGColor;
}

- (CGFloat)qsbdBorderWidth {
    id obj = objc_getAssociatedObject(self, &qsbdBorderWidthKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]]) {
        return [obj integerValue];
    } else {
        return 0;
    }
}

- (void)setQsbdBorderWidth:(CGFloat)qsbdBorderWidth {
    objc_setAssociatedObject(self, &qsbdBorderWidthKey, @(qsbdBorderWidth), OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    self.qsbdBadge.layer.borderWidth = qsbdBorderWidth;
}

- (CGFloat)qsbdRadius {
    id obj = objc_getAssociatedObject(self, &qsbdRadiusKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]]) {
        return [obj integerValue];
    } else {
        return 0;
    }
}

- (void)setQsbdRadius:(CGFloat)qsbdRadius {
    objc_setAssociatedObject(self, &qsbdRadiusKey, @(qsbdRadius), OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    self.qsbdBadge.layer.cornerRadius = qsbdRadius;
}

- (UIFont *)qsbdTextFont {
    return objc_getAssociatedObject(self, &qsbdTextFontKey);
}

- (void)setQsbdTextFont:(UIFont *)qsbdTextFont {
    objc_setAssociatedObject(self, &qsbdTextFontKey, qsbdTextFont, OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    self.qsbdBadge.font = qsbdTextFont;
}

- (CGSize)qsbdSize {
    id obj = objc_getAssociatedObject(self, &qsbdSizeKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
        return CGSizeMake([obj[@"width"] floatValue], [obj[@"height"] floatValue]);
    } else {
        return CGSizeZero;
    }
}

- (void)setQsbdSize:(CGSize)qsbdSize {
    NSDictionary *sizeInfo = @{
                               @"width" : @(qsbdSize.width < QSBDMaxSize.width ? qsbdSize.width : QSBDMaxSize.width),
                               @"height" : @(qsbdSize.height < QSBDMaxSize.height ? qsbdSize.height : QSBDMaxSize.height)
                               };
    objc_setAssociatedObject(self, &qsbdSizeKey, sizeInfo, OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    self.qsbdBadge.frame = ({
        CGRect frame;
        frame = self.qsbdBadge.frame;
        frame.size = CGSizeMake(qsbdSize.width < QSBDMaxSize.width ? qsbdSize.width : QSBDMaxSize.width, qsbdSize.height < QSBDMaxSize.height ? qsbdSize.height : QSBDMaxSize.height);
        frame;
    });
    [self fixBadgeCenter];
}

- (CGPoint)qsbdCenterOffset {
    id obj = objc_getAssociatedObject(self, &qsbdCenterOffsetKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
        return CGPointMake([obj[@"x"] floatValue], [obj[@"y"] floatValue]);
    } else {
        return CGPointZero;
    }
}

- (void)setQsbdCenterOffset:(CGPoint)qsbdCenterOffset {
    NSDictionary *offset = @{
                               @"x" : @(qsbdCenterOffset.x),
                               @"y" : @(qsbdCenterOffset.y)
                               };
    objc_setAssociatedObject(self, &qsbdCenterOffsetKey, offset, OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    self.qsbdBadge.center = CGPointMake(CGRectGetWidth(self.frame) + qsbdCenterOffset.x, qsbdCenterOffset.y);
}

- (NSInteger)qsbdMaxNumDisplay {
    return [objc_getAssociatedObject(self, &qsbdMaxNumDisplayKey) integerValue];
}

- (void)setQsbdMaxNumDisplay:(NSInteger)qsbdMaxNumDisplay {
    objc_setAssociatedObject(self, &qsbdMaxNumDisplayKey, @(qsbdMaxNumDisplay), OBJC_ASSOCIATION_RETAIN);
    if (self.qsbdBadge && self.qsbdConfiguration) {
        NSString *str = self.message;
        if ([self isPureInt:str] && [str integerValue] > qsbdMaxNumDisplay) {
            str = [[@(qsbdMaxNumDisplay) stringValue] stringByAppendingString:@"+"];
        }
        
        CGFloat width = ([self getWidthWithText:str] + 10) < QSBDMaxSize.width ? ([self getWidthWithText:str] + 10) : QSBDMaxSize.width;
        self.qsbdSize = CGSizeMake(width, self.qsbdSize.height);
        
        [self.qsbdBadge setText:str];
        [self fixBadgeCenter];
    }
}

- (NSString *)message {
    return objc_getAssociatedObject(self, &qsbdMessageKey);
}

- (void)setMessage:(NSString *)message {
    objc_setAssociatedObject(self, &qsbdMessageKey, message, OBJC_ASSOCIATION_COPY);
}

- (UIView *)qsbdCustomView {
    return objc_getAssociatedObject(self, &qsbdCustomViewKey);
}

- (void)setQsbdCustomView:(UIView *)qsbdCustomView {
    if (!qsbdCustomView) return;
    [self.qsbdBadge setHidden:YES];
    if (self.qsbdCustomView) {
        [self.qsbdCustomView removeFromSuperview];
    }
    objc_setAssociatedObject(self, &qsbdCustomViewKey, qsbdCustomView, OBJC_ASSOCIATION_RETAIN);
    if (!self.qsbdBadge) {
        [self setupBadge];
    }
    [self.qsbdBadge addSubview:qsbdCustomView];
    self.qsbdBadge.backgroundColor = [UIColor clearColor];
    self.qsbdBadge.textColor = [UIColor clearColor];
    self.qsbdBadge.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self fixBadgeCenter];
}

@end
