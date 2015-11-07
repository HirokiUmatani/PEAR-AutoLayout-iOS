//
//  ViewController.m
//  AutoLayout
//
//  Created by hirokiumatani on 2015/11/07.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import "ViewController.h"
#import "AutoLayout.h"
@interface ViewController ()
@property (strong, nonatomic) UIView *overView;
@property (strong, nonatomic) AutoLayout *autoLayout;
@property (assign, nonatomic) BOOL isAnimation;
@property (assign, nonatomic) NSInteger view_point;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutoLayout];
    [self setGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - autoLayout
- (void)setAutoLayout
{
    _overView = [UIView new];
    _overView.backgroundColor = [UIColor whiteColor];
    _autoLayout = [AutoLayout baseView:self.view addSubView:_overView];
}



#pragma mark - selector action
typedef NS_ENUM(NSInteger,ViewPoint)
{
    CENTER_POINT,
    UP_POINT,
    DOWN_POINT,
    LEFT_POINT,
    RIGHT_POINT
    
};
#define MARGIN 25
- (void)tap:(UITapGestureRecognizer *)sender
{
    
    if (_isAnimation)return;
    
    [_autoLayout part:TOP_CONSTRAINT margin:0];
    [_autoLayout part:BOTTOM_CONSTRAINT margin:0];
    [_autoLayout part:LEFT_CONSTRAINT margin:0];
    [_autoLayout part:RIGHT_CONSTRAINT margin:0];
    
    _isAnimation = YES;
    [UIView animateWithDuration:0.6
                     animations:^
     {
         [self.view layoutIfNeeded];
     }
                     completion:^(BOOL finished)
     {
         _isAnimation = NO;
         _view_point = CENTER_POINT;
     }];

}
- (void)down:(UISwipeGestureRecognizer *)sender
{
    if (_isAnimation)return;
    
    if (_view_point == UP_POINT)
    {
        [_autoLayout part:BOTTOM_CONSTRAINT margin:0];
        _isAnimation = YES;
        [UIView animateWithDuration:0.6
                         animations:^
         {
             [self.view layoutIfNeeded];
         }
                         completion:^(BOOL finished)
         {
             _isAnimation = NO;
             _view_point = CENTER_POINT;
         }];
    }
    else if (_view_point == CENTER_POINT)
    {
        [_autoLayout part:TOP_CONSTRAINT margin:self.view.frame.size.height-MARGIN];
        
        _isAnimation = YES;
        [UIView animateWithDuration:0.6
                         animations:^
         {
             [self.view layoutIfNeeded];
             self.view.backgroundColor = [UIColor redColor];
         }
                         completion:^(BOOL finished)
         {
             _isAnimation = NO;
             _view_point = DOWN_POINT;
             
         }];
    }
    
}
- (void)up:(UISwipeGestureRecognizer *)sender
{
    if (_isAnimation||_view_point == UP_POINT)return;
    if (_view_point == DOWN_POINT)
    {
        [_autoLayout part:TOP_CONSTRAINT margin:0];
        _isAnimation = YES;
        [UIView animateWithDuration:0.6
                         animations:^
         {
             [self.view layoutIfNeeded];
         }
                         completion:^(BOOL finished)
         {
             _isAnimation = NO;
             _view_point = CENTER_POINT;
         }];
    }
    else if (_view_point == CENTER_POINT)
    {
        [_autoLayout part:BOTTOM_CONSTRAINT margin:self.view.frame.size.height-MARGIN];
        
        _isAnimation = YES;
        [UIView animateWithDuration:0.6
                         animations:^
         {
             [self.view layoutIfNeeded];
             self.view.backgroundColor = [UIColor blueColor];
         }
                         completion:^(BOOL finished)
         {
             _isAnimation = NO;
             _view_point = UP_POINT;
             
         }];
    }
}

- (void)left:(UISwipeGestureRecognizer *)sender
{
    if (_isAnimation)return;
    
    if (_view_point == RIGHT_POINT)
    {
        [_autoLayout part:LEFT_CONSTRAINT margin:0];
        
        _isAnimation = YES;
        [UIView animateWithDuration:0.6
                         animations:^
         {
             [self.view layoutIfNeeded];
         }
                         completion:^(BOOL finished)
         {
             _isAnimation = NO;
             _view_point = CENTER_POINT;
         }];
    }
    else if (_view_point == CENTER_POINT)
    {
        [_autoLayout part:RIGHT_CONSTRAINT margin:self.view.frame.size.width-MARGIN];
        
        _isAnimation = YES;
        [UIView animateWithDuration:0.6
                         animations:^
         {
             [self.view layoutIfNeeded];
             self.view.backgroundColor = [UIColor yellowColor];
         }
                         completion:^(BOOL finished)
         {
             _isAnimation = NO;
             _view_point = LEFT_POINT;
             
         }];
    }
    
}

- (void)right:(UISwipeGestureRecognizer *)sender
{
    if (_isAnimation||_view_point == RIGHT_POINT)return;
    if (_view_point == LEFT_POINT)
    {
        [_autoLayout part:RIGHT_CONSTRAINT margin:0];
        
        _isAnimation = YES;
        [UIView animateWithDuration:0.6
                         animations:^
         {
             [self.view layoutIfNeeded];
         }
                         completion:^(BOOL finished)
         {
             _isAnimation = NO;
             _view_point = CENTER_POINT;
         }];
    }
    else if (_view_point == CENTER_POINT)
    {
        [_autoLayout part:LEFT_CONSTRAINT margin:self.view.frame.size.width-MARGIN];
        
        _isAnimation = YES;
        [UIView animateWithDuration:0.6
                         animations:^
         {
             [self.view layoutIfNeeded];
             self.view.backgroundColor = [UIColor greenColor];
         }
                         completion:^(BOOL finished)
         {
             _isAnimation = NO;
             _view_point = RIGHT_POINT;
             
         }];
    }
}

#pragma mark - Gesture
- (void)setGesture
{
    [self setTapGesture];
    [self setDownSwipeGesture];
    [self setUpSwipeGesture];
    [self setLeftSwipeGesture];
    [self setRightSwipeGesture];
}
- (void)setTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)setDownSwipeGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(down:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
}

- (void)setUpSwipeGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(up:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipe];
}

- (void)setLeftSwipeGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(left:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
}

- (void)setRightSwipeGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(right:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}
@end
