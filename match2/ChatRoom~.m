//
//  ChatRoom.m
//  match
//
//  Created by Luo Feiheng on 5/12/13.
//  Copyright (c) 2013 junhao. All rights reserved.
//

#import "ChatRoom.h"
#import "QuartzCore/QuartzCore.h"
#import "ISMViewController.h"
#import "UIWindow+Screenshot.h"

@interface ChatRoom ()

@end

@implementation ChatRoom
@synthesize friendName;
@synthesize webView;
@synthesize msgbox;

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
    self.friendLabel.text = friendName;
	// Do any additional setup after loading the view.
    
    [webView.layer setBorderColor:[[UIColor grayColor] CGColor] ];
    [webView.layer setBorderWidth:1.0 ];
    [webView.layer setCornerRadius:8.0f ];
    [webView.layer setMasksToBounds:YES ];
    [msgbox.layer setBorderColor:[[UIColor grayColor] CGColor] ];
    [msgbox.layer setBorderWidth:1.0 ];
    [msgbox.layer setCornerRadius:8.0f ];
    [msgbox.layer setMasksToBounds:YES ];
    
    //listening keyboard events, and call the corresponding functions
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    ISMViewController *cebianlan = [self.tabBarController.viewControllers objectAtIndex:1];
    self.tabBarController.selectedViewController = cebianlan;
    [cebianlan viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)getKeyBoardHeight:(NSNotification *)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    NSInteger keyboardHeight = keyboardFrameBeginRect.size.height;
    return keyboardHeight;
}
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSInteger keyboardHeight = [self getKeyBoardHeight:notification];
    NSInteger movement = keyboardHeight - 50;
    self.view.frame = CGRectMake(0, -movement, self.view.frame.size.width, self.view.frame.size.height);
}
-(void)keyboardDidHide:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
}

- (IBAction)sendOnClick:(id)sender {
}

- (IBAction)fanhui:(id)sender {
    [self performSegueWithIdentifier:@"backToInbox" sender:self];
}



@end
