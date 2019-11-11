//
//  EASKNumKeyboardView.m
//  CoinApp
//
//  Created by hym on 2019/9/2.
//  Copyright © 2019 xfg. All rights reserved.
//

#import "EASKNumKeyboardView.h"
#import "EASKNumberCell.h"
#import "EAKNumFunctionView.h"
#import "EASafeKeyboardHelp.h"

@interface EASKNumKeyboardView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *keybordCollection;
@property (nonatomic, strong) EAKNumFunctionView *functionView;

@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic, assign) CGFloat numItemWidth;
@property (nonatomic, assign) CGFloat tabbarSaveAreaHeight;

@end

@implementation EASKNumKeyboardView
#pragma mark - Constant
// Cell标识符
static NSString *EANumberCellIdentifier = @"EANumberCellIdentifier";

// 控件间距
static const CGFloat ItemSpace = 7;
// 边距
static const CGFloat Margin = 10;
// 行间距
static const CGFloat LineSpace = 10;

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
    // 随机排序 0-9 数字，并添加到数字数组中
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    self.numberArray = [NSMutableArray new];
    
    NSInteger count = tempArr.count;
    for (int i=0; i < count; i++) {
        int index = arc4random() % tempArr.count;
        [self.numberArray addObject:tempArr[index]];
        [tempArr removeObjectAtIndex:index];
    }
    
    // 插入切换字母键盘按钮
    [self.numberArray insertObject:@"ABC" atIndex:9];
    // 插入删除按钮
    [self.numberArray addObject:@"删除"];
    // 设置标签栏安全区域高度
    self.tabbarSaveAreaHeight = [EASafeKeyboardHelp getTabbarSaveAreaHeight];
    // 设置数字字母控件宽度
    self.numItemWidth = [self getNumPadItemWidth];
}

- (void)setMainUI {
    self.backgroundColor = EASKBackgroundColor;
    
    [self addSubview:self.keybordCollection];
    [self addSubview:self.functionView];
}

#pragma mark - Property
- (UICollectionView *)keybordCollection {
    if (!_keybordCollection) {
        // 设置 collection 宽度
        CGFloat width = [self getNumPadItemWidth] * 3 + ItemSpace * 2 + Margin * 2;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _keybordCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, CGRectGetHeight(self.frame)-self.tabbarSaveAreaHeight) collectionViewLayout:flowLayout];
        _keybordCollection.backgroundColor = EASKBackgroundColor;
        _keybordCollection.delegate = self;
        _keybordCollection.dataSource = self;
        [_keybordCollection registerClass:[EASKNumberCell class] forCellWithReuseIdentifier:EANumberCellIdentifier];
    }
    return _keybordCollection;
}

- (EAKNumFunctionView *)functionView {
    if (!_functionView) {
        __weak typeof (self) weakSelf = self;
        CGFloat width = [self getNumPadItemWidth]+Margin;
        _functionView = [[EAKNumFunctionView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-width, 0, width, CGRectGetHeight(self.frame)-self.tabbarSaveAreaHeight)];
        
        // 功能区域键盘回收回调
        _functionView.dismissBlock = ^{
            if ([weakSelf.nkDelegate respondsToSelector:@selector(didNumKeyboardClickDismiss)]) {
                [weakSelf.nkDelegate didNumKeyboardClickDismiss];
            }
        };
        // 功能区域确定按钮回调
        _functionView.confirmBlock = ^{
            if ([weakSelf.nkDelegate respondsToSelector:@selector(didNumKeyboardClickDismiss)]) {
                [weakSelf.nkDelegate didNumKeyboardClickDismiss];
            }
        };
    }
    return _functionView;
}

#pragma mark - Delegate
#pragma mark CollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EASKNumberCell *numberCell = [collectionView dequeueReusableCellWithReuseIdentifier:EANumberCellIdentifier forIndexPath:indexPath];
    numberCell.title = self.numberArray[indexPath.row];
    
    // 点击数字回调
    numberCell.numberBlock = ^(NSString *selectNumber, EANumKeyType keyType) {
        // 点击事件：切换键盘
        if (keyType == EASwitchKeyType) {
            if ([self.nkDelegate respondsToSelector:@selector(didSwitchLetterPad)]) {
                [self.nkDelegate didSwitchLetterPad];
            }
        }
        // 点击事件：数字字母
        if (keyType == EANumberKeyType) {
            if ([self.nkDelegate respondsToSelector:@selector(didNumKeyboardClick:)]) {
                [self.nkDelegate didNumKeyboardClick:selectNumber];
            }
        }
        // 点击事件：删除
        if (keyType == EANumberDeleteKeyType) {
            if ([self.nkDelegate respondsToSelector:@selector(didNumKeyboardDelete)]) {
                [self.nkDelegate didNumKeyboardDelete];
            }
        }
    };
    return numberCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self getNumPadItemWidth], [self getNumPadItemHeight]);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return LineSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return ItemSpace;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(Margin, Margin, Margin, Margin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - Action
#pragma mark - UI Help
#pragma mark - Data Help
// MARK:获取数字键盘控件宽度
- (CGFloat) getNumPadItemWidth {
    CGFloat itemSpace = ItemSpace;
    NSInteger firstLineItems = 4;
    CGFloat width = (CGRectGetWidth(self.frame) - itemSpace * (firstLineItems - 1) - Margin * 2) / firstLineItems;
    return width;
}

// MARK:获取数字键盘控件高度
- (CGFloat)getNumPadItemHeight {
    CGFloat lineSpace = LineSpace;
    NSInteger items = 4;
    CGFloat height = (CGRectGetHeight(self.frame) - lineSpace * (items + 1) - self.tabbarSaveAreaHeight) / items;
    return height;
}


@end
