//
//  loginWindow2.h
//  match2
//
//  Created by Luo Feiheng on 8/12/13.
//  Copyright (c) 2013 junhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginWindow2 : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernametxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordtxt;
@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * userList;
@property (nonatomic, strong) NSMutableArray *tableData;

- (IBAction)hidKeyboard:(id)sender;
- (IBAction)loginClick:(id)sender;
@end
