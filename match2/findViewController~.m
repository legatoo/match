//
//  findViewController.m
//  match2
//
//  Created by junhao on 13-12-5.
//  Copyright (c) 2013年 junhao. All rights reserved.
//

#import "findViewController.h"
#import "UserInfo.h"
#import "AppDelegate.h"
@interface findViewController ()

@end
#define getDataURL @"http://162.243.249.117/usersinfo.php"
#define getUserDataURL @"http://162.243.249.117/usersinfo.php"
#define getFriendshipDataURL @"http://162.243.249.117//friendship.php"
#define getPicURL @"http://162.243.249.117/returnImage.php"

@implementation findViewController
{
    NSTimer *refreshTimer;
}

@synthesize json, tableData, userList;

@synthesize nameList = _namelist;

NSMutableArray *getFriendUid;

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

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
    //[self refreshUsersList];
    
    //refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getAllUserData) userInfo:Nil repeats:YES];
    [self getAllMyFriends:wodeuid];
    [self getAllUserData];
//    if ([getFriendUid count]!=0) {
//        for (int i=0; i<[getFriendUid count]; i++) {
//            NSLog([getFriendUid objectAtIndex:i]);
//        }
//    }

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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"findCell";
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
    UIImageView *userPhoto = (UIImageView *)[cell viewWithTag:1];
    //userPhoto = [UIImage imageNamed:@"touxiang.jpg"];
    userPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
    //imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url2]];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    nameLabel.text = currentUser.username;
    
    UILabel *userAge = (UILabel *)[cell viewWithTag:3];
    userAge.text = currentUser.age;
    
    UILabel *userGender = (UILabel *)[cell viewWithTag:4];
    userGender.text = currentUser.gender;
    
    UILabel *userBudget = (UILabel *)[cell viewWithTag:5];
    userBudget.text = currentUser.budget;
    
   
    //cell.textLabel.text = currentUser.username;
    //cell.detailTextLabel.text = currentUser.gender;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Row On Click
    //NSLog(wodeuid);
    //NSLog([NSString stringWithFormat:@"%d", indexPath.row]);
//    if (indexPath.row >= [wodeuid intValue]-1) {
//        tadeuid = [NSString stringWithFormat:@"%d", indexPath.row+2];
//    }else {
//        tadeuid = [NSString stringWithFormat:@"%d", indexPath.row+1];
//    }
//    
    UserInfo *selected = [tableData objectAtIndex:indexPath.row];
    tadename = selected.username;
    
}

#pragma mark - Methods
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

        //NSLog(uid);
        int testKey=0;
        if ([getFriendUid count]!=0) {
            for (int length = 0; length < [getFriendUid count]; length++) {
                if ([uid isEqualToString:[getFriendUid objectAtIndex:length]]) {
                    testKey=1;
                    break;
                }
            }
            if ((![uid isEqualToString:wodeuid])&&(testKey==0)) {
                [tableData addObject:user];
            }
          
            
        }else if (![uid isEqualToString:wodeuid]){
            [tableData addObject:user];
        }
        
        
    }
    //NSLog(@"%d",[getFriendUid count]);
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
        //NSLog(uid);
        [getFriendUid addObject:uid];
    }
    
    
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return self.nameList.count;;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"findCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    if(cell==nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    NSDictionary *user= [self.nameList objectAtIndex:indexPath.row];
//    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
//    imageView.image = [UIImage imageNamed:@"touxiang.jpg"];
//    
//    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
//    nameLabel.text = [user objectForKey:@"name"];
//    
//    UILabel *userAge = (UILabel *)[cell viewWithTag:3];
//    userAge.text = [user objectForKey:@"age"];
//    
//    UILabel *userGender = (UILabel *)[cell viewWithTag:4];
//    userGender.text = [user objectForKey:@"gender"];
//    
//    UILabel *userBudget = (UILabel *)[cell viewWithTag:5];
//    userBudget.text = [user objectForKey:@"budget"];
//    
//    //UIButton *ackRequest = (UIButton *)[cell viewWithTag:5];
//    //UIButton *rejRequest = (UIButton *)[cell viewWithTag:4];
//    
//    //[rejRequest.layer setBorderColor:[[UIColor grayColor] CGColor] ];
//    //[rejRequest.layer setBorderWidth:1.0 ];
//    //[rejRequest.layer setCornerRadius:8.0f ];
//    //[rejRequest.layer setMasksToBounds:YES ];
//    //[ackRequest.layer setBorderColor:[[UIColor grayColor] CGColor] ];
//    //[ackRequest.layer setBorderWidth:1.0 ];
//    //[ackRequest.layer setCornerRadius:8.0f ];
//    //[ackRequest.layer setMasksToBounds:YES ];
//    
//    
//    return cell;
//}
//
//-(void) refreshUsersList
//{
//    //This is the format of the data(json) displayed on php
//    NSString *exampleData = @"{\"records\":[{\"name\":\"Andy\",\"age\":\"18\",\"gender\":\"female\",\"budget\":\"Budget:1800\"},{\"name\":\"Jacky\",\"age\":\"23\",\"gender\":\"male\",\"budget\":\"Budget:2800\"}]}";
//    NSMutableData *body = [[exampleData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:body options:kNilOptions error:nil];
//    self.nameList = [json objectForKey:@"records"];
//    [self.tableView reloadData];
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
