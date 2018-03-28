#import "TransitionObject.h"
#import "nswyFollowViewController.h"
#import "nswyMVViewController.h"
#import "CarVideoCell.h"
#import "NXHNaviController.h"
@implementation TransitionObject
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    nswyFollowViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
       nswyMVViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    CarVideoCell * cell =[fromVC.tableView cellForRowAtIndexPath:[fromVC.tableView indexPathForSelectedRow] ]  ;
    CGPoint  point = fromVC.tableView.contentOffset;
    CGRect frame =  CGRectMake(cell.mj_x, cell.mj_y-point.y, cell.imgurl.mj_w, cell.imgurl.mj_h);
    UIView * cellsnapshot = [cell.imgurl snapshotViewAfterScreenUpdates:NO];
    cellsnapshot.frame = frame;
    cellsnapshot.hidden = NO;
    cell.hidden = YES;
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha  = 0;
    toVC.fatherView.hidden  =YES;
    [containerView addSubview:toVC.view];
  [containerView addSubview:cellsnapshot];
    [ UIView animateWithDuration:[self transitionDuration:transitionContext]delay:0.0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
         toVC.view.alpha =1.0;
        CGRect Frame = CGRectMake(0, 0, ZJScreenW, ZJScreenW*1.0/16*9);
        cellsnapshot.frame = Frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [cellsnapshot removeFromSuperview];
            toVC.fatherView.hidden =NO;
            fromVC.view.hidden = NO;
            cell.hidden = NO;
        }];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}
@end
