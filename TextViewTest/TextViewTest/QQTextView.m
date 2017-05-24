//
//  QQTextView.m
//  QQing
//
//  Created by 郭晓倩 on 15/7/27.
//
//

#import "QQTextView.h"
#import "Masonry.h"

@interface QQTextView ()
@property (weak, nonatomic) id<QQTextViewDelegate> delegate;
@property (assign, nonatomic) int wordLimit;

@end

@implementation QQTextView

-(void)commonInit{
    //视图构建
    self.inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20)];
    self.inputTextView.showsHorizontalScrollIndicator = NO;
    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 100, 30)];
    self.wordCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-60, self.frame.size.height-20, 60, 20)];
    [self addSubview:self.inputTextView];
    [self addSubview:self.placeHolderLabel];
    [self addSubview:self.wordCountLabel];
    
    //布局
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 20, 0);
        make.edges.equalTo(self).with.insets(insets);
    }];
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputTextView.mas_top).with.offset(8);
        make.left.equalTo(self.inputTextView.mas_left).with.offset(8);
        make.right.equalTo(self.inputTextView.mas_right).with.offset(-8);
    }];
    [self.wordCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.inputTextView.mas_right).with.offset(-2);
        make.top.equalTo(self.inputTextView.mas_bottom);
        make.height.mas_equalTo(20.f);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeText) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
    
    //属性设置
    //    @weakify(self);
    //    [self.inputTextView.rac_textSignal subscribeNext:^(id x) {
    //        @strongify(self);
    //        [self textViewDidChange:self.inputTextView];
    //    }];
    //
    //    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextViewTextDidBeginEditingNotification object:nil]subscribeNext:^(id x) {
    //        @strongify(self);
    //        [self textFieldViewDidBeginEditing:x];
    //    }];
    //
    //    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextViewTextDidEndEditingNotification object:nil]subscribeNext:^(id x) {
    //        @strongify(self);
    //        [self textViewDidEndEditing:x];
    //    }];
    
    //输入框
    self.inputTextView.textColor = [UIColor grayColor];
    self.inputTextView.font = [UIFont systemFontOfSize:16.0];
    //默认显示边框
    [self displayBorder:YES];
    
    self.placeHolderLabel.textColor = [UIColor grayColor];
    self.placeHolderLabel.font = [UIFont systemFontOfSize:16.0];
    self.placeHolderLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.placeHolderLabel.numberOfLines = 0;
    
    self.wordCountLabel.textColor = [UIColor grayColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.font = [UIFont systemFontOfSize:14.0];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)resetWithDelegate:(id<QQTextViewDelegate>)delegate
             placeHolder:(NSString*)placeHolder
               wordLimit:(int)wordLimit
             defaultText:(NSString*)defaultText{
    self.delegate = delegate;
    self.wordLimit = wordLimit;
    self.placeHolderLabel.text = placeHolder;
    
    if (defaultText && defaultText.length > 0) {
        self.inputTextView.text = defaultText;
        [self textViewDidChange:self.inputTextView];
    }else{
        [self resetWordCount:0];
    }
}

-(void)resetWithDelegate:(id<QQTextViewDelegate>)delegate
             placeHolder:(NSString*)placeHolder
               wordLimit:(int)wordLimit
           showWordLimit:(BOOL)isShowWordLimit
             defaultText:(NSString*)defaultText{
    self.delegate = delegate;
    self.wordLimit = wordLimit;
    if (wordLimit > 0) {
        self.wordCountLabel.hidden = !isShowWordLimit;
    }
    self.placeHolderLabel.text = placeHolder;
    
    if (defaultText && defaultText.length > 0) {
        self.inputTextView.text = defaultText;
        [self textViewDidChange:self.inputTextView];
    }else{
        [self resetWordCount:0];
    }
}

-(void)resetWithDelegate:(id<QQTextViewDelegate>)delegate
             placeHolder:(NSString*)placeHolder
               wordLimit:(int)wordLimit{
    [self resetWithDelegate:delegate placeHolder:placeHolder wordLimit:wordLimit defaultText:nil];
}

- (void)resetInputTextViewInserts:(float)inputTextViewInserts {
    [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0, inputTextViewInserts, 20, inputTextViewInserts);
        make.edges.equalTo(self).with.insets(insets);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView*)textView {
    if ([self.delegate respondsToSelector:@selector(textViewDidEndEditText:)]) {
        [self.delegate textViewDidEndEditText:self ];
    }
}

-(void)textFieldViewDidBeginEditing:(NSNotification*)notification {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldViewDidBeginEditing:)]) {
        [self.delegate textFieldViewDidBeginEditing:self];
    }
}

-(void)didChangeText{
    [self textViewDidChange:self.inputTextView];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        [self.placeHolderLabel setHidden:YES];
        if (textView.text.length > self.wordLimit && self.wordLimit > 0) {
            textView.text = [textView.text substringToIndex:self.wordLimit];
        }
    }else{
        [self.placeHolderLabel setHidden:NO];
    }
    
    [self resetWordCount:(int)textView.text.length];
    if (self.delegate && [self.delegate respondsToSelector:@selector(textView:didChangeText:)]) {
        [self.delegate textView:self didChangeText:textView.text];
    }
    
    //避免5S上粘贴长文本时，textview上滑过大
    if (textView.text.length > 0) {
        [self.inputTextView scrollRangeToVisible:NSMakeRange(textView.text.length - 1, 1)];
    }
}

#pragma mark - Rest

-(void)resetWordCount:(int)count{
    self.wordCountLabel.text = [NSString stringWithFormat:@"%d/%d",count,self.wordLimit];
}

-(void)resetInputWithText:(NSString*)text {
    if (text.length) {
        [self.placeHolderLabel setHidden:YES];
    } else {
        [self.placeHolderLabel setHidden:NO];
    }
    self.inputTextView.text = text;
    [self resetWordCount:(int)text.length];
}

-(void)clearInput{
    //清理内容
    self.inputTextView.text = @"";
    [self resetWordCount:0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(textView:didChangeText:)]) {
        [self.delegate textView:self didChangeText:@""];
    }
}

-(NSString*)currentInput{
    return self.inputTextView.text;
}

-(void)focusOff{
    [self.inputTextView resignFirstResponder];
}
-(void)focusOn{
    [self.inputTextView becomeFirstResponder];
}

-(BOOL)isFocusOn{
    return [self.inputTextView isFirstResponder];
}

-(void)displayBorder:(BOOL)border{
    if (border) {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }else{
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

- (void)setWordLimit:(int)wordLimit {
    _wordLimit = wordLimit;
    if (wordLimit <= 0) {
        self.wordCountLabel.hidden = YES;
    } else {
        self.wordCountLabel.hidden = NO;
    }
}

@end
