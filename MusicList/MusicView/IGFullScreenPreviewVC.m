//
//  IGFullScreenPreviewVC.m
//  jingdongfang
//
//  Created by RKL on 2018/8/3.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
//  画单预览-全屏预览

#import "IGFullScreenPreviewVC.h"
#import "IGAlbumPreviewCollectionViewCell.h"

typedef NS_ENUM(NSUInteger, IGScrollDirectionType) {
    IGScrollDirectionTypeNext,
    IGScrollDirectionTypePrevious
};

@interface IGFullScreenPreviewVC ()<IGAlbumPreviewCollectionViewCellDelegate>
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation IGFullScreenPreviewVC

#define playerViewHeight 60
static NSString * const reuseIdentifier = @"IGAlbumPreviewViewControllerCell";

#pragma mark - lifeCycle(生命周期)

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _leftButton.frame = CGRectMake(0, kScreenHeight/2, 50, 50);
    _rightButton.frame = CGRectMake(kScreenWidth - 50, kScreenHeight/2, 50, 50);
    _playerView.frame = CGRectMake(0, kScreenHeight - playerViewHeight, kScreenWidth, playerViewHeight);
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.artworkPlate isEqualToString:@"1"]) {
        [self interfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _playerView =  [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - playerViewHeight, kScreenWidth, playerViewHeight)];
    _playerView.backgroundColor = [UIColor greenColor];
    _playerView.alpha = .4;
    [self.view addSubview:_playerView];
    [self addChangePicButton];
    self.collectionView.pagingEnabled = YES;
    

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"2b59929c12852714e0cbc252c84c392d" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"ee7abfd7e916f0b16de6623c3c3dcbc9" ofType:@"jpeg"];
    UIImage *image2 = [UIImage imageWithContentsOfFile:path2];
    
    [self.drawArray addObject:image];
    [self.drawArray addObject:image2];
    [self.drawArray addObject:image2];
    [self.drawArray addObject:image2];
    [self.drawArray addObject:image2];
    [self.drawArray addObject:image2];
    [self.drawArray addObject:image2];
    
    [self.collectionView registerClass:[IGAlbumPreviewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView reloadData];
}

- (void)addChangePicButton{
    
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight/2, 50, 50)];
    _leftButton.backgroundColor = [UIColor redColor];
    [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftButton];
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, kScreenHeight/2, 50, 50)];
    _rightButton.backgroundColor = [UIColor redColor];
    [_rightButton addTarget:self action:@selector(clickrightButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightButton];
}
#pragma mark - event response(触摸点击事件)

- (void)clickLeftButton {
    [self scrollDirectionWith:IGScrollDirectionTypePrevious];
}
- (void)clickrightButton {
    [self scrollDirectionWith:IGScrollDirectionTypeNext];
}

- (void)scrollDirectionWith:(IGScrollDirectionType) type {
    
//    [self.collectionView layoutIfNeeded];
    NSArray *visibleIndexpaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath * indexPath =  visibleIndexpaths.firstObject;
    NSIndexPath * nextIndexPath;
    
    if (type == IGScrollDirectionTypePrevious) {
        if (indexPath.item > 0) {
            nextIndexPath = [NSIndexPath indexPathForRow:indexPath.item - 1 inSection:indexPath.section];
        }else {
            nextIndexPath = indexPath;
        }
        
    }else if (type == IGScrollDirectionTypeNext) {
        if (indexPath.item < self.drawArray.count - 1) {
            nextIndexPath = [NSIndexPath indexPathForRow:indexPath.item + 1 inSection:indexPath.section];
        }else {
            nextIndexPath = indexPath;
        }
    }
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource && Delegate(代理方法)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.drawArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    IGAlbumPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;

    cell.picImageStr = self.drawArray[indexPath.item];
    return cell;
}




#pragma mark - private(私有方法)

#pragma mark - getters and setters(setter和getter方法)

- (NSMutableArray *)drawArray {
    if (_drawArray == nil) {
        _drawArray = [NSMutableArray new];
    }
    return _drawArray;
}


@end
