//
//  loginWindow2.m
//  match2
//
//  Created by Luo Feiheng on 8/12/13.
//  Copyright (c) 2013 junhao. All rights reserved.
//

#import "loginWindow2.h"
#import "AppDelegate.h"
@interface loginWindow2 ()

@end
#define loginURL @"http://162.243.249.117//login.php"

@implementation loginWindow2

@synthesize json, tableData, userList, usernametxt;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hidKeyboard:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)loginClick:(id)sender {
    wodename = self.usernametxt.text;
    wodeuid = [self login:wodename];
}


- (NSString *) login: (NSString *) username
{
    //NSString * myUid;
    NSMutableString * myRequests = [[NSMutableString alloc] init];
    [myRequests appendString:loginURL];
    [myRequests appendString:@"?f=login&value="];
    [myRequests appendString:username];
    
    NSURL * url = [NSURL URLWithString:myRequests];
    NSData * data = [NSData dataWithContentsOfURL:url];
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    tableData = [[NSMutableArray alloc]init];
    NSString *uid;
    for (int i =0; i < json.count; i++)
    {
        uid = [[json objectAtIndex:i] objectForKey:@"uid"];
        //NSLog(uid);
    }
    return uid;
    
}


@end
