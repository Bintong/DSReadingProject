//
//  WordCell.h
//  MengBook
//
//  Created by BinTong on 2017/8/17.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *wordsLabel;

@end
