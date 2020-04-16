//
//  EASKLetterKeyboardView.m
//  CoinApp
//
//  Created by eAssh on 2019/9/2.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import "EASKLetterKeyboardView.h"
#import "EASKLetterCell.h"
#import "EASKLetterFunctionView.h"
#import "EASafeKeyboardHelp.h"
#import <stdio.h>

@interface EASKLetterKeyboardView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *keybordCollection;
@property (nonatomic, strong) EASKLetterFunctionView *functionView;

@property (nonatomic, strong) NSMutableArray *firstLetterArray;
@property (nonatomic, strong) NSMutableArray *secondLetterArray;
@property (nonatomic, strong) NSMutableArray *thirdLetterArray;
@property (nonatomic, assign) BOOL isCapital;
@property (nonatomic, assign) CGFloat letterItemWidth;
@property (nonatomic, assign) CGFloat letterItemHeight;
@property (nonatomic, assign) CGFloat tabbarSaveAreaHeight;

@end

@implementation EASKLetterKeyboardView
#pragma mark - Constant
// 功能区高度
static const CGFloat FunctionHeight = 42 + 10;

// 第一行边距
static const CGFloat FirstLineMargin = 10;
// 第三行边距
static const CGFloat ThirdLineMargin = 17;
// 第一行控件间距
static const CGFloat FirstItemSpace = 6;
// 第二行控件间距
static const CGFloat SecondItemSpace = 6;
// 第三行控件间距
static const CGFloat ThirdItemSpace = 6;

// Cell标识符
static NSString *EALetterCellIdentifier = @"EALetterCellIdentifier";

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
    self.firstLetterArray = [NSMutableArray new];
    self.secondLetterArray = [NSMutableArray new];
    self.thirdLetterArray = [NSMutableArray new];
    
//    NSMutableArray *allLetters = [NSMutableArray new];
//    for (int i=0; i<26; i++) {
//        [allLetters addObject:[NSString stringWithFormat:@"%c",'a'+i]];
//    }
//
//    for (int i=0; i<10; i++) {
//        [self.firstLetterArray addObject:[allLetters objectAtIndex:i]];
//    }
//    for (int i=10; i<19; i++) {
//        [self.secondLetterArray addObject:[allLetters objectAtIndex:i]];
//    }
//    for (int i=20; i<26; i++) {
//        [self.thirdLetterArray addObject:[allLetters objectAtIndex:i]];
//    }
    
    // 设置大写键默认为NO
    self.isCapital = NO;
    // 按照全键盘字母布局，顺序添加字母
    self.firstLetterArray = [NSMutableArray arrayWithArray:@[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"]];
    self.secondLetterArray = [NSMutableArray arrayWithArray:@[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"]];
    self.thirdLetterArray = [NSMutableArray arrayWithArray:@[@"z",@"x",@"c",@"v",@"b",@"n",@"m"]];
    // 第三行添加大写键
    [self.thirdLetterArray insertObject:@"大写" atIndex:0];
    // 第三行添加删除键
    [self.thirdLetterArray addObject:@"删除"];
    
    // 获取标签栏安全区域高度
    self.tabbarSaveAreaHeight = [EASafeKeyboardHelp getTabbarSaveAreaHeight];
    // 设置字母控件宽度
    self.letterItemWidth = [self getLetterPadItemWidth];
    // 设置字母控件高度
    self.letterItemHeight = [self getLetterPadItemHeight];
}

- (void)setMainUI {
    self.backgroundColor = EASKBackgroundColor;
    
    [self addSubview:self.functionView];
    [self addSubview:self.keybordCollection];
}

#pragma mark - Property
- (UICollectionView *)keybordCollection {
    if (!_keybordCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _keybordCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.tabbarSaveAreaHeight-FunctionHeight) collectionViewLayout:flowLayout];
        _keybordCollection.backgroundColor = EASKBackgroundColor;
        _keybordCollection.delegate = self;
        _keybordCollection.dataSource = self;
        [_keybordCollection registerClass:[EASKLetterCell class] forCellWithReuseIdentifier:EALetterCellIdentifier];
    }
    return _keybordCollection;
}

- (EASKLetterFunctionView *)functionView {
    if (!_functionView) {
        __weak typeof (self) weakSelf = self;
        _functionView = [[EASKLetterFunctionView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-self.tabbarSaveAreaHeight-FunctionHeight, CGRectGetWidth(self.frame), FunctionHeight)];
        _functionView.switchNumPadBlock = ^{
            if ([weakSelf.lkDelegate respondsToSelector:@selector(didSwitchNumPad)]) {
                [weakSelf.lkDelegate didSwitchNumPad];
            }
        };
        _functionView.confirmBlock = ^{
            if ([weakSelf.lkDelegate respondsToSelector:@selector(didLetterKeyboardClickDismiss)]) {
                [weakSelf.lkDelegate didLetterKeyboardClickDismiss];
            }
        };
    }
    return _functionView;
}

#pragma mark - Delegate
#pragma mark CollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.firstLetterArray.count;
    } else if (section == 1) {
        return self.secondLetterArray.count;
    } else {
        return self.thirdLetterArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EASKLetterCell *letterCell = [collectionView dequeueReusableCellWithReuseIdentifier:EALetterCellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        letterCell.title = self.firstLetterArray[indexPath.row];
    } else if (indexPath.section == 1) {
        letterCell.title = self.secondLetterArray[indexPath.row];
    } else {
        letterCell.title = self.thirdLetterArray[indexPath.row];
    }
    
    // 设置字母控件的大写开关
    letterCell.isCapital = self.isCapital;
    // 字母点击回调
    letterCell.letterBlock = ^(NSString * _Nonnull letter, EALetterKeyType keyType) {
        // 点击了大写键
        if (keyType == EACapitalKeyType) {
            self.isCapital = !self.isCapital;
            [self.keybordCollection reloadData];
        }
        // 点击了字母键
        if (keyType == EAWorldKeyType) {
            if ([self.lkDelegate respondsToSelector:@selector(didLetterKeyboardClick:)]) {
                [self.lkDelegate didLetterKeyboardClick:letter];
            }
        }
        // 点击了删除键
        if (keyType == EAWorldDeleteKeyType) {
            if ([self.lkDelegate respondsToSelector:@selector(didLetterKeyboardDelete)]) {
                [self.lkDelegate didLetterKeyboardDelete];
            }
        }
    };
    return letterCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (indexPath.row == 0 || indexPath.row == self.thirdLetterArray.count-1) {
            return CGSizeMake([self getFunctionWidth], self.letterItemHeight);
        } else {
            return CGSizeMake(self.letterItemWidth, self.letterItemHeight);
        }
    } else {
        return CGSizeMake(self.letterItemWidth, self.letterItemHeight);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return FirstItemSpace;
    } else if (section == 1) {
        return SecondItemSpace;
    } else {
        return ThirdItemSpace;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self getSectionInsert:section];
}

#pragma mark - Action
#pragma mark - UI Help
#pragma mark - Data Help
// MARK:根据section获取insert
- (UIEdgeInsets)getSectionInsert:(NSInteger)section {
    // 设置默认section空间数
    NSInteger keyCount = 0;
    // 设置默认边距
    CGFloat margin = 0;
    // 设置默认top
    CGFloat topMargin = 0;
    // 设置默认bottom
    CGFloat bottomMargin = 0;
    switch (section) {
        case 0:
        {
            keyCount = self.firstLetterArray.count;
            topMargin = 10;
            bottomMargin = 0;
        }
            break;
        case 1:
        {
            keyCount = self.secondLetterArray.count;
            topMargin = 10;
            bottomMargin = 0;
        }
            break;
        case 2:
        {
            keyCount = self.thirdLetterArray.count;
            topMargin = 10;
            bottomMargin = 10;
        }
            break;
        default:
            break;
    }
    
    if (section == 0) {
        margin = FirstLineMargin;
    } else if (section == 1) {
        margin = (self.frame.size.width-keyCount*self.letterItemWidth-SecondItemSpace*(keyCount-1))/2;
    } else {
        margin = ThirdLineMargin;
    }
    
    return UIEdgeInsetsMake(topMargin, margin, bottomMargin, margin);
}

// MAKR:获取功能键宽度
- (CGFloat)getFunctionWidth {
    CGFloat itemWidth = [self getLetterPadItemWidth];
    NSInteger itemCount = self.thirdLetterArray.count-2;
    CGFloat functionWidth = (CGRectGetWidth(self.frame)-ThirdLineMargin*2-itemWidth*itemCount-(itemCount-1+2)*ThirdItemSpace)/2;
    return functionWidth;
}

// MARK:获取字母控件宽度
- (CGFloat)getLetterPadItemWidth {
    CGFloat firstLineMargin = FirstLineMargin;
    CGFloat firstLineItemSpace = FirstItemSpace;
    NSInteger firstLineItems = self.firstLetterArray.count;
    
    CGFloat width = (self.frame.size.width - firstLineMargin * 2 - firstLineItemSpace * (firstLineItems - 1)) / firstLineItems;
    return width;
}

// MARK:获取字母控件高度
- (CGFloat)getLetterPadItemHeight {
    CGFloat itemHeight = (CGRectGetHeight(self.frame)-self.tabbarSaveAreaHeight-FunctionHeight-10*4)/3;
    itemHeight = 42;
    return itemHeight;
}


@end
