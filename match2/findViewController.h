//
//  findViewController.h
//  match2
//
//  Created by junhao on 13-12-5.
//  Copyright (c) 2013年 junhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
@interface findViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *nameList;
- (IBAction)showMenu;
@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * userList;
@property (nonatomic, strong) NSMutableArray *tableData;

@end
