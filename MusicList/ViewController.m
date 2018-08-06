//
//  ViewController.m
//  MusicList
//
//  Created by sharui on 2018/5/8.
//  Copyright © 2018年 com.sharui.demo. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"
#import "MoveTableViewViewController.h"
#import "ClickImageViewController.h"
#import "CustomSliderView.h"
#import "IGFullScreenPreviewVC.h"
#import "MoveTableViewViewController.h"
#import "ImageViewController.h"
#import <objc/runtime.h>
#import "NSTimer+SRTimer.h"
@interface ViewController ()<ClickImageViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL isFinished;
@property (nonatomic, strong) NSMutableArray *titleNameArray;
@property (nonatomic, strong) NSMutableArray *classNameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isFinished = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self.titleNameArray addObjectsFromArray: @[@"音乐列表",@"剪切图片",@"移动table",@"方向旋转",@"timer测试"]];;
    [self.classNameArray addObjectsFromArray:@[@"ListViewController",@"ImageViewController",@"MoveTableViewViewController",@"IGFullScreenPreviewVC",@"TimerViewController"]];
//    
//
//    CustomSliderView * sliderView = [[CustomSliderView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 50)];
//    [self.view addSubview:sliderView];
//    sliderView.beginTime = @"0";
//    sliderView.endTime = @"100";
//    sliderView.setBeginTimeBlock = ^(NSString *beginTime) {
//        NSLog(@"%@",beginTime);
//    };
//    
//    
//    //    if (@available(iOS 10.0, *)) {
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
////        NSThread * therd = [[NSThread alloc] init];
//        NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
//        NSRunLoop * current = [NSRunLoop currentRunLoop];
//        [current addTimer:timer forMode:NSRunLoopCommonModes];
//        
//        while (!_isFinished) {
//            
//            [current runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.00001]];
//            
//        }
////        [therd start];
//    });




    
}
- (void)timerMethod {
    NSLog(@"3");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleNameArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * name = self.titleNameArray[indexPath.row];
    NSString * classNameStr = self.classNameArray[indexPath.row];
    Class ClassName = NSClassFromString(classNameStr);

    if ([name isEqualToString:@"方向旋转"]) {
        IGFullScreenPreviewVC * vc = [[IGFullScreenPreviewVC alloc] initWithCollectionViewLayout:[IGAlbumPreviewLayout new]];
        vc.artworkPlate = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        id vc = [[ClassName alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    cell.textLabel.text = self.titleNameArray[indexPath.row];
    return cell;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (NSMutableArray *)titleNameArray {
    if (_titleNameArray == nil) {
        _titleNameArray = [NSMutableArray new];
    }
    return _titleNameArray;
}
- (NSMutableArray *)classNameArray {
    if (_classNameArray == nil) {
        _classNameArray = [NSMutableArray new];
    }
    return _classNameArray;
}
@end
