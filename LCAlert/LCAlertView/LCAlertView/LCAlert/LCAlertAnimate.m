
//
//  LCAlertAnimate.m
//  huazhu
//
//  Created by lynb180305 on 2018/8/16.
//  Copyright © 2018年 zhenhua.shen. All rights reserved.
//

#import "LCAlertAnimate.h"

@interface LCAlertAnimate ()

@end

@implementation LCAlertAnimate
/** 定义动画时间 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

/** 定义动画效果 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    //对应关系
    BOOL isPresent = (toViewController.presentingViewController == fromViewController);
    if (!isPresent) {
        [self dismissAnimateTransition:transitionContext];
    }else{
        //转场的容器图，动画完成之后会消失
        UIView *containerView =  [transitionContext containerView];
        UIView *toView = nil;
        
        if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
            toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        }else{
            toView = toViewController.view;
        }

        CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
        
        if (isPresent) {
            toView.frame = toFrame;
            [containerView addSubview:toView];
        }
        
        NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
        toView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
        toView.alpha = 0.4;
        [UIView animateWithDuration:transitionDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.layer.transform = CATransform3DMakeScale(1, 1, 1);
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            
            if (isCancelled)
                [toView removeFromSuperview];
            
            [transitionContext completeTransition:YES];
        }];
//        [UIView animateWithDuration:transitionDuration animations:^{
//            
//        } completion:^(BOOL finished) {
//          
//        }];

    }
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
     UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //转场的容器图，动画完成之后会消失
    
    UIView *containerView =  [transitionContext containerView];
    UIView *toView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        toView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    }else{
        toView = toViewController.view;
    }
    
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    toView.alpha = 1;

    [UIView animateWithDuration:transitionDuration animations:^{
        
        toView.alpha = 0;
    } completion:^(BOOL finished) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        
        if (isCancelled)
            [toView removeFromSuperview];
        
        [transitionContext completeTransition:YES];
    }];

}
@end
