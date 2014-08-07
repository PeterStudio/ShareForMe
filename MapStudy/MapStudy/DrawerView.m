//
//  DrawerView.m
//  MapStudy
//
//  Created by dw on 14-8-6.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import "DrawerView.h"

#define contentWith     86
#define contentHeight   220

#define arrowWith       36
#define arrowHeight     76


@implementation DrawerView
@synthesize parentView,drawState,mapSetTableView;
@synthesize arrow;


- (id)initWithParentView:(UIView *)parentview;
{
    self = [super initWithFrame:CGRectMake(0,0,contentWith + arrowWith, contentHeight)];
    if (self) {
        // Initialization code
        parentView = parentview;
        
        //一定要开启
        [parentView setUserInteractionEnabled:YES];
        
        
        mapSetTableView = [[UITableView alloc] initWithFrame:CGRectMake(arrowWith, 0, contentWith, contentHeight) style:UITableViewStylePlain];
        [mapSetTableView setDelegate:self];
        [mapSetTableView setDataSource:self];
        [mapSetTableView setBackgroundColor:[UIColor darkGrayColor]];
        [mapSetTableView setAlpha:0.5];
        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(arrowWith, 0, contentWith, contentHeight)];
//        [view setBackgroundColor:[UIColor darkGrayColor]];
//        [view setAlpha:0.5];
        [self addSubview:mapSetTableView];
        
        UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, arrowWith, arrowHeight)];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flower"]];
//        [imageView setFrame:arrowView.frame];
//        [arrowView addSubview:imageView];
        [arrowView setBackgroundColor:[UIColor yellowColor]];
        [arrowView setCenter:CGPointMake(arrowWith / 2, contentHeight / 2)];
        [self addSubview:arrowView];
        
        
        //移动的手势
        UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        panRcognize.delegate=self;
        [panRcognize setEnabled:YES];
        [panRcognize delaysTouchesEnded];
        [panRcognize cancelsTouchesInView];
        
        [arrowView addGestureRecognizer:panRcognize];
        
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        tapRecognize.numberOfTapsRequired = 1;
        tapRecognize.delegate = self;
        [tapRecognize setEnabled :YES];
        [tapRecognize delaysTouchesBegan];
        [tapRecognize cancelsTouchesInView];
        
        [arrowView addGestureRecognizer:tapRecognize];
        
        //设置两个位置的坐标
        leftPoint = CGPointMake(parentview.frame.size.width + (contentWith+ arrowWith) / 2 - arrowWith, parentview.frame.size.height / 2);
        rightPoint = CGPointMake(parentview.frame.size.width - (contentWith + arrowWith) / 2, parentview.frame.size.height / 2);
        self.center =  leftPoint;
        
        //设置起始状态
        drawState = DrawerViewStateLeft;
    }
    return self;
}


#pragma UIGestureRecognizer Handles
/*
 *  移动图片处理的函数
 *  @recognizer 移动手势
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:parentView];
    if (self.center.x + translation.x < rightPoint.x) {
        self.center = rightPoint;
    }else if(self.center.x + translation.x > leftPoint.x)
    {
        self.center = leftPoint;
    }else{
        self.center = CGPointMake(self.center.x + translation.x,self.center.y);
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:parentView];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            NSLog(@"center.x:%f  leftPoint.x:%f",self.center.x,leftPoint.x);
            if (self.center.x < leftPoint.x - contentWith / 2) {
                self.center = rightPoint;
                [self transformArrow:DrawerViewStateRight];
            }else
            {
                self.center = leftPoint;
                [self transformArrow:DrawerViewStateLeft];
            }
            
        } completion:nil];
        
    }
}

/*
 *  handleTap 触摸函数
 *  @recognizer  UITapGestureRecognizer 触摸识别器
 */
-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        if (drawState == DrawerViewStateLeft) {
            self.center = rightPoint;
            [self transformArrow:DrawerViewStateRight];
        }else
        {
            self.center = leftPoint;
            [self transformArrow:DrawerViewStateLeft];
        }
    } completion:nil];
    
}

/*
 *  transformArrow 改变箭头方向
 *  state  DrawerViewState 抽屉当前状态
 */
-(void)transformArrow:(DrawerViewState) state
{
    //NSLog(@"DRAWERSTATE :%d  STATE:%d",drawState,state);
    [UIView animateWithDuration:0.3 delay:0.35 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (state == DrawerViewStateRight){
            arrow.transform = CGAffineTransformMakeRotation(M_PI);
        }else
        {
            arrow.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finish){
        drawState = state;
    }];
    
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 25;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"CellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.backgroundColor = tableView.backgroundColor;
    cell.textLabel.text = [NSString stringWithFormat:@"indexPathRow:%d",indexPath.row];
    [cell.textLabel setTextColor:[UIColor purpleColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
