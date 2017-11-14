//
//  QSBadgeProtocol.h
//  Pods
//
//  Created by ZJ-Jie on 2017/11/13.
//

#ifndef QSBadgeProtocol_h
#define QSBadgeProtocol_h

#define QSBDMaxSize CGSizeMake(200, 100)

@class QSBDConfiguration;

static char qsbdConfigurationKey;
static char qsbdLabelKey;
static char qsbdCustomViewKey;
static char qsbdBgColorKey;
static char qsbdTextColorKey;
static char qsbdBorderColorKey;
static char qsbdBorderWidthKey;
static char qsbdRadiusKey;
static char qsbdTextFontKey;
static char qsbdSizeKey;
static char qsbdCenterOffsetKey;
static char qsbdMaxNumDisplayKey;


//static char qsbdAnimalTypeKey;
//static char qsbdUserInteractionEnabledKey;


typedef NS_ENUM(NSUInteger, QSBDViewBadgeStyle) {
    QSBDViewBadgeStyleDot,
    QSBDViewBadgeStyleTextWithFill,
    QSBDViewBadgeStyleTextWithBorder,
};

typedef NS_ENUM(NSUInteger, QSBDBadgeAnimalType) {
    QSBDBadgeAnimalTypeNone
};

@protocol QSBadgeProtocol <NSObject>

/**
 外层属性相对qsbdConfiguration中的属性拥有更高优先级
 */
@property(nonatomic, strong, readonly) QSBDConfiguration *qsbdConfiguration;
@property(nonatomic, assign, readonly) CGSize qsbdSize;
@property(nonatomic, strong, readonly) UIFont *qsbdTextFont;
@property(nonatomic, strong,readonly) UILabel *qsbdBadge;

@property(nonatomic, strong) UIColor *qsbdBgColor;
@property(nonatomic, strong) UIColor *qsbdTextColor;
@property(nonatomic, strong) UIColor *qsbdBorderColor;
@property(nonatomic, assign) CGFloat qsbdBorderWidth;
@property(nonatomic, assign) CGFloat qsbdRadius;
@property(nonatomic, assign) CGPoint qsbdCenterOffset;

@property(nonatomic, assign) NSInteger qsbdMaxNumDisplay;
@property(nonatomic, strong) UIView *qsbdCustomView;

//@property(nonatomic, assign) QSBDViewBadgeStyle qsbdStyle;
//@property(nonatomic, assign) QSBDBadgeAnimalType qsbdAnimalType;
//@property(nonatomic, assign) BOOL qsbdUserInteractionEnabled;

- (void)qsbd_showBadge;

- (void)qsbd_showBadgeWithMessage:(NSString *)message;

- (void)qsbd_showBadgeWithNum:(NSInteger)num;

- (void)qsbd_showBadgeWithConfiguration:(QSBDConfiguration *)configuration message:(NSString *)message;

- (void)qsbd_showBadgeWithConfiguration:(QSBDConfiguration *)configuration num:(NSInteger)num;

- (void)qsbd_clearBadge;

@end

#endif /* QSBadgeProtocol_h */
