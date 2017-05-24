//
//  QQTextView.h
//  QQing
//
//  Created by 郭晓倩 on 15/7/27.
//
//  模拟TextView,可以显示placeholder和计数，例子：编辑反馈

#import <UIKit/UIKit.h>

@protocol QQTextViewDelegate;
@interface QQTextView : UIView

@property (strong, nonatomic) UITextView *inputTextView;
@property (strong, nonatomic) UILabel *placeHolderLabel;
@property (strong, nonatomic) UILabel *wordCountLabel;

-(void)resetWithDelegate:(id<QQTextViewDelegate>)delegate
             placeHolder:(NSString*)placeHolder
               wordLimit:(int)wordLimit
             defaultText:(NSString*)defaultText;

-(void)resetWithDelegate:(id<QQTextViewDelegate>)delegate
             placeHolder:(NSString*)placeHolder
               wordLimit:(int)wordLimit
           showWordLimit:(BOOL)isShowWordLimit
             defaultText:(NSString*)defaultText;

-(void)resetWithDelegate:(id<QQTextViewDelegate>)delegate
             placeHolder:(NSString*)placeHolder
               wordLimit:(int)wordLimit;

- (void)resetInputTextViewInserts:(float)inputTextViewInserts;

-(void)resetInputWithText:(NSString*)text;
-(void)clearInput;
-(NSString*)currentInput;
-(void)displayBorder:(BOOL)border;

-(void)focusOff;
-(void)focusOn;
-(BOOL)isFocusOn;

@end

@protocol QQTextViewDelegate <NSObject>
@optional
-(void)textFieldViewDidBeginEditing:(QQTextView *)textView;
-(void)textView:(QQTextView*)textView didChangeText:(NSString*)text;
-(void)textViewDidEndEditText:(QQTextView*)textView;
@end
