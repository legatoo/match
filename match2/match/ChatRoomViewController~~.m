//
//  ChatRoomViewController.m
//  test2
//
//  Created by Luo Feiheng on 15/11/13.
//  Copyright (c) 2013 Luo Feiheng. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController

@synthesize receiverName;
@synthesize webView;
@synthesize msgBox;
@synthesize sendBtn;


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
    
    //listening keyboard events, and call the corresponding functions
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    self.receiverLabel.text = receiverName;
    
    [webView.layer setBorderColor:[[UIColor grayColor] CGColor] ];
    [webView.layer setBorderWidth:1.0 ];
    [webView.layer setCornerRadius:8.0f ];
    [webView.layer setMasksToBounds:YES ];
    [msgBox.layer setBorderColor:[[UIColor grayColor] CGColor] ];
    [msgBox.layer setBorderWidth:1.0 ];
    [msgBox.layer setCornerRadius:8.0f ];
    [msgBox.layer setMasksToBounds:YES ];
    [sendBtn.layer setBorderColor:[[UIColor grayColor] CGColor] ];
    [sendBtn.layer setBorderWidth:1.0 ];
    [sendBtn.layer setCornerRadius:8.0f ];
    [sendBtn.layer setMasksToBounds:YES ];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendOnClick:(id)sender {
}

- (IBAction)fanhui:(id)sender {
    [self performSegueWithIdentifier:@"backToInbox" sender:self];
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
@end
