//
//  ViewController.m
//  MusicList
//
//  Created by sharui on 2018/5/7.
//  Copyright © 2018年 com.sharui.demo. All rights reserved.
//
#import "HeaderView.h"
#import "ListViewController.h"


@interface ListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) HeaderView *headerView;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainCollectionView];
    self.navigationItem.title = @"呵呵";
    
    [self setTableViewHeaderView];
    
}
- (void)setTableViewHeaderView {
    __weak typeof(self) weakSelf = self;
    self.headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTabViewHeight)];
    [self.headerView setIconPicStr:@"123" withCompleteBlock:^{
        [weakSelf scrollViewDidScroll:weakSelf.mainCollectionView]; //回调后刷新navigationBar
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setPrivateNavigationBar];
    [self scrollViewDidScroll:self.mainCollectionView];
}
- (void)viewWillDisappear:(BOOL)animated
{
   
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}

- (UIImage *)createImageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)setPrivateNavigationBar {
    
    UINavigationBar * bar = self.navigationController.navigationBar;
    //首次透明
    [bar setTranslucent: true];;
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc]init]];
    
    //设置起始坐标为0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth- 40)/3,(kScreenWidth- 40)/3);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return  UIEdgeInsetsZero;
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else {
        return 0;
    }
    
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else {
        return 10;
    }
    
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width, kTabViewHeight);
    }else {
        return CGSizeMake(self.view.frame.size.width, 50);
    }
    
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableViewID" forIndexPath:indexPath];
        [headerView addSubview:self.headerView];
        return headerView;
    }else {
         UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableViewTitleID" forIndexPath:indexPath];
        UILabel *titleLabel = [UILabel new];
        titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 50);
        titleLabel.backgroundColor = [UIColor blueColor];
        [headerView addSubview:titleLabel];
        return headerView;
    }
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%s",__func__);
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = self.mainCollectionView.contentOffset.y;
    NSLog(@"%f",y);
    
    if (y < - KHeadViewOff) {
        [self.mainCollectionView setContentOffset:CGPointMake(0, - KHeadViewOff + 1) animated:0];
    }
    
    if ( y < kTabViewHeight) {
        //截图背景图的部分截图 用于设置navigatonBar背景图，造成连贯视觉落差
        UIImage * view = [self getImageFromView:self.headerView.backgroundImageView withContentOffY: -(self.mainCollectionView.contentOffset.y) - KHeadViewOff];
        [self.navigationController.navigationBar setBackgroundImage:view forBarMetrics:UIBarMetricsDefault];
    }
}

- (UICollectionView *)mainCollectionView {
    if (_mainCollectionView == nil) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        if (@available(iOS 9.0, *)) {
            layout.sectionHeadersPinToVisibleBounds = YES;
        } else {
            // Fallback on earlier versions
        }

        //2.初始化collectionView
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) collectionViewLayout:layout];
        [self.view addSubview:_mainCollectionView];
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        _mainCollectionView.clipsToBounds = NO;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableViewID"];
         [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableViewTitleID"];
        //4.设置代理
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        
    }
    return _mainCollectionView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    NSLog(@"%s",__func__);
}

/**
 截取图片

 @param orgView 哪个view
 @param y 起始点
 @return 截取好的image
 */
-(UIImage *)getImageFromView:(UIImageView *)orgView withContentOffY:(CGFloat)y{

    UIGraphicsBeginImageContext(orgView.bounds.size);
    [orgView.image drawInRect:CGRectMake(0,y, orgView.bounds.size.width, orgView.bounds.size.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
