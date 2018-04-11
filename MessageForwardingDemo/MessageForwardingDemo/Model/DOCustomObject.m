//
//  DOCustomObject.m
//  MessageForwardingDemo
//
//  Created by 魏欣宇 on 2018/4/11.
//  Copyright © 2018年 Dino. All rights reserved.
//

#import <objc/message.h>
#import "DOCustomObject.h"
#import "DOAnotherObject.h"

@implementation DOCustomObject

/**
 待添加的新方法
 */
void runTimeMethod(id self, SEL _cmd, NSString *str) {
    NSLog(@"runTimeMethod------%@", str);
}

#pragma mark - 1：所属类动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"sel = %@", NSStringFromSelector(sel));
    
    //动态添加方法
//    if (sel == @selector(customMethod))
//    {
//        /**
//         "v@:" 不含参数；
//         "v@:@" 含一个对象参数
//         */
//        class_addMethod(self, sel, (IMP)runTimeMethod, "v@:@");
//        return YES;
//    }
    
    return [super resolveInstanceMethod:sel];
}

#pragma mark - 2：备援接收者
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"aSelector = %@", NSStringFromSelector(aSelector));
    
//    return [[DOAnotherObject alloc] init];
    
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 3：消息重定向
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(customMethod))
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    else
    {
        return [super methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"-----%@",anInvocation);
    
    SEL another_selector = [anInvocation selector];

    DOAnotherObject *another_object = [[DOAnotherObject alloc] init];

    if ([another_object respondsToSelector:another_selector])
    {
        [anInvocation invokeWithTarget:another_object];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}



@end
