//
//  EASafeKeyboardView.m
//  CoinApp
//
//  Created by hym on 2019/8/30.
//  Copyright © 2019 xfg. All rights reserved.
//

#import "EASafeKeyboardView.h"
#import "EASKLetterKeyboardView.h"
#import "EASKNumKeyboardView.h"

@interface EASafeKeyboardView () <EASKLetterKeyboardDelegate,EASKNumKeyboardDelegate>

@property (nonatomic, strong) EASKLetterKeyboardView *letterKeyboardView;
@property (nonatomic, strong) EASKNumKeyboardView *numKeyboardView;

@end

@implementation EASafeKeyboardView
#pragma mark - Constant
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setMainUI];
    }
    return self;
}

#pragma mark - Set Up
- (void)initData {
    self.keyboardType = EASKLetterKeyboardType;
}

- (void)setMainUI {
    self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:241/255.0 alpha:1.0];
    [self setKeyboardView];
}

#pragma mark - Property
- (EASKLetterKeyboardView *)letterKeyboardView {
    if (!_letterKeyboardView) {
        _letterKeyboardView = [[EASKLetterKeyboardView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _letterKeyboardView.lkDelegate = self;
    }
    return _letterKeyboardView;
}

- (EASKNumKeyboardView *)numKeyboardView {
    if (!_numKeyboardView) {
        _numKeyboardView = [[EASKNumKeyboardView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _numKeyboardView.nkDelegate = self;
    }
    return _numKeyboardView;
}

#pragma mark - Delegate
#pragma mark EASKLetterBoardView Delegate
- (void)didSwitchNumPad {
    self.keyboardType = EASKNumKeyboardyType;
    [self setKeyboardView];
}

- (void)didLetterKeyboardClick:(NSString *)letter {
    if ([self.delegate respondsToSelector:@selector(didKeyboardClick:)]) {
        [self.delegate didKeyboardClick:letter];
    }
}

- (void)didLetterKeyboardDelete {
    if ([self.delegate respondsToSelector:@selector(didKeyboardDelete)]) {
        [self.delegate didKeyboardDelete];
    }
}

- (void)didLetterKeyboardClickDismiss {
    if ([self.delegate respondsToSelector:@selector(didKeyboardDismiss)]) {
        [self.delegate didKeyboardDismiss];
    }
}

#pragma mark - EASKNumBoardView Delegate
- (void)didSwitchLetterPad {
    self.keyboardType = EASKLetterKeyboardType;
    [self setKeyboardView];
}

- (void)didNumKeyboardClick:(NSString *)letter {
    if ([self.delegate respondsToSelector:@selector(didKeyboardClick:)]) {
        [self.delegate didKeyboardClick:letter];
    }
}

- (void)didNumKeyboardDelete {
    if ([self.delegate respondsToSelector:@selector(didKeyboardDelete)]) {
        [self.delegate didKeyboardDelete];
    }
}

- (void)didNumKeyboardClickDismiss {
    if ([self.delegate respondsToSelector:@selector(didKeyboardDismiss)]) {
        [self.delegate didKeyboardDismiss];
    }
}

#pragma mark - Action
#pragma mark - UI Help
- (void)setKeyboardView {
    switch (self.keyboardType) {
        case EASKLetterKeyboardType:
        {
            if (_numKeyboardView) {
                [_numKeyboardView removeFromSuperview];
                _numKeyboardView = nil;
            }
            [self addSubview:self.letterKeyboardView];
        }
            break;
        case EASKNumKeyboardyType:
        {
            if (_letterKeyboardView) {
                [_letterKeyboardView removeFromSuperview];
                _letterKeyboardView = nil;
            }
            [self addSubview:self.numKeyboardView];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Data Help

@end
