//
//  ViewController.m
//  AlertSound
//
//  Created by LV on 16/6/16.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "ViewController.h"
#import "SystemSoundInfo.h"
#import "SystemSoundManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * tableData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableData = [NSMutableArray array];
    [self buildTableView];
    [self loadSystemSoundData];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)loadSystemSoundData
{
    _tableData = [[SystemSoundManager defaultCenter] getSoundData];
    [_tableView reloadData];
}

- (void)buildTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - TableView Delegate/Datasource
static NSString * identified = @"_systemSoundInfoCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identified];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    SystemSoundInfo * cellInfo = [_tableData objectAtIndex:indexPath.row];
    cell.textLabel.text       = cellInfo.soundName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"音频编号 %d",cellInfo.soundID];
    
    cell.textLabel.font       = [UIFont fontWithName:@"Avenir-BookOblique" size:16.f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:13.f];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemSoundInfo * soundInfo = _tableData[indexPath.row];
    [[SystemSoundManager defaultCenter] playWithSound:soundInfo.soundID];
}

@end
