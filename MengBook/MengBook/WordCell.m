//
//  WordCell.m
//  MengBook
//
//  Created by BinTong on 2017/8/17.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "WordCell.h"

@implementation WordCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
