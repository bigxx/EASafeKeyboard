//
//  EASafeTextField.m
//  CoinApp
//
//  Created by eAssh on 2019/9/2.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import "EASafeTextField.h"
#import "EASafeKeyboardView.h"
#import "EASafeKeyboardHelp.h"

@interface EASafeTextField () <EASafeKeyboardDelegate>

@property (nonatomic, strong) EASafeKeyboardView *keyboardView;

@end

@implementation EASafeTextField
#pragma mark - Constant
// 键盘高度
static const CGFloat KeyboardHeight = 218;

#pragma mark - Life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ( self = [super initWithFrame:frame]) {
        [self awakeFromNib];
    }
    return self;
}

#pragma mark - Property
- (EASafeKeyboardView *)keyboardView {
    if (!_keyboardView) {
        CGFloat tabbarSaveAreaHeight = [EASafeKeyboardHelp getTabbarSaveAreaHeight];
        _keyboardView = [[EASafeKeyboardView alloc] initWithFrame:CGRectMake(0, 0, EAScreenW, KeyboardHeight+tabbarSaveAreaHeight)];
        _keyboardView.delegate = self;
    }
    return _keyboardView;
}

#pragma mark - Data Help
- (void)changeText:(NSString *)text {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = self.selectedTextRange.start;
    UITextPosition *end = self.selectedTextRange.end;
    NSInteger startIndex = [self offsetFromPosition:beginning toPosition:start];
    NSInteger endIndex = [self offsetFromPosition:beginning toPosition:end];
    
    // 将输入框中的文字分成两部分，生成新字符串，判断新字符串是否满足要求
    NSString *originText = self.text;
    NSString *part1 = [originText substringToIndex:startIndex];
    NSString *part2 = [originText substringFromIndex:endIndex];
    
    NSInteger offset;
    
    if (![text isEqualToString:@""]) {
        offset = text.length;
    } else {
        if (startIndex == endIndex) {
            // 只删除一个字符
            if (startIndex == 0) {
                return;
            }
            offset = -1;
            part1 = [part1 substringToIndex:(part1.length - 1)];
        } else {
            offset = 0;
        }
    }
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", part1, text, part2];
    self.text = newText;
    // 重置光标位置
    UITextPosition *now = [self positionFromPosition:start offset:offset];
    UITextRange *range = [self textRangeFromPosition:now toPosition:now];
    self.selectedTextRange = range;
}

#pragma mark - Set/Get
- (void)setEKeyboardType:(EASKTextFieldKeyboardType)eKeyboardType {
    _eKeyboardType = eKeyboardType;
    switch (_eKeyboardType) {
        case EASKTextFieldSystemKeyboard:
            self.inputView = nil;
            break;
        case EASKTextFieldSafeKeyboard:
            self.inputView = self.keyboardView;
            break;
        default:
            break;
    }
}

#pragma mark - Delegate
#pragma mark EASafeKeyboardView Delegate
// MARK:点击了键盘的字母/数字
- (void)didKeyboardClick:(NSString *)text {
    [self changeText:text];
}

// MARK:点击了键盘的删除
- (void)didKeyboardDelete {
    [self changeText:@""];
}

// MARK:点击了键盘的回收
- (void)didKeyboardDismiss {
    [self endEditing:YES];
}

@end
