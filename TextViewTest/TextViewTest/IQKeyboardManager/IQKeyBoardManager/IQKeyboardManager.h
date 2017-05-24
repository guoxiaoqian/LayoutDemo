//
// IQKeyboardManager.h
// https://github.com/hackiftekhar/IQKeyboardManager
// Copyright (c) 2013-15 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "IQKeyboardManagerConstants.h"

#import <CoreGraphics/CGBase.h>

#import <Foundation/NSObject.h>
#import <Foundation/NSObjCRuntime.h>

#import <UIKit/UITextInputTraits.h>
#import <UIKit/UIKit.h>


#if !(__has_feature(objc_instancetype))
#define instancetype id
#endif

//全局键盘控制类iqkeyboardmanager上done按钮点击通知
#define kNotificationKeyboardDoneButtonClicked  @"NotificationKeyboardDoneButtonClicked"

@class UIFont;

/**
 Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more. A generic version of KeyboardManagement. https://developer.apple.com/Library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
 */
@interface IQKeyboardManager : NSObject

///--------------------------
/// @name UIKeyboard handling
///--------------------------

/**
 Returns the default singleton instance.
 */
+ (instancetype)sharedManager;

/**
 Enable/disable managing distance between keyboard and textField. Default is YES(Enabled when class loads in `+(void)load` method).
 */
@property(nonatomic, assign, getter = isEnabled) BOOL enable;

/**
 To set keyboard distance from textField. can't be less than zero. Default is 10.0.
 */
@property(nonatomic, assign) CGFloat keyboardDistanceFromTextField;

/**
 Prevent keyboard manager to slide up the rootView to more than keyboard height. Default is YES.
 */
@property(nonatomic, assign) BOOL preventShowingBottomBlankSpace;

///-------------------------
/// @name IQToolbar handling
///-------------------------

/**
 Automatic add the IQToolbar functionality. Default is YES.
 */
@property(nonatomic, assign, getter = isEnableAutoToolbar) BOOL enableAutoToolbar;

/**
 AutoToolbar managing behaviour. Default is IQAutoToolbarBySubviews.
 */
@property(nonatomic, assign) IQAutoToolbarManageBehaviour toolbarManageBehaviour;

#ifdef NSFoundationVersionNumber_iOS_6_1
/**
 If YES, then uses textField's tintColor property for IQToolbar, otherwise tint color is black. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldToolbarUsesTextFieldTintColor;
#endif

/**
 If YES, then it add the textField's placeholder text on IQToolbar. Default is YES.
 */
@property(nonatomic, assign) BOOL shouldShowTextFieldPlaceholder;

/**
 Placeholder Font. Default is nil.
 */
@property(nonatomic, strong) UIFont *placeholderFont;

///--------------------------
/// @name UITextView handling
///--------------------------

/**
 Adjust textView's frame when it is too big in height. Default is NO.
 */
@property(nonatomic, assign) BOOL canAdjustTextView;

#ifdef NSFoundationVersionNumber_iOS_6_1
/**
 Adjust textView's contentInset to fix a bug. for iOS 7.0.x - http://stackoverflow.com/questions/18966675/uitextview-in-ios7-clips-the-last-line-of-text-string Default is YES.
 */
@property(nonatomic, assign) BOOL shouldFixTextViewClip;
#endif

///---------------------------------------
/// @name UIKeyboard appearance overriding
///---------------------------------------

/**
 Override the keyboardAppearance for all textField/textView. Default is NO.
 */
@property(nonatomic, assign) BOOL overrideKeyboardAppearance;

/**
 If overrideKeyboardAppearance is YES, then all the textField keyboardAppearance is set using this property.
 */
@property(nonatomic, assign) UIKeyboardAppearance keyboardAppearance;

///---------------------------------------------
/// @name UITextField/UITextView Next/Previous/Resign handling
///---------------------------------------------

/**
 Resigns Keyboard on touching outside of UITextField/View. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldResignOnTouchOutside;

/**
 Resigns currently first responder field.
 */
- (void)resignFirstResponder;

/**
 Returns YES if can navigate to previous responder textField/textView, otherwise NO.
 */
@property (nonatomic, readonly) BOOL canGoPrevious;

/**
 Returns YES if can navigate to next responder textField/textView, otherwise NO.
 */
@property (nonatomic, readonly) BOOL canGoNext;

/**
 Navigate to previous responder textField/textView.
 */
- (void)goPrevious;

/**
 Navigate to next responder textField/textView.
 */
- (void)goNext;

///----------------------------
/// @name UIScrollView handling
///----------------------------

/**
 Restore scrollViewContentOffset when resigning from scrollView. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldRestoreScrollViewContentOffset;

///------------------------------------------------
/// @name UISound handling
///------------------------------------------------

/**
 If YES, then it plays inputClick sound on next/previous/done click.
 */
@property(nonatomic, assign) BOOL shouldPlayInputClicks;

///---------------------------
/// @name UIAnimation handling
///---------------------------

/**
 If YES, then uses keyboard default animation curve style to move view, otherwise uses UIViewAnimationOptionCurveEaseInOut animation style. Default is YES.
 
 @warning Sometimes strange animations may be produced if uses default curve style animation in iOS 7 and changing the textFields very frequently.
 */
@property(nonatomic, assign) BOOL shouldAdoptDefaultKeyboardAnimation;

///------------------------------------
/// @name Class Level disabling methods
///------------------------------------

/**
 Disable adjusting view in disabledClass
 
 @param disabledClass Class in which library should not adjust view to show textField.
 */
-(void)disableInViewControllerClass:(Class)disabledClass;

/**
 Re-enable adjusting textField in disabledClass
 
 @param disabledClass Class in which library should re-enable adjust view to show textField.
 */
-(void)removeDisableInViewControllerClass:(Class)disabledClass;

/**
 Disable automatic toolbar creation in in toolbarDisabledClass
 
 @param toolbarDisabledClass Class in which library should not add toolbar over textField.
 */
-(void)disableToolbarInViewControllerClass:(Class)toolbarDisabledClass;

/**
 Re-enable automatic toolbar creation in in toolbarDisabledClass
 
 @param toolbarDisabledClass Class in which library should re-enable automatic toolbar creation over textField.
 */
-(void)removeDisableToolbarInViewControllerClass:(Class)toolbarDisabledClass;

/**
 Consider provided customView class as superView of all inner textField for calculating next/previous button logic.
 
 @param toolbarPreviousNextConsideredClass Custom UIView subclass Class in which library should consider all inner textField as siblings and add next/previous accordingly.
 */
-(void)considerToolbarPreviousNextInViewClass:(Class)toolbarPreviousNextConsideredClass;

/**
 Remove Consideration for provided customView class as superView of all inner textField for calculating next/previous button logic.
 
 @param toolbarPreviousNextConsideredClass Custom UIView subclass Class in which library should remove consideration for all inner textField as superView.
 */
-(void)removeConsiderToolbarPreviousNextInViewClass:(Class)toolbarPreviousNextConsideredClass;

///------------------------------------------------
/// @name Must not be used for subclassing.
///------------------------------------------------

/**
 Should create only one instance of class. Should not call init.
 */
- (instancetype)init	__attribute__((unavailable("init is not available in IQKeyboardManager, Use sharedManager"))) NS_DESIGNATED_INITIALIZER;

/**
 Should create only one instance of class. Should not call new.
 */
+ (instancetype)new	__attribute__((unavailable("new is not available in IQKeyboardManager, Use sharedManager")));


//---------------add by fa-----------------

/**
 *  默认：yes
 
 
 *  风险：当前检测到表情，直接退两格，一定是两字节长度么？还是用字典管理起所有“上次输入”，同时管理输入（editBegin）、输出（editEnd）
 */

@property (nonatomic, assign) BOOL enabledEmoji;

@property (nonatomic, weak) UIView *keyBoardScrollView;
//-----------------end---------------------

@end

///---------------------
/// @name IQToolbar tags
///---------------------

/**
 Default tag for toolbar with Done button   -1002.
 */
extern NSInteger const kIQDoneButtonToolbarTag;

/**
 Default tag for toolbar with Previous/Next buttons -1005.
 */


//---------------add by fa-----------------

@interface NSString (Ext)

- (BOOL)isContainsEmoji; // 是否包含表情

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex;

@end

//-----------------end---------------------

