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
@interface ViewController ()<ClickImageViewControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"123";
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    [self.view addSubview:self.imageView];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UIImage *image = [UIImage imageNamed:@"1525674467336.jpg"]; //换成sd

    ClickImageViewController * clipView = [[ClickImageViewController alloc]initWithImage:image];
    clipView.delegate = self;
    clipView.radius = 150;   //设置 裁剪框的半径
    clipView.scaleRation = 5;
    [self.navigationController pushViewController:clipView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ClipViewController:(ClickImageViewController *)clipViewController FinishClipImage:(UIImage *)editImage{
    self.imageView.image = editImage;
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
