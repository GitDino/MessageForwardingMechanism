//
//  DORootVC.m
//  MessageForwardingDemo
//
//  Created by 魏欣宇 on 2018/4/11.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import "DORootVC.h"
#import "DOCustomObject.h"

@interface DORootVC ()

@end

@implementation DORootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息转发机制";
    self.view.backgroundColor = [UIColor redColor];
    
    /**因为customMethod对象方法没有实现，正常会报经典错误：[DOCustomObject customMethod]: unrecognized selector sent to instance 0x60000001ddd0 */
    DOCustomObject *custom_object = [[DOCustomObject alloc] init];
    [custom_object performSelector:@selector(customMethod) withObject:@"你猜我是谁？"];
}

@end
