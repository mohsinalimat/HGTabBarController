//
//  HGTabBar.m
//  HGTabBarController
//
//  Created by 查昊 on 16/6/11.
//  Copyright © 2016年 Zohar. All rights reserved.
//

#import "HGTabBar.h"
//自定义按钮
@interface HGTabbarButton : UIButton

@end

//实现自定义的btn
@implementation HGTabbarButton

//图片高亮时候会调用这个方法,取消高亮
-(void)setHighlighted:(BOOL)highlighted{
    
}

@end

#define TabBarbackColor   [UIColor  colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f]

@interface HGTabBar ()
@property (nonatomic,weak)UIButton    *selectedBtn;// <-当前选中的按钮
@property (nonatomic,weak)UIImageView *splitLine;// <-分割线
@property (nonatomic,weak)UIView      *tabBarBackgroundView;// <-背景View
@end
@implementation HGTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark 初始化按钮
-(void)tabbarWithTitles:(NSArray<NSString *> *)titles
          titleNorColor:(UIColor *)normalColor
          titleSelColor:(UIColor *)selectedColor
           normalImages:(NSArray<NSString *> *)normalImges
               selImges:(NSArray<NSString *> *)selImges
{
    
    UIView *tabBarBackgroundView=[[UIView alloc]init];
    tabBarBackgroundView.backgroundColor=TabBarbackColor;
    [self addSubview:tabBarBackgroundView];
    _tabBarBackgroundView=tabBarBackgroundView;
    
    UIImageView *splitLine=[[UIImageView alloc]init];
    splitLine.backgroundColor=[UIColor colorWithWhite:0.7 alpha:1.0f];
    [self addSubview:splitLine];
    _splitLine=splitLine;
    
    for (NSInteger i=0; i<normalImges.count; i++) {
        // 创建按钮
        UIButton *btn = [HGTabbarButton buttonWithType:UIButtonTypeCustom];
        
        // 设置属性
        btn.backgroundColor=[UIColor clearColor];
        
        [btn setBackgroundImage:nil forState:UIControlStateNormal];
        [btn setBackgroundImage:nil forState:UIControlStateSelected];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateSelected];
        
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        
        [btn setImage:[UIImage imageNamed:normalImges[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selImges[i]] forState:UIControlStateSelected];
        
        btn.titleLabel.font=_font ? _font :[UIFont systemFontOfSize:12.0f];
        
        //监听事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        //绑定tag
        btn.tag = i;
        
        [_tabBarBackgroundView addSubview:btn];
        //设置默认选中
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
    }
    
    _titles=titles;
    
}

// 布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor=TabBarbackColor;
    
    //背景View的frame
    _tabBarBackgroundView.frame=self.bounds;
    
    //分割线的frame
    NSInteger count = _tabBarBackgroundView.subviews.count;
    CGFloat width=_tabBarBackgroundView.bounds.size.width;
    _splitLine.frame=CGRectMake(0,-0.5f,width,0.5f);
    
    //按钮宽度与高度
    CGFloat btnW =  width/ count;
    CGFloat btnH = _tabBarBackgroundView.bounds.size.height;
    
    //按钮的frame
    for (UIButton *btn in _tabBarBackgroundView.subviews) {
        btn.frame = CGRectMake(btnW * btn.tag, 1, btnW, btnH-1);
        btn.titleEdgeInsets=_titleEdgeInsets;
        btn.imageEdgeInsets=_imageEdgeInsets;
        btn.contentEdgeInsets=_contentEdgeInsets;
        btn.titleLabel.textAlignment=_textAlignment;
    }
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex=selectedIndex;
    
    [self btnClick:_tabBarBackgroundView.subviews[selectedIndex]];
}

// 按钮点击事件
-(void)btnClick:(UIButton *)btn{
    
    //取消之前选中
    self.selectedBtn.selected = NO;
    
    //设置当前选中
    btn.selected = YES;
    self.selectedBtn = btn;
    _selectedIndex=self.selectedBtn.tag;
    
    // 响应代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [self.delegate tabBar:self didSelectItem:_selectedIndex];
    }
}
@end


