//
//  complainAdd.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "complainAdd.h"

@interface complainAdd ()

@end

@implementation complainAdd

@synthesize list;
@synthesize complaintoTview;
@synthesize complaintoText;
@synthesize titleText;
@synthesize introduceText;
@synthesize detailsText;

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
    NSArray *array = [[NSArray alloc] initWithObjects:@"网站服务", @"商铺服务",
                      @"物业服务", nil];
    self.list=array;
    complaintoTview.hidden=YES;
    complaintoText.userInteractionEnabled=NO;
    complaintoText.text=@"网站服务";
}

-(IBAction)selectwho:(id)sender
{
    complaintoTview.hidden=NO;
}

-(IBAction)goback:(id)sender
{
    complainlist * _complainlist=[[complainlist alloc] init];
    
    [self.navigationController pushViewController:_complainlist animated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.list objectAtIndex:row];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [self.list objectAtIndex:[indexPath row]];
    complaintoText.text=rowString;
    complaintoTview.hidden=YES;
    
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([complaintoTview frame], pt)) {
        //to-do
        complaintoTview.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
