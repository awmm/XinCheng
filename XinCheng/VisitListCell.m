//
//  VisitListCell.m
//  XinCheng
//
//  Created by wmm on 15/11/14.
//  Copyright © 2015年 hanen. All rights reserved.
//

#import "VisitListCell.h"
#import "Macro.h"

@implementation VisitListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        
        //选中单元格
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:(20.0f/255.0f) green:(30.0f/255.0f) blue:(40.0f/255.0f) alpha:0.5f];
        self.selectedBackgroundView = bgView;
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:([UIFont systemFontSize] * 1.2f)];
        self.textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
        self.textLabel.textColor = [UIColor colorWithRed:(196.0f/255.0f) green:(204.0f/255.0f) blue:(218.0f/255.0f) alpha:1.0f];        
        
        self.visitNum = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth/4, 40.0f)];
        self.visitSub = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, 0.0f, kScreenWidth/4, 40.0f)];
        
        self.visitPro = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0.0f, kScreenWidth/4, 40.0f)];
        self.visitDate = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4*3, 0.0f, kScreenWidth/4, 40.0f)];
        
        self.visitNum.textAlignment=NSTextAlignmentCenter;
        self.visitSub.textAlignment=NSTextAlignmentCenter;
        self.visitPro.textAlignment=NSTextAlignmentCenter;
        self.visitDate.textAlignment=NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.visitNum];
        [self.contentView addSubview:self.visitSub];
        [self.contentView addSubview:self.visitPro];
        [self.contentView addSubview:self.visitDate];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
