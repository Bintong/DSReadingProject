//
//  BookShelfCell.h
//  MengBook
//
//  Created by BinTong on 2017/8/21.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)();

@interface BookShelfCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property(nonatomic, copy) TapBlock block;

@end
