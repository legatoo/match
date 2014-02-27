//
//  List.h
//  test2
//
//  Created by Luo Feiheng on 15/11/13.
//  Copyright (c) 2013 Luo Feiheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface List : UITableViewController
@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * userList;
@property (nonatomic, strong) NSMutableArray *tableData;

- (IBAction)showMenu;
- (IBAction)checkRen:(id)sender;
- (IBAction)rej:(id)sender;
- (IBAction)accept:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *nameList;



@end
