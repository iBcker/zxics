//
//  specialPeopleIntroduce.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface specialPeopleIntroduce : UIViewController

@property(retain , nonatomic) NSDictionary * introduce;//生活管家信息明细

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@end
