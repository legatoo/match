//
//  User.h
//  helloworld
//
//  Created by Steven on 5/12/13.
//  Copyright (c) 2013 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * age;
@property (nonatomic, strong) NSString * university;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * selfIntroduction;
@property (nonatomic, strong) NSString * lastsee;
@property (nonatomic, strong) NSString * groupID;
@property (nonatomic, strong) NSString * budget;


//method to initialize
-(id) initWithUser: (NSString *) uid andUserName: (NSString *) uname andUserAge: (NSString *) uage andUserUniversity: (NSString *) uUniv andUserGender: (NSString *) uGender andUserEmail: (NSString *) uEmail andUserIntro: (NSString *) uIntro andUserLastSee: (NSString *) uLastsee andUserGID: (NSString *) uGid andUserBudget: (NSString *) uBudget;

@end
