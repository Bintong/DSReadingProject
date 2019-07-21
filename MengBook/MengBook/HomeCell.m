//
//  HomeCell.m
//  MengP2P
//
//  Created by BinTong on 2017/8/1.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
    self.img.layer.shadowColor = HB_COLOR_C.CGColor;
    self.img.layer.shadowOffset = CGSizeMake(1, 1);
    self.img.layer.shadowOpacity = 0.4;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
