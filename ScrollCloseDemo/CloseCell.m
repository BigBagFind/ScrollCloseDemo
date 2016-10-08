//
//  CloseCell.m
//  ScrollCloseDemo
//
//  Created by 吴玉铁 on 2016/10/6.
//  Copyright © 2016年 吴玉铁. All rights reserved.
//

#import "CloseCell.h"

@interface CloseCell ()

@property (strong, nonatomic) IBOutlet UIImageView *closeImg;

@property (strong, nonatomic) IBOutlet UILabel *closeLbl;

@end


@implementation CloseCell

- (void)setIsCloseing:(BOOL)isCloseing {
    if (_isCloseing != isCloseing) {
        _isCloseing = isCloseing;
        self.closeImg.image = [UIImage imageNamed:isCloseing ? @"newscontent_drag_return" : @"newscontent_drag_arrow"];
        self.closeLbl.text = isCloseing ? @"松手关闭当前页" : @"上拉关闭当前页" ;
    }
}





@end
