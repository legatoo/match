//
//  friendInfo.m
//  test2
//
//  Created by Luo Feiheng on 15/11/13.
//  Copyright (c) 2013 Luo Feiheng. All rights reserved.
//

#import "friendInfo.h"
#import "AppDelegate.h"
#import "UserInfo.h"

@interface friendInfo ()

@end
#define getUserDataURL @"http://162.243.249.117/usersinfo.php"
#define getFriendshipDataURL @"http://162.243.249.117//friendship.php"
#define getDataURL @"http://162.243.249.117/usersinfo.php"
#define getPicURL @"http://162.243.249.117/returnImage.php"

@implementation friendInfo
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
    UserInfo *friendInformation = [self myInfo:tadeuid];
    
    UILabel *myName = (UILabel *)[self.view viewWithTag:51];
    myName.text = friendInformation.username;
    myName.textColor = [UIColor whiteColor];
    myName.textAlignment = NSTextAlignmentCenter;
    myName.adjustsFontSizeToFitWidth = YES;
    
    UIColor *girlColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
    UIColor *boyColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:0.6];
    UIImageView *genderColor = (UIImageView *)[self.view viewWithTag:50];
    if ([friendInformation.gender isEqualToString:@"Female"]){
        genderColor.backgroundColor = girlColor;
    }else {genderColor.backgroundColor = boyColor;}
    
    NSMutableString * getPic = [[NSMutableString alloc] init];
    [getPic appendString:getPicURL];
    [getPic appendString:@"?f=myProfileImage&value="];
    [getPic appendString:tadeuid];
    NSURL *picUrl = [NSURL URLWithString:getPic];
    UIImageView *userPhoto = (UIImageView *)[self.view viewWithTag:52];
    userPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
    
    
    UILabel *ageLabel = (UILabel *)[self.view viewWithTag:53];
    ageLabel.text = friendInformation.age;
    ageLabel.adjustsFontSizeToFitWidth = YES;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [ageLabel.layer setCornerRadius:6.0f];
    //[self.view addSubview:label];
    
    
    UILabel *uniLabel = (UILabel *)[self.view viewWithTag:54];
    uniLabel.text = friendInformation.university;
    uniLabel.adjustsFontSizeToFitWidth = YES;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [uniLabel.layer setCornerRadius:6.0f];
    
    UILabel *budLabel = (UILabel *)[self.view viewWithTag:55];
    budLabel.text = friendInformation.budget;
    budLabel.adjustsFontSizeToFitWidth = YES;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [budLabel.layer setCornerRadius:6.0f];
    
    UILabel *emailLabel = (UILabel *)[self.view viewWithTag:56];
    emailLabel.text = friendInformation.email;
    emailLabel.adjustsFontSizeToFitWidth = YES;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [emailLabel.layer setCornerRadius:6.0f];
    
    UILabel *introLabel = (UILabel *)[self.view viewWithTag:57];
    introLabel.text = friendInformation.selfIntroduction;
    introLabel.adjustsFontSizeToFitWidth = NO;
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [introLabel.layer setCornerRadius:6.0f];
    
    int dis=20;
    for (int num=0; num<[friendInformation.tag count]; num++) {
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 480, 20, 20)];
        tagLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.2 blue:0.8 alpha:0.7];
        [tagLabel.layer setCornerRadius:4.0f];
        tagLabel.text = [friendInformation.tag objectAtIndex:num];
        CGSize size = [[friendInformation.tag objectAtIndex:num] sizeWithFont:tagLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, tagLabel.frame.size.height)];
        [tagLabel setFrame:CGRectMake(dis, 480, size.width+5, 20)];
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

- (void) friendshipApproved: (NSString *) uid andFriendID:(NSString *) fid
{
    //NSString * myUid;
    NSMutableString * friendRequest = [[NSMutableString alloc] init];
    [friendRequest appendString:getFriendshipDataURL];
    [friendRequest appendString:@"?f=friendshipApprove&value1="];
    [friendRequest appendString:uid];
    [friendRequest appendString:@"&value2="];
    [friendRequest appendString:fid];
    
    NSURL * url = [NSURL URLWithString:friendRequest];
    NSData * data = [NSData dataWithContentsOfURL:url];
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    tableData = [[NSMutableArray alloc]init];
    
    
    NSString * message = [[json objectAtIndex:0] objectForKey:@"status"];
    NSLog(message); //success if messsage equal to 1
    
}


- (IBAction)acceptRequest:(id)sender {
    [self friendshipApproved:wodeuid andFriendID:tadeuid];
    [self alertBox:[NSString stringWithFormat:@"The request has been accepted."]];
}

- (void)alertBox:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: message
                                                   message: nil
                                                  delegate: self
                                         cancelButtonTitle: nil
                                         otherButtonTitles: @"OK",nil];
    [alert show];
}
@end
