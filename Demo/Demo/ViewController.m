//
//  ViewController.m
//  Demo
//
//  Created by shen li on 2019/8/15.
//  Copyright © 2019 listen. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+IndicatorExt.h"
@interface ViewController ()

@property (nonatomic,strong) UITableView *tableView;
    
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
  
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIImage *image= [UIImage imageNamed:@"icon_xaingqing_huakuai"];

    [self.tableView registerILSIndicator:image imageSize:CGSizeMake(30, 52)];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88,self.view.bounds.size.width, self.view.bounds.size.height-120) style: UITableViewStylePlain];
        [_tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"tableViewCellString"];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCellString"];
    cell.textLabel.text = [NSString stringWithFormat:@"CurrentCell%ld",(long)indexPath.row];
    return cell;
}
@end
