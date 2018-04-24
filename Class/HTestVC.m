//
//  HTestVC.m
//  Baby360
//
//  Created by zhangchutian on 15/4/29.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "HTestVC.h"
@implementation BDebugMenuItem
@end

@interface HTestVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *menuData;
@end

@implementation HTestVC

- (NSMutableArray *)menuData
{
    if (!_menuData) _menuData = [NSMutableArray new];
    return _menuData;
}

- (void)addMenu:(NSString *)title callback:(HTestCallback)callback
{
    [self addMenu:title subTitle:nil callback:callback];
}

- (void)addMenu:(NSString *)title subTitle:(NSString *)subTitle callback:(HTestCallback)callback
{
    BDebugMenuItem *item = [BDebugMenuItem new];
    item.title = title;
    item.subTitle = subTitle;
    item.callback = callback;
    [self.menuData addObject:item];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MENU";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    _tableView.rowHeight = 60;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    BDebugMenuItem *item = [self.menuData objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text= item.subTitle;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BDebugMenuItem *item = [self.menuData objectAtIndex:indexPath.row];
    if (item.callback) item.callback(item, indexPath);
}
@end
