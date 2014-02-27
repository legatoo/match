//
//  receiverInfo.m
//  match2
//
//  Created by Luo Feiheng on 8/12/13.
//  Copyright (c) 2013 junhao. All rights reserved.
//

#import "receiverInfo.h"
#import "AppDelegate.h"
#import "UserInfo.h"

@interface receiverInfo ()

@end

#define getUserDataURL @"http://162.243.249.117/usersinfo.php"
#define getFriendshipDataURL @"http://162.243.249.117//friendship.php"
#define getDataURL @"http://162.243.249.117/usersinfo.php"
#define getPicURL @"http://162.243.249.117/returnImage.php"

@implementation receiverInfo

@synthesize json, tableData, userList;

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
    
    UserInfo *myself = [self myInfo:tadeuid];
    
    UILabel *myName = (UILabel *)[self.view viewWithTag:7777];
    myName.text = myself.username;
    myName.textColor = [UIColor whiteColor];
    myName.textAlignment = NSTextAlignmentCenter;
    myName.adjustsFontSizeToFitWidth = YES;
    
    UIColor *girlColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    UIColor *boyColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:0.6];
    UIImageView *genderColor = (UIImageView *)[self.view viewWithTag:8888];
    if ([myself.gender isEqualToString:@"Female"]){
        genderColor.backgroundColor = girlColor;
    }else {genderColor.backgroundColor = boyColor;}
    
    NSMutableString * getPic = [[NSMutableString alloc] init];
    [getPic appendString:getPicURL];
    [getPic appendString:@"?f=myProfileImage&value="];
    [getPic appendString:tadeuid];
    NSURL *picUrl = [NSURL URLWithString:getPic];
    UIImageView *userPhoto = (UIImageView *)[self.view viewWithTag:6666];
    userPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
    
    
    UILabel *ageLabel = (UILabel *)[self.view viewWithTag:1111];
    ageLabel.text = myself.age;
    ageLabel.adjustsFontSizeToFitWidth = YES;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [ageLabel.layer setCornerRadius:6.0f];
    //[self.view addSubview:label];
    
    
    UILabel *uniLabel = (UILabel *)[self.view viewWithTag:2222];
    uniLabel.text = myself.university;
    uniLabel.adjustsFontSizeToFitWidth = YES;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [uniLabel.layer setCornerRadius:6.0f];
    
    UILabel *budLabel = (UILabel *)[self.view viewWithTag:3333];
    budLabel.text = myself.budget;
    budLabel.adjustsFontSizeToFitWidth = YES;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [budLabel.layer setCornerRadius:6.0f];
    
    UILabel *emailLabel = (UILabel *)[self.view viewWithTag:4444];
    emailLabel.text = myself.email;
    emailLabel.adjustsFontSizeToFitWidth = YES;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [emailLabel.layer setCornerRadius:6.0f];
    
    UILabel *introLabel = (UILabel *)[self.view viewWithTag:5555];
    introLabel.text = myself.selfIntroduction;
    introLabel.adjustsFontSizeToFitWidth = NO;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [introLabel.layer setCornerRadius:6.0f];
    
    int dis=20;
    for (int num=0; num<[myself.tag count]; num++) {
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 530, 20, 20)];
        tagLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.2 blue:0.8 alpha:0.7];
        [tagLabel.layer setCornerRadius:4.0f];
        tagLabel.text = [myself.tag objectAtIndex:num];
        CGSize size = [[myself.tag objectAtIndex:num] sizeWithFont:tagLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, tagLabel.frame.size.height)];
        [tagLabel setFrame:CGRectMake(dis, 530, size.width+5, 20)];
        [self.view addSubview:tagLabel];
        dis = dis+tagLabel.frame.size.width+12;
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UserInfo *) myInfo:(NSString *) uid
{
    //NSString * myUid;
    NSMutableString * myInfo = [[NSMutableString alloc] init];
    [myInfo appendString:getUserDataURL];
    [myInfo appendString:@"?f=myInfo&value="];
    [myInfo appendString:uid];
    
    NSURL * url = [NSURL URLWithString:myInfo];
    NSData * data = [NSData dataWithContentsOfURL:url];
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    tableData = [[NSMutableArray alloc]init];
    UserInfo *info;
    for (int i =0; i < json.count; i++)
    {
        NSString *uid = [[json objectAtIndex:i] objectForKey:@"uid"];
        NSString *uname = [[json objectAtIndex:i] objectForKey:@"uname"];
        NSString *gender = [[json objectAtIndex:i] objectForKey:@"gender"];
        NSString *budget = [[json objectAtIndex:i] objectForKey:@"budget"];
        NSString *age = [[json objectAtIndex:i] objectForKey:@"age"];
        NSString *university = [[json objectAtIndex:i] objectForKey:@"university"];
        NSString *email = [[json objectAtIndex:i] objectForKey:@"email"];
        NSString *selfIntro = [[json objectAtIndex:i] objectForKey:@"introduction"];
        NSString *uTagString = [[json objectAtIndex:i] objectForKey:@"tags"];
        NSString *groupID = [[json objectAtIndex:i] objectForKey:@"groupid"];
        
        NSArray *uTag=[uTagString componentsSeparatedByString:@","];
        
        info = [[UserInfo alloc] initWithUser:uid andUserName:uname andUserAge:age andUserUniversity:university andUserGender:gender andUserEmail:email andUserIntro:selfIntro andTags:uTag andUserGID:groupID andUserBudget:budget];
        
        
        //add city to citiesArray
        [tableData addObject:info];
    }
    
    return info;
}


@end
