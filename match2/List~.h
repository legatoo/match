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

- (IBAction)showMenu;
- (IBAction)checkRen:(id)sender;
- (IBAction)rej:(id)sender;
- (IBAction)accept:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *nameList;



@end
