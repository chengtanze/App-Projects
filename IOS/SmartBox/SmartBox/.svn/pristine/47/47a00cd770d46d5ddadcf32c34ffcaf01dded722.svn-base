//
//  PKViewController.m
//  Smartbox
//
//  Created by Mesada on 14/12/31.
//  Copyright (c) 2014年 mesada. All rights reserved.
//

#import "PKViewController.h"
#import "PKListTableViewController.h"

static const NSInteger TAG_OFFSET = 1000;

@interface PKViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tabbuttons;
@property (strong, nonatomic) IBOutlet UIView *contentContainerView;
- (IBAction)tabButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *tabButtonsContainerView;

@end

@implementation PKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PKListTableViewController *listViewController1 = [[PKListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    PKListTableViewController *listViewController2 = [[PKListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    PKListTableViewController *listViewController3 = [[PKListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    

    self.viewControllers = [NSArray arrayWithObjects:listViewController1, listViewController2, listViewController3, nil];
  
    _selectedIndex = NSNotFound;
    self.selectedIndex = 0;
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
- (void)selectTabButton:(UIButton *)button
{
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIImage *image = [[UIImage imageNamed:@"4-2SMART-BOX-PK榜_tab按钮"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
    
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.5f] forState:UIControlStateNormal];
}

- (void)deselectTabButton:(UIButton *)button
{
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *image = [[UIImage imageNamed:@"4-2SMART-BOX-PK榜_tab按钮"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:nil forState:UIControlStateHighlighted];
//
//    [button setTitleColor:[UIColor colorWithRed:175/255.0f green:85/255.0f blue:58/255.0f alpha:1.0f] forState:UIControlStateNormal];
//    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)tabButtonPressed:(UIButton *)sender
{
    [self setSelectedIndex:sender.tag - TAG_OFFSET animated:YES];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
    [self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setViewControllers:(NSArray *)newViewControllers
{
    NSAssert([newViewControllers count] >= 2, @"MHTabBarController requires at least two view controllers");
    
    UIViewController *oldSelectedViewController = self.selectedViewController;
    
    // Remove the old child view controllers.
    for (UIViewController *viewController in _viewControllers)
    {
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    
    _viewControllers = [newViewControllers copy];
    
    // This follows the same rules as UITabBarController for trying to
    // re-select the previously selected view controller.
    NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
    if (newIndex != NSNotFound)
        _selectedIndex = newIndex;
    else if (newIndex < [_viewControllers count])
        _selectedIndex = newIndex;
    else
        _selectedIndex = 0;
    
    // Add the new child view controllers.
    for (UIViewController *viewController in _viewControllers)
    {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
  
//    if ([self isViewLoaded])
//        [self reloadTabButtons];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
    NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
    
    if ([self.delegate respondsToSelector:@selector(mh_tabBarController:shouldSelectViewController:atIndex:)])
    {
        UIViewController *toViewController = [self.viewControllers objectAtIndex:newSelectedIndex];
        if (![self.delegate mh_tabBarController:self shouldSelectViewController:toViewController atIndex:newSelectedIndex])
            return;
    }
    
    if (![self isViewLoaded])
    {
        _selectedIndex = newSelectedIndex;
    }
    else if (_selectedIndex != newSelectedIndex)
    {
        UIViewController *fromViewController;
        UIViewController *toViewController;
        
        if (_selectedIndex != NSNotFound)
        {
            UIButton *fromButton =[_tabbuttons objectAtIndex:_selectedIndex];
//            UIButton *fromButton = (UIButton *)[tabButtonsContainerView viewWithTag:TAG_OFFSET + _selectedIndex];
            [self deselectTabButton:fromButton];
            fromViewController = self.selectedViewController;
        }
        
        NSUInteger oldSelectedIndex = _selectedIndex;
        _selectedIndex = newSelectedIndex;
        
        UIButton *toButton;
        if (_selectedIndex != NSNotFound)
        {
            toButton = [_tabbuttons objectAtIndex:_selectedIndex];
//            toButton = (UIButton *)[tabButtonsContainerView viewWithTag:TAG_OFFSET + _selectedIndex];
            [self selectTabButton:toButton];
            toViewController = self.selectedViewController;
        }
        
        if (toViewController == nil)  // don't animate
        {
            [fromViewController.view removeFromSuperview];
        }
        else if (fromViewController == nil)  // don't animate
        {
            toViewController.view.frame = _contentContainerView.bounds;
            [_contentContainerView addSubview:toViewController.view];
//            [self centerIndicatorOnButton:toButton];
            
            if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
                [self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
        }
        else if (animated)
        {
            CGRect rect = _contentContainerView.bounds;
            if (oldSelectedIndex < newSelectedIndex)
                rect.origin.x = rect.size.width;
            else
                rect.origin.x = -rect.size.width;
            
            toViewController.view.frame = rect;
            _tabButtonsContainerView.userInteractionEnabled = NO;
            NSLog(@"%[%f,%f,%f,%f]",fromViewController.view.frame.origin.x,fromViewController.view.frame.origin.y,fromViewController.view.frame.size.width,fromViewController.view.frame.size.height);
    
            [self transitionFromViewController:fromViewController
                              toViewController:toViewController
                                      duration:0.3
                                       options:/*UIViewAnimationOptionLayoutSubviews | */UIViewAnimationOptionCurveEaseOut
                                    animations:^
             {
                 CGRect rect = fromViewController.view.frame;
                 if (oldSelectedIndex < newSelectedIndex)
                     rect.origin.x = -rect.size.width;
                 else
                     rect.origin.x = rect.size.width;
                 
                 fromViewController.view.frame = rect;
                 toViewController.view.frame = _contentContainerView.bounds;
//                 [self centerIndicatorOnButton:toButton];
             }
                                    completion:^(BOOL finished)
             {
                 _tabButtonsContainerView.userInteractionEnabled = YES;
                 
                 if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
                     [self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
             }];
        }
        else  // not animated
        {
            [fromViewController.view removeFromSuperview];
            
            toViewController.view.frame = _contentContainerView.bounds;
            [_contentContainerView addSubview:toViewController.view];
//            [self centerIndicatorOnButton:toButton];
            
            if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
                [self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
        }
    }
}

- (UIViewController *)selectedViewController
{
    if (self.selectedIndex != NSNotFound)
        return [self.viewControllers objectAtIndex:self.selectedIndex];
    else
        return nil;
}


- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
    [self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated;
{
    NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
    if (index != NSNotFound)
        [self setSelectedIndex:index animated:animated];
}


@end
