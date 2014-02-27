//
//  User.m
//  helloworld
//
//  Created by Steven on 5/12/13.
//  Copyright (c) 2013 Steven. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize userID, username, age, university, gender, budget, selfIntroduction, email, groupID, tag;

-(id) initWithUser: (NSString *) uid andUserName: (NSString *) uname andUserAge: (NSString *) uage andUserUniversity: (NSString *) uUniv andUserGender: (NSString *) uGender andUserEmail: (NSString *) uEmail andUserIntro: (NSString *) uIntro andTags:(NSArray *)uTag andUserGID:(NSString *)uGid andUserBudget:(NSString *)uBudget
{
    
    self = [super init];
    if (self)
    {
        userID = uid;
        username = uname;
        age = uage;
        university = uUniv;
        gender = uGender;
        budget = uBudget;
        selfIntroduction = uIntro;
        email = uEmail;
        groupID = uGid;
        tag = uTag;
    }
    return self;
}
@end
