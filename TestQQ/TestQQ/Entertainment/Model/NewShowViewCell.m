//
//  NewShowViewCell.m
//  TestQQ
//
//  Created by LiDongfeng on 15/12/16.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "NewShowViewCell.h"
#import "NewShowData.h"
#import "NewShow.h"
#import "UIImageView+WebCache.h"
#import "NSString+Times.h"
#import "URL.h"

#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface NewShowViewCell()
{
    UIScrollView *_backScrollView;
}
@end

@implementation NewShowViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView
{
    _backScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH_, 150)];
    _backScrollView.contentSize=CGSizeMake(_WIDTH_*2, 0);
    _backScrollView.userInteractionEnabled=YES;
    _backScrollView.pagingEnabled=NO;
    _backScrollView.bounces=NO;
    _backScrollView.showsHorizontalScrollIndicator=NO;
    _backScrollView.showsVerticalScrollIndicator=NO;
    [self addSubview:_backScrollView];
    
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 150-6, _WIDTH_, 1)];
    lineView.backgroundColor=RGBA(230, 230, 230, 1.0);
    [self addSubview:lineView];
}

- (void)setContentView:(NSArray *)array{
    for (int i=0; i<array.count; i++) {
        NewShowData * newData=array[i];
        
        CGRect frame=CGRectMake((i+1)*5+i*90, 5, 90, 135);
        NewShow * newShowView=[[NewShow alloc]init];
        newShowView.tag=i;
        newShowView.frame=frame;
        
        [newShowView.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",NEW_Image_URl,[self countNumAndChangeformat:newData.owner_uid],NEW_Time_URl,[NSString GetNowTimes]]] placeholderImage:[UIImage imageNamed:@"Img_default"]];
        
        newShowView.name.text=newData.nickname;
        newShowView.game.text=newData.game_name;
        [_backScrollView addSubview:newShowView];
        
        UITapGestureRecognizer * tapNewView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOneNewView:)];
        [newShowView addGestureRecognizer:tapNewView];
    }
    _backScrollView.contentSize=CGSizeMake(10*90, 0);
}
//点击事件
- (void)tapOneNewView:(UIGestureRecognizer *)sender{
    NSLog(@"%ld",sender.view.tag);
}
/*
 *  处理字符串 把字符串28302855 ===> /028//30/28/55
*/
- (NSString*)countNumAndChangeformat:(NSString*)str{
    
    NSMutableString *num=[NSMutableString stringWithString:str];
    int temp=9-(int)num.length;
    
    if (temp) {
        
        for (int i=0; i<temp; i++) {
            
            [num insertString:@"0" atIndex:0];
        }
    }
    
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    
    NSMutableString *newstring = [NSMutableString string];
    while (count > 2) {
        count -= 2;
        NSRange rang = NSMakeRange(string.length - 2, 2);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"/" atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    
    [newstring insertString:string atIndex:0];
    
    [newstring insertString:@"/" atIndex:3];
    
    [newstring insertString:@"/" atIndex:0];
    
    [newstring stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    
    return newstring;
    
}
@end
