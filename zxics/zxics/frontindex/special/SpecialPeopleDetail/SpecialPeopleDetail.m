//
//  SpecialPeopleDetail.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "SpecialPeopleDetail.h"
#import "DataService.h"

@interface SpecialPeopleDetail ()

@end

@implementation SpecialPeopleDetail

@synthesize spdbtntag;
@synthesize specialtableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
    NSInteger selecttype=[spdbtntag integerValue];
    NSString *caid=nil;
    if (selecttype==0) {
        self.UINavigationItem.title=@"发布信息";
        caid=@"73";
    }else if (selecttype==2)
    {
        self.UINavigationItem.title=@"知识库";
        caid=@"81";
    }else if (selecttype==3)
    {
        self.UINavigationItem.title=@"工作动态";
        caid=@"68";
    }else if (selecttype==4)
    {
        self.UINavigationItem.title=@"政策法规";
        caid=@"70";
    }else if (selecttype==5)
    {
        self.UINavigationItem.title=@"求助公告";
        caid=@"72";
    }
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * spd = [NSMutableDictionary dictionaryWithCapacity:5];
    if (myDelegate.entityl) {
        spd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/releaseInfoApi",myDelegate.url] postDatas:[NSString stringWithFormat:@"categoryId=%@&memberId=%@&communityid=%@&type=1",caid,myDelegate.entityl.userid,myDelegate.entityl.communityid]];
    }else{
        spd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/releaseInfoApi",myDelegate.url] postDatas:[NSString stringWithFormat:@"categoryId=%@&type=1",caid]];
    }
    list=[spd objectForKey:@"datas"];
    
    //上拉刷新下拉加载提示
    [specialtableview addHeaderWithCallback:^{
        [specialtableview reloadData];
        [specialtableview headerEndRefreshing];}];
    [specialtableview addFooterWithCallback:^{
        [specialtableview footerEndRefreshing];
    }];
}

-(IBAction)goback:(id)sender
{
    SpecialPeople * _SpecialPeople=[[SpecialPeople alloc] init];
    
    [self.navigationController pushViewController:_SpecialPeople animated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"SpecialPeopleDetailCell";
    
    SpecialPeopleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"SpecialPeopleDetailCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *detail = [list objectAtIndex:[indexPath row]];
    cell.titleLabel.text=[detail objectForKey:@"title"];
    NSString *time =[NSString stringWithFormat:@"%@",[detail objectForKey:@"createDate"]];
    NSString *aaa=[time substringToIndex:10];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[aaa intValue]];
    cell.dateLabel.text=[formatter stringFromDate:date];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *detail = [list objectAtIndex:[indexPath row]];
    specialPeopleIntroduce *_specialPeopleIntroduce=[[specialPeopleIntroduce alloc]init];
    _specialPeopleIntroduce.introduce=detail;
    [self.navigationController pushViewController:_specialPeopleIntroduce animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
