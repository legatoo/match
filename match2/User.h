//
//  User.h
//  match2
//
//  Created by Luo Feiheng on 6/12/13.
//  Copyright (c) 2013 junhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : UIViewController
@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * userList;
@property (nonatomic, strong) NSMutableArray *tableData;

- (IBAction)showMenu;
@end
