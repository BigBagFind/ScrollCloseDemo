//
//  ViewController.m
//  ScrollCloseDemo
//
//  Created by 吴玉铁 on 2016/10/6.
//  Copyright © 2016年 吴玉铁. All rights reserved.
//

#import "ViewController.h"
#import "CloseCell.h"

CGFloat const closeOffset = 60;



#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreeHeight [UIScreen mainScreen].bounds.size.height

#define kDetailControllerClose self.tableView.contentSize.height > kScreeHeight ? (self.tableView.contentOffset.y - (self.tableView.contentSize.height - kScreeHeight) > closeOffset) : (self.tableView.contentOffset.y > closeOffset)





@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>




@property (nonatomic, strong) CloseCell *closeCell;






@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, -44, 0)];
    
}




#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 19) {
        CloseCell *closeCell = [[[NSBundle mainBundle] loadNibNamed:@"CloseCell" owner:nil options:nil] lastObject];
        self.closeCell = closeCell;
        return closeCell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hahaha"];
    cell.textLabel.text = [NSString stringWithFormat:@"here is row:%zd",indexPath.row];
    return cell;
}


#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    
    
    NSLog(@"offsetY：%lf",offsetY);
    NSLog(@"contentHeight：%lf",contentHeight);
    
    if (self.closeCell) {
//        if (contentHeight > kScreeHeight) {
//            self.closeCell.isCloseing = (offsetY - (contentHeight - kScreeHeight) > closeOffset);
//        } else {
//            self.closeCell.isCloseing = offsetY > closeOffset;
//        }
        self.closeCell.isCloseing = kDetailControllerClose;
    }
    
    
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (kDetailControllerClose) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreeHeight)];
        imgV.image = [self getImage];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:imgV];
        [self.navigationController popViewControllerAnimated:NO];
        imgV.alpha = 1.0;
        [UIView animateWithDuration:0.3 animations:^{
            imgV.frame = CGRectMake(0, kScreeHeight / 2, kScreenWidth, 0);
            imgV.alpha = 0.0;
        } completion:^(BOOL finished) {
            [imgV removeFromSuperview];
        }];
    }
}

// 获得当前截图用作当前返回
- (UIImage *)getImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, kScreeHeight), NO, 1.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
