//
//  ViewController.m
//  MusicList
//
//  Created by sharui on 2018/5/7.
//  Copyright © 2018年 com.sharui.demo. All rights reserved.
//
#import "HeaderView.h"
#import "ListViewController.h"


@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tab;
@property (nonatomic, strong) HeaderView *headerView;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.tab];
    self.navigationItem.title = @"呵呵";
    
    [self setTableViewHeaderView];
    
}
- (void)setTableViewHeaderView {
    __weak typeof(self) weakSelf = self;
    self.headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTabViewHeight)];
    [self.headerView setIconPicStr:@"123" withCompleteBlock:^{
        [weakSelf scrollViewDidScroll:weakSelf.tab]; //回调后刷新navigationBar
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setPrivateNavigationBar];
    [self scrollViewDidScroll:self.tab];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UINavigationBar * bar = self.navigationController.navigationBar;

    self.navigationController.navigationBar.subviews[0].alpha = 1.0;
    [bar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[self createImageWithColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]]];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kTabViewHeight;
    }else {
        return 50; //绿色导航条
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = _tab.contentOffset.y;
    NSLog(@"%f",y);
    
    if (y < - KHeadViewOff) {
        [self.tab setContentOffset:CGPointMake(0, - KHeadViewOff + 1) animated:0];
    }
    
    if ( y < kTabViewHeight) {
        //截图背景图的部分截图 用于设置navigatonBar背景图，造成连贯视觉落差
        UIImage * view = [self getImageFromView:self.headerView.backgroundImageView withContentOffY: -(self.tab.contentOffset.y) - KHeadViewOff];
        [self.navigationController.navigationBar setBackgroundImage:view forBarMetrics:UIBarMetricsDefault];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return self.headerView;
    }else {
       UIView *view = [UIView new];
        view.backgroundColor = [UIColor greenColor];
        return view;
    }
}

- (UITableView *)tab {
    if (_tab == nil) {
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStylePlain];
        _tab.backgroundColor = [UIColor whiteColor];
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tab.delegate = self;
        _tab.dataSource = self;
        _tab.clipsToBounds = NO;
//        _tab.bounces = NO;
        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                _tab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
    }
    return _tab;
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
