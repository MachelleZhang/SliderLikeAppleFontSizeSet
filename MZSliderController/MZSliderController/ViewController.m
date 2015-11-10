//
//  ViewController.m
//  MZSliderController
//
//  Created by Zhangle on 15/11/10.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //滑块设置
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 100, 300, 20)];
    _slider.minimumValue = 1;
    _slider.maximumValue = 7;
    _slider.minimumTrackTintColor = [UIColor clearColor];
    _slider.maximumTrackTintColor = [UIColor clearColor];

    //背景图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 100, 295, 20)];
    UIImage *img = [UIImage imageNamed:@"bg"];
    imageView.image = img;

    //添加点击手势和滑块滑动事件响应
    [_slider addTarget:self
                  action:@selector(valueChanged:)
        forControlEvents:UIControlEventValueChanged];
    UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];

    [_slider addGestureRecognizer:tap];
    [self.view addSubview:imageView];
    [self.view addSubview:_slider];
}

- (void)valueChanged:(UISlider *)sender
{
    //只取整数值，固定间距
    NSString *tempStr = [self numberFormat:sender.value];
    [sender setValue:tempStr.floatValue];
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    //取得点击点
    CGPoint p = [sender locationInView:_slider];
    //计算处于背景图的几分之几，并将之转换为滑块的值（1~7）
    float tempFloat = (p.x - 15) / 295.0 * 7 + 1;
    NSString *tempStr = [self numberFormat:tempFloat];
    //    NSLog(@"%f,%f,%@", p.x, tempFloat, tempStr);
    [_slider setValue:tempStr.floatValue];
}

/**
 *  四舍五入
 *
 *  @param num 待转换数字
 *
 *  @return 转换后的数字
 */
- (NSString *)numberFormat:(float)num
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"0"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
}

@end
