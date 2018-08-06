//
//  ViewController.m
//  MusicList
//
//  Created by sharui on 2018/5/7.
//  Copyright © 2018年 com.sharui.demo. All rights reserved.
//

#import "ListViewController.h"
#import "HeaderView.h"
#import "WSLWaterFlowLayout.h"
#import "PicRectionViewCollectionViewCell.h"
#import "IGPicListMainCollectionViewCell.h"
#import "CollectionReusableViewTitle1.h"
#import "CollectionReusableViewTitle2.h"


typedef void(^RunLoopBlock)(void);

@interface ListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WSLWaterFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) HeaderView *headerView;
/**
 数据源
 */
@property (nonatomic, strong) NSArray * dataArr;

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, copy) RunLoopBlock task;

@end

static NSString * const PicRectionViewCollectionViewCellID = @"PicRectionViewCollectionViewCellID";
static NSString * const IGPicListMainCollectionViewCellID = @"IGPicListMainCollectionViewCellID";

static NSString * const reusableViewTitle2ID = @"reusableViewTitle2ID";
static NSString * const reusableViewTitle1ID = @"reusableViewTitle1ID";
static NSString * const reusableViewHeaderID = @"reusableViewHeaderID";
static NSString * const reusableViewFootID = @"reusableViewFootID";


@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainCollectionView];
    
    self.navigationItem.title = @"画单";
    self.dataArr = @[@"1",@"2",@"2",@"1",@"1",@"1",@"2",@"1",@"2",@"2",@"1",@"1",@"1",@"2",@"1",@"2",@"2",@"1",@"1",@"1",@"2",@"1",@"2",@"2",@"1",@"1",@"1",@"2"];
    [self setTableViewHeaderView];
    [self setPrivateNavigationBar];
    [self addRunLoopObserver];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setPrivateNavigationBar];
//    [self scrollViewDidScroll:self.mainCollectionView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
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

- (void)setTableViewHeaderView
{
    __weak typeof(self) weakSelf = self;
    self.headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTabViewHeight)];
    [self.headerView setIconPicStr:@"123" withCompleteBlock:^{
        [weakSelf scrollViewDidScroll:weakSelf.mainCollectionView]; //回调后刷新navigationBar
    }];
}
- (void)setPrivateNavigationBar
{
    UINavigationBar * bar = self.navigationController.navigationBar;
    //首次透明
    [bar setTranslucent: true];;
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
    
    //设置起始坐标为0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
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
    if (section == 1) {
        return self.dataArr.count;
    }else if (section == 2) {
        return 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if (indexPath.section == 2) {
        cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:PicRectionViewCollectionViewCellID forIndexPath:indexPath];
        ((PicRectionViewCollectionViewCell *)cell).dataSourse = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        
    }else {
        cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:IGPicListMainCollectionViewCellID forIndexPath:indexPath];
      
        [self addImage:^{
            ((IGPicListMainCollectionViewCell *)cell).iconImage.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"]];
            
        }];
    }
    
    return cell;
}

- (void) addImage:(RunLoopBlock) block {
    [self.tasks addObject:block];
    if (self.tasks.count > 18) {
        [self.tasks removeObjectAtIndex:0];
    }
    
    
}
- (void) addRunLoopObserver {
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    CFRunLoopObserverRef runLoopObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callBack, &context);
    CFRunLoopAddObserver(runloop, runLoopObserver, kCFRunLoopCommonModes);
    
    CFRelease(runLoopObserver);
    
}
void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    NSLog(@"------123-123-------123123");
    ListViewController * vc = (__bridge ListViewController *)info;
    if (vc.tasks.count == 0) {
        return;
    }
    RunLoopBlock task = vc.tasks.firstObject;
    task();
    [vc.tasks removeObjectAtIndex:0];
   
}

- (CGFloat)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    if (indexPath.section == 1) {
        if ([self.dataArr[indexPath.item] integerValue]==1)
        {
            //横板
            return ((kScreenWidth-16)/2*1080/1920/2);
        }
        else if ([self.dataArr[indexPath.item] integerValue]==2)
        {
            //坚板
            return ((kScreenWidth-16)/2*1920/1080/2);
        }
    }if (indexPath.section == 2) {
        return 163;
    }
    return 0;
}

/** 头视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section {
    if (section == 0)
    {
        return CGSizeMake(self.view.frame.size.width, kTabViewHeight);
    }
    else
    {
        return CGSizeMake(self.view.frame.size.width, 40);
    }
}
/** 脚视图Size */
-(CGSize )waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section{
    return CGSizeZero;
}
- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
    return  UIEdgeInsetsZero;
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
        return 2;
    }
    
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:@"UICollectionElementKindSectionFooter"]) {
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reusableViewFootID forIndexPath:indexPath];
        footView.backgroundColor = [UIColor blackColor];
        NSLog(@"=============5");
        return footView;
    } else {
        if (indexPath.section == 0) {
            
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewHeaderID forIndexPath:indexPath];
            [headerView addSubview:self.headerView];
            headerView.backgroundColor = [UIColor redColor];
            NSLog(@"=============0");
            return headerView;
            
        }
        else if (indexPath.section == 1)
        {
            CollectionReusableViewTitle1 *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewTitle1ID forIndexPath:indexPath];
            headerView.totolNum.text = @"(15)";
            headerView.backgroundColor = [UIColor yellowColor];
            NSLog(@"=============1");
            return headerView;
        }else {
            CollectionReusableViewTitle2 *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewTitle2ID forIndexPath:indexPath];
            headerView.titleLabel.text = @"相关画单推荐";
            headerView.backgroundColor = [UIColor greenColor];
            NSLog(@"=============2");
            return headerView;
        }
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
    }else {
        UIImage * view = [self getImageFromView:self.headerView.backgroundImageView withContentOffY:-kTabViewHeight -kNavBarHeight];
        [self.navigationController.navigationBar setBackgroundImage:view forBarMetrics:UIBarMetricsDefault];
    }
}

- (UICollectionView *)mainCollectionView {
    if (_mainCollectionView == nil) {
        //1.初始化layout
        
        
        WSLWaterFlowLayout * layout = [[WSLWaterFlowLayout alloc] init];
        layout.delegate = self;
        layout.flowLayoutStyle = WSLVerticalWaterFlow;
        
        
        
        //2.初始化collectionView
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) collectionViewLayout:layout];
        [self.view addSubview:_mainCollectionView];
        
        if (@available(iOS 11.0, *)) {
            _mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _mainCollectionView.scrollIndicatorInsets = _mainCollectionView.contentInset;
        }
        _mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.clipsToBounds = NO;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_mainCollectionView registerClass:[PicRectionViewCollectionViewCell class] forCellWithReuseIdentifier:PicRectionViewCollectionViewCellID];
        
        [_mainCollectionView registerClass:[IGPicListMainCollectionViewCell class] forCellWithReuseIdentifier:IGPicListMainCollectionViewCellID];
        
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewHeaderID];
        [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reusableViewFootID];
        [_mainCollectionView registerClass:[CollectionReusableViewTitle1 class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewTitle1ID];
        [_mainCollectionView registerClass:[CollectionReusableViewTitle2 class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewTitle2ID];
        
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

- (NSMutableArray *)tasks {
    if (_tasks == nil) {
        _tasks = [NSMutableArray new];
    }
    return _tasks;
}

@end














