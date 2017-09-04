#import "XAVisualEffectView.h"
#import <objc/runtime.h>

@implementation XAVisualEffect

#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    return [[self class] allocWithZone:zone];
}

@end

@implementation XABlurEffect

+ (XABlurEffect *)effectWithStyle:(XABlurEffectStyle)style {
    XABlurEffect *effect = [[XABlurEffect alloc] init];
    objc_setAssociatedObject(effect, _cmd, @(style), OBJC_ASSOCIATION_RETAIN);
    return effect;
}

@end

@implementation XAVibrancyEffect

+ (XAVibrancyEffect *)effectForBlurEffect:(XABlurEffect *)blurEffect {
    XAVibrancyEffect *effect = [[XAVibrancyEffect alloc] init];
    objc_setAssociatedObject(effect, _cmd, blurEffect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return effect;
}

@end

@implementation XAVisualEffectView
{
    UIToolbar *_toolBar;
}

- (instancetype)initWithEffect:(XAVisualEffect *)effect {
    if (self = [super init]) {
        [self setEffect:effect];
    }
    return self;
}

// VisualEffect
- (void)setEffect:(XAVisualEffect *)effect {
    if ([effect isMemberOfClass:[XABlurEffect class]]) {
        [self setBlurEffect:(XABlurEffect *)effect];
    } else if ([effect isMemberOfClass:[XAVibrancyEffect class]]) {
        [self setVibrancyEffect:(XAVibrancyEffect *)effect];
    }
}

// BlurEffect
- (void)setBlurEffect:(XABlurEffect *)effect {
    XABlurEffectStyle style = [objc_getAssociatedObject(effect, @selector(effectWithStyle:)) integerValue];
    switch (style) {
        case XABlurEffectStyleExtraLight: {
            [self effectWithBarStyle:UIBarStyleDefault];
        }
            break;
        case XABlurEffectStyleLight: {
            [self effectWithBarStyle:UIBarStyleDefault];
        }
            break;
        case XABlurEffectStyleDark: {
            [self effectWithBarStyle:UIBarStyleBlack];
        }
            break;
            break;
        case XABlurEffectStyleRegular: {
            [self effectWithBarStyle:UIBarStyleDefault];
        }
            break;
        case XABlurEffectStyleProminent: {
            [self effectWithBarStyle:UIBarStyleDefault];
        }
            break;
        default:
            break;
    }
}

// VibrancyEffect
- (void)setVibrancyEffect:(XAVibrancyEffect *)effect {
    XABlurEffect *blurEffect = objc_getAssociatedObject(effect, @selector(effectForBlurEffect:));
    [self setBlurEffect:blurEffect];
}

#pragma mark - setEffect
- (void)effectWithBarStyle:(UIBarStyle)barStyle {
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.barStyle = barStyle;
    [self addSubview:toolBar];
    
    _toolBar = toolBar;
    
    [self setLayoutConstraints];
}

#pragma mark - Layout
- (void)setLayoutConstraints {
    _toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_toolBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self addConstraints:@[topConstraint, leftConstraint, bottomConstraint, rightConstraint]];
}

#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _contentView = [aDecoder decodeObjectOfClass:[UIView class] forKey:@"contentView"];
        _effect = [aDecoder decodeObjectOfClass:[UIVisualEffect class] forKey:@"effect"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_contentView forKey:@"contentView"];
    [aCoder encodeObject:_effect forKey:@"effect"];
}

@end

#pragma mark - Runtime Injection
__asm(
      ".section        __DATA,__objc_classrefs,regular,no_dead_strip\n"
#if	TARGET_RT_64_BIT
      ".align          3\n"
      "L_OBJC_CLASS_UIVisualEffect:\n"
      ".quad           _OBJC_CLASS_$_UIVisualEffect\n"

      ".align          3\n"
      "L_OBJC_CLASS_UIBlurEffect:\n"
      ".quad           _OBJC_CLASS_$_UIBlurEffect\n"
      
      ".align          3\n"
      "L_OBJC_CLASS_UIVibrancyEffect:\n"
      ".quad           _OBJC_CLASS_$_UIVibrancyEffect\n"
      
      ".align          3\n"
      "L_OBJC_CLASS_UIVisualEffectView:\n"
      ".quad           _OBJC_CLASS_$_UIVisualEffectView\n"
#else
      ".align          2\n"
      "_OBJC_CLASS_UIVisualEffect:\n"
      ".long           _OBJC_CLASS_$_UIVisualEffect\n"
      
      ".align          2\n"
      "_OBJC_CLASS_UIBlurEffect:\n"
      ".long           _OBJC_CLASS_$_UIBlurEffect\n"
      
      ".align          2\n"
      "_OBJC_CLASS_UIVibrancyEffect:\n"
      ".long           _OBJC_CLASS_$_UIVibrancyEffect\n"
      
      ".align          2\n"
      "_OBJC_CLASS_UIVisualEffectView:\n"
      ".long           _OBJC_CLASS_$_UIVisualEffectView\n"
#endif
      ".weak_reference _OBJC_CLASS_$_UIVisualEffect\n"
      ".weak_reference _OBJC_CLASS_$_UIBlurEffect\n"
      ".weak_reference _OBJC_CLASS_$_UIVibrancyEffect\n"
      ".weak_reference _OBJC_CLASS_$_UIVisualEffectView\n"
      );

// Constructors are called after all classes have been loaded.
__attribute__((constructor)) static void XAVisualEffectViewPatchEntry(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            
            // >= iOS8.
            if (objc_getClass("UIVisualEffectView")) {
                return;
            }
            
            Class *visualEffect = NULL;
            Class *blurEffect = NULL;
            Class *vibrancyEffect = NULL;
            Class *visualEffectView = NULL;
            
#if TARGET_CPU_ARM
            __asm("movw %0, :lower16:(_OBJC_CLASS_UIVisualEffect-(LPC0+4))\n"
                  "movt %0, :upper16:(_OBJC_CLASS_UIVisualEffect-(LPC0+4))\n"
                  "LPC0: add %0, pc" : "=r"(visualEffect));
            __asm("movw %0, :lower16:(_OBJC_CLASS_UIBlurEffect-(LPC0+4))\n"
                  "movt %0, :upper16:(_OBJC_CLASS_UIBlurEffect-(LPC0+4))\n"
                  "LPC0: add %0, pc" : "=r"(blurEffect));
            __asm("movw %0, :lower16:(_OBJC_CLASS_UIVibrancyEffect-(LPC0+4))\n"
                  "movt %0, :upper16:(_OBJC_CLASS_UIVibrancyEffect-(LPC0+4))\n"
                  "LPC0: add %0, pc" : "=r"(vibrancyEffect));
            __asm("movw %0, :lower16:(_OBJC_CLASS_UIVisualEffectView-(LPC0+4))\n"
                  "movt %0, :upper16:(_OBJC_CLASS_UIVisualEffectView-(LPC0+4))\n"
                  "LPC0: add %0, pc" : "=r"(visualEffectView));
#elif TARGET_CPU_ARM64
            __asm("adrp %0, L_OBJC_CLASS_UIVisualEffect@PAGE\n"
                  "add  %0, %0, L_OBJC_CLASS_UIVisualEffect@PAGEOFF" : "=r"(visualEffect));
            __asm("adrp %0, L_OBJC_CLASS_UIBlurEffect@PAGE\n"
                  "add  %0, %0, L_OBJC_CLASS_UIBlurEffect@PAGEOFF" : "=r"(blurEffect));
            __asm("adrp %0, L_OBJC_CLASS_UIVibrancyEffect@PAGE\n"
                  "add  %0, %0, L_OBJC_CLASS_UIVibrancyEffect@PAGEOFF" : "=r"(vibrancyEffect));
            __asm("adrp %0, L_OBJC_CLASS_UIVisualEffectView@PAGE\n"
                  "add  %0, %0, L_OBJC_CLASS_UIVisualEffectView@PAGEOFF" : "=r"(visualEffectView));
#elif TARGET_CPU_X86_64
            __asm("leaq L_OBJC_CLASS_UIVisualEffect(%%rip), %0" : "=r"(visualEffect));
            __asm("leaq L_OBJC_CLASS_UIBlurEffect(%%rip), %0" : "=r"(blurEffect));
            __asm("leaq L_OBJC_CLASS_UIVibrancyEffect(%%rip), %0" : "=r"(vibrancyEffect));
            __asm("leaq L_OBJC_CLASS_UIVisualEffectView(%%rip), %0" : "=r"(visualEffectView));
#elif TARGET_CPU_X86
            void *pc1 = NULL;
            __asm("calll L0\n"
                  "L0: popl %0\n"
                  "leal _OBJC_CLASS_UIVisualEffect-L0(%0), %1" : "=r"(pc1), "=r"(visualEffect));
            void *pc2 = NULL;
            __asm("calll L0\n"
                  "L0: popl %0\n"
                  "leal _OBJC_CLASS_UIBlurEffect-L0(%0), %1" : "=r"(pc2), "=r"(blurEffect));
            void *pc3 = NULL;
            __asm("calll L0\n"
                  "L0: popl %0\n"
                  "leal _OBJC_CLASS_UIVibrancyEffect-L0(%0), %1" : "=r"(pc3), "=r"(vibrancyEffect));
            void *pc4 = NULL;
            __asm("calll L0\n"
                  "L0: popl %0\n"
                  "leal _OBJC_CLASS_UIVisualEffectView-L0(%0), %1" : "=r"(pc4), "=r"(visualEffectView));
#else
#error Unsupported CPU
#endif
            
            if (visualEffect && !*visualEffect) {
                Class class = objc_allocateClassPair([XAVisualEffect class], "UIVisualEffect", 0);
                if (class) {
                    objc_registerClassPair(class);
                    *visualEffect = class;
                }
            }
            
            if (blurEffect && !*blurEffect) {
                Class class = objc_allocateClassPair([XABlurEffect class], "UIBlurEffect", 0);
                if (class) {
                    objc_registerClassPair(class);
                    *blurEffect = class;
                }
            }
            
            if (vibrancyEffect && !*vibrancyEffect) {
                Class class = objc_allocateClassPair([XAVibrancyEffect class], "UIVibrancyEffect", 0);
                if (class) {
                    objc_registerClassPair(class);
                    *vibrancyEffect = class;
                }
            }
            
            if (visualEffectView && !*visualEffectView) {
                Class class = objc_allocateClassPair([XAVisualEffectView class], "UIVisualEffectView", 0);
                if (class) {
                    objc_registerClassPair(class);
                    *visualEffectView = class;
                }
            }
        }
    });
}
