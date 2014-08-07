//
//  DrawerView.h
//  MapStudy
//
//  Created by dw on 14-8-6.
//  Copyright (c) 2014年 dw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    DrawerViewStateRight = 0,
    DrawerViewStateLeft
}DrawerViewState;

@interface DrawerView : UIView<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>{
    UIImageView *arrow;         //向上拖拽时显示的图片
    
    CGPoint rightPoint;            //抽屉拉出时的中心点
    CGPoint leftPoint;          //抽屉收缩时的中心点
    
    UIView *parentView;         //抽屉所在的view
    
    DrawerViewState drawState;  //当前抽屉状态
    
    UITableView *mapSetTableView;
}

- (id)initWithParentView:(UIView *)parentview;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
- (void)handleTap:(UITapGestureRecognizer *)recognizer;
- (void)transformArrow:(DrawerViewState) state;

@property (nonatomic,retain) UIView *parentView;
@property (nonatomic,retain) UIImageView *arrow;
@property (nonatomic) DrawerViewState drawState;
@property (nonatomic, retain) UITableView *mapSetTableView;

@end
