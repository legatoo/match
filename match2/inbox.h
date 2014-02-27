//
//  inbox.h
//  test2
//
//  Created by Luo Feiheng on 15/11/13.
//  Copyright (c) 2013 Luo Feiheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inbox : UITableViewController
@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * userList;
@property (nonatomic, strong) NSMutableArray *tableData;


@property (strong, nonatomic) IBOutlet UITableView *tableView2;
@property (strong, nonatomic) NSArray *inboxUser;
- (IBAction)showMenu;
@end
