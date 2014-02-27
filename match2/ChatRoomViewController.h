//
//  ChatRoomViewController.h
//  test2
//
//  Created by Luo Feiheng on 15/11/13.
//  Copyright (c) 2013 Luo Feiheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRoomViewController : UIViewController

@property (strong, nonatomic) NSString *receiverName;
@property (weak, nonatomic) IBOutlet UILabel *receiverLabel;
@property (weak, nonatomic) IBOutlet UIButton *friNameBtn;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *msgBox;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIImageView *genCol;
- (IBAction)sendOnClick:(id)sender;
- (IBAction)hidKeyboard:(id)sender;


@end
