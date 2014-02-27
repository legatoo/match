//
//  List.m
//  test2
//
//  Created by Luo Feiheng on 15/11/13.
//  Copyright (c) 2013 Luo Feiheng. All rights reserved.
//

#import "List.h"
#import "AppDelegate.h"
#import "UserInfo.h"

@interface List ()

@end

#define getDataURL @"http://162.243.249.117/usersinfo.php"
#define getUserDataURL @"http://162.243.249.117/usersinfo.php"
#define getFriendshipDataURL @"http://162.243.249.117//friendship.php"
#define getPicURL @"http://162.243.249.117/returnImage.php"

@implementation List
@synthesize json, tableData, userList;

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

@synthesize nameList = _namelist;

UIButton *ackRequest;
UIButton *rejRequest;
NSMutableArray *getRequestUid;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getAllMyRequests:wodeuid];
    [self getAllUserData];
    [self setExtraCellLineHidden:self.tableView];
    //[self refreshUsersList];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    UserInfo * currentUser = [tableData objectAtIndex:indexPath.row];
    
    
    NSMutableString * getPic = [[NSMutableString alloc] init];
    [getPic appendString:getPicURL];
    [getPic appendString:@"?f=myProfileImage&value="];
    [getPic appendString:currentUser.userID];
    NSURL *picUrl = [NSURL URLWithString:getPic];
    UIImage *photo =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:picUrl]];
    UIButton *userPhoto = (UIButton *)[cell viewWithTag:123];
    [userPhoto setBackgroundImage:photo forState:UIControlStateNormal];
    [userPhoto setTitle:@"" forState:UIControlStateNormal];
    
//    UIImageView *userPhoto = (UIImageView *)[cell viewWithTag:1];
//    //userPhoto = [UIImage imageNamed:@"touxiang.jpg"];
//    userPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
//    
//    
//    NSURL *url2 = [NSURL URLWithString:@"http://s8.postimg.org/9wmtr3w9d/background2.jpg"];
//    UIImage *photo =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url2]];
//    UIButton *userPhoto = (UIButton *)[cell viewWithTag:123];
//    [userPhoto setBackgroundImage:photo forState:UIControlStateNormal];
    //UIImageView *userPhoto = (UIImageView *)[cell viewWithTag:1];
    //userPhoto = [UIImage imageNamed:@"touxiang.jpg"];
    //userPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url2]];
    //imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url2]];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:223];
    nameLabel.text = currentUser.username;
    
    UILabel *userAge = (UILabel *)[cell viewWithTag:323];
    userAge.text = currentUser.age;
    
    //                UILabel *userGender = (UILabel *)[cell viewWithTag:4];
    //                userGender.text = currentUser.gender;
    //
    //                UILabel *userBudget = (UILabel *)[cell viewWithTag:5];
    //                userBudget.text = currentUser.budget;
    
    
    
    
    //cell.textLabel.text = currentUser.username;
    //cell.detailTextLabel.text = currentUser.gender;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}


- (void) getAllUserData
{
    NSMutableString * getAllUsersInfo = [[NSMutableString alloc] init];
    [getAllUsersInfo appendString:getDataURL];
    [getAllUsersInfo appendString:@"?f=allUsers"];
    
    NSURL * url = [NSURL URLWithString:getAllUsersInfo];
    NSData * data = [NSData dataWithContentsOfURL:url];
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    tableData = [[NSMutableArray alloc]init];
    
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
        
        UserInfo *user = [[UserInfo alloc] initWithUser:uid andUserName:uname andUserAge:age andUserUniversity:university andUserGender:gender andUserEmail:email andUserIntro:selfIntro andTags:uTag andUserGID:groupID andUserBudget:budget];
        
        //add city to citiesArray
        //[tableData addObject:user];
        //NSLog(uid);
        if ([getRequestUid count]!=0) {
            for (int length = 0; length < [getRequestUid count]; length++) {
                if ([uid isEqualToString:[getRequestUid objectAtIndex:length]]) {
                    [tableData addObject:user];
                }//else{[tableData addObject:user];}
            }
            
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Row On Click
    NSLog(wodeuid);
    NSLog([NSString stringWithFormat:@"%d", indexPath.row]);
    
    UserInfo *selectedRequest = [tableData objectAtIndex:indexPath.row];
    tadeuid = selectedRequest.userID;
    
}


- (void) getAllMyRequests: (NSString *) uid
{
    //NSString * myUid;
    NSMutableString * myRequests = [[NSMutableString alloc] init];
    [myRequests appendString:getUserDataURL];
    [myRequests appendString:@"?f=allMyRequests&value="];
    [myRequests appendString:uid];
    
    NSURL * url = [NSURL URLWithString:myRequests];
    NSData * data = [NSData dataWithContentsOfURL:url];
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    //tableData = [[NSMutableArray alloc]init];
    
    getRequestUid = [[NSMutableArray alloc]init];
    
    for (int i =0; i < json.count; i++)
    {
        NSString *uid = [[json objectAtIndex:i] objectForKey:@"fromWhom"];
        NSLog(uid);
        [getRequestUid addObject:uid];
        //NSLog([getRequestUid objectAtIndex:0]);
    }

    
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


-(void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}


- (IBAction)checkRen:(id)sender {
}


- (IBAction)rej:(id)sender {
    //ackRequest.hidden=YES;
    //rejRequest.hidden=YES;
    [self alertBox:[NSString stringWithFormat:@"The request has been rejected."]];
    
}


- (IBAction)accept:(id)sender {
    //ackRequest.hidden=YES;
    //rejRequest.hidden=YES;
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
