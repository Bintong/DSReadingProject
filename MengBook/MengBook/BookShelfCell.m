//
//  BookShelfCell.m
//  MengBook
//
//  Created by BinTong on 2017/8/21.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "BookShelfCell.h"


@implementation BookShelfCell
- (IBAction)tap1:(id)sender {
    self.block();
}
- (IBAction)tap2:(id)sender {
    self.block();
}
- (IBAction)tap3:(id)sender {
    self.block();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.button1.layer.shadowColor = HB_COLOR_C.CGColor;
    self.button1.layer.shadowOffset = CGSizeMake(1, 1);
    self.button1.layer.shadowOpacity = 0.4;
    
    self.button2.layer.shadowColor = HB_COLOR_C.CGColor;
    self.button2.layer.shadowOffset = CGSizeMake(1, 1);
    self.button2.layer.shadowOpacity = 0.4;
    
    self.button3.layer.shadowColor = HB_COLOR_C.CGColor;
    self.button3.layer.shadowOffset = CGSizeMake(1, 1);
    self.button3.layer.shadowOpacity = 0.4;

}

- (void)layoutSubviews {
    CGFloat gap  = (SCREEN_WIDTH - _button1.width*3)/4;
    self.button2.centerX = SCREEN_WIDTH/2;
    self.button1.right = self.button2.left - gap;
    self.button3.left = self.button2.right + gap;
    
    
    self.label1.left = self.button1.left;
    self.label1.centerX = self.button1.centerX;
    self.label1.width = self.button1.width;
    
    self.label2.left = self.button2.left;
    self.label2.centerX = self.button2.centerX;
    self.label2.width = self.button2.width;
    
    self.label3.left = self.button3.left;
    self.label3.centerX = self.button3.centerX;
    self.label3.width = self.button3.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 
}



@end
