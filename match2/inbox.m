//
//  inbox.m
//  test2
//
//  Created by Luo Feiheng on 15/11/13.
//  Copyright (c) 2013 Luo Feiheng. All rights reserved.
//

#import "inbox.h"
#import "ChatRoomViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "UserInfo.h"


@interface inbox ()

@end

#define getDataURL @"http://162.243.249.117/usersinfo.php"
#define getUserDataURL @"http://162.243.249.117/usersinfo.php"
#define getFriendshipDataURL @"http://162.243.249.117//friendship.php"
#define getPicURL @"http://162.243.249.117/returnImage.php"

@implementation inbox

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

@synthesize inboxUser, json, tableData, userList;

NSMutableArray *getFriendUid;


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
    [self getAllMyFriends:wodeuid];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"InboxCell";
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
    
    UIImageView *photo = (UIImageView *)[cell viewWithTag:21];
    photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
//    UIImage *photo =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:picUrl]];
//    UIButton *userPhoto = (UIButton *)[cell viewWithTag:123];
//    [userPhoto setBackgroundImage:photo forState:UIControlStateNormal];
//    [userPhoto setTitle:@"" forState:UIControlStateNormal];
    
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
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:22];
    nameLabel.text = currentUser.username;
    
    
    UILabel *isMatch = (UILabel *)[cell viewWithTag:23];
    isMatch.text = @"";//currentUser.age;
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Row On Click
    UserInfo *selectedRequest = [tableData objectAtIndex:indexPath.row];
    tadename = selectedRequest.username;
    tadeuid = selectedRequest.userID;
    tadegender = selectedRequest.gender;
}

//-(void) refreshUsersList
//{
//    //This is the format of the data(json) displayed on php
//    NSString *exampleData = @"{\"records\":[{\"name\":\"Owen\",\"match\":\"match\"},{\"name\":\"Beckham\",\"match\":\"match\"}]}";
//    NSMutableData *body = [[exampleData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:body options:kNilOptions error:nil];
//    self.inboxUser = [json objectForKey:@"records"];
//    [self.tableView2 reloadData];
//}



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
        if ([getFriendUid count]!=0) {
            for (int length = 0; length < [getFriendUid count]; length++) {
                if ([uid isEqualToString:[getFriendUid objectAtIndex:length]]) {
                    [tableData addObject:user];
                }//else{[tableData addObject:user];}
            }
            
        }
    }
}


- (void) getAllMyFriends: (NSString *) uid
{
    //NSString * myUid;
    NSMutableString * myRequests = [[NSMutableString alloc] init];
    [myRequests appendString:getUserDataURL];
    [myRequests appendString:@"?f=myFriends&value="];
    [myRequests appendString:uid];
    
    NSURL * url = [NSURL URLWithString:myRequests];
    NSData * data = [NSData dataWithContentsOfURL:url];
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    tableData = [[NSMutableArray alloc]init];
    
    getFriendUid = [[NSMutableArray alloc]init];
    for (int i =0; i < json.count; i++)
    {
        NSString *uid = [[json objectAtIndex:i] objectForKey:@"fid"];
        NSLog(uid);
        [getFriendUid addObject:uid];
    }
    
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ChatRoomViewController *chatRoomController = [self.tabBarController.viewControllers objectAtIndex:1];
//    
//    NSDictionary *user = [self.inboxUser objectAtIndex:self.tableView.indexPathForSelectedRow.row];
//    chatRoomController.receiverName = [user objectForKey:@"name"];
//    self.tabBarController.selectedViewController = chatRoomController;
//    [chatRoomController viewDidLoad];
//}
//
//-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    NSDictionary *user = [self.inboxUser objectAtIndex:self.tableView.indexPathForSelectedRow.row];
//    NSString *msg = [user objectForKey:@"name"];
//    UIViewController *send = segue.destinationViewController;
//    if([send respondsToSelector:@selector(setData:)]){
//        [send setValue:msg forKey:@"receiverName"];
//    }
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
