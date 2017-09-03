#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XABlurEffectStyle) {
    XABlurEffectStyleExtraLight,
    XABlurEffectStyleLight,
    XABlurEffectStyleDark,
    XABlurEffectStyleExtraDark,
    XABlurEffectStyleRegular,
    XABlurEffectStyleProminent
};

NS_ASSUME_NONNULL_BEGIN

@interface XAVisualEffect : NSObject <NSCopying, NSSecureCoding> @end

@interface XABlurEffect : XAVisualEffect
+ (XABlurEffect *)effectWithStyle:(XABlurEffectStyle)style;
@end

@interface XAVibrancyEffect : XAVisualEffect
+ (XAVibrancyEffect *)effectForBlurEffect:(XABlurEffect *)blurEffect;
@end

@interface XAVisualEffectView : UIView <NSSecureCoding>
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, copy, nullable) XAVisualEffect *effect;
- (instancetype)initWithEffect:(nullable XAVisualEffect *)effect;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder;
@end

NS_ASSUME_NONNULL_END
