//
//  TimerViewController.m
//  MusicList
//
//  Created by sharui on 2018/8/6.
//  Copyright © 2018 com.sharui.demo. All rights reserved.
//

#import "TimerViewController.h"
#import "NSTimer+SRTimer.h"
@interface TimerViewController ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSTimer * timer = [NSTimer sr_scheduledTimerWithTimeInterval:1 block:^{
        NSLog(@"1");
    } repeats:YES];
    self.timer = timer;
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}
-(void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
