//
//  User.h
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Role.h"
#import "Location.h"
#import "Contact.h"
#import "CheckIns.h"
#import "Setting.h"


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * aboutme;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSNumber * blockStatus;
@property (nonatomic, retain) NSString * degree;
@property (nonatomic, retain) NSString * employer;
@property (nonatomic, retain) NSString * fullname;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * iden;
@property (nonatomic, retain) NSString * profile_url;
@property (nonatomic, retain) NSString * inbox_messages;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * occupation;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * pictureupload;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSString * sessionID;
@property (nonatomic, retain) NSNumber * show_link_option;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * access_token;
@property (nonatomic, retain) NSNumber * isonline;
@property (nonatomic, retain) NSNumber * canposttocitylobby;
@property (nonatomic, retain) NSNumber * citylobbyid;
@property (nonatomic, retain) NSNumber * accesstoavatar;
@property (strong, nonatomic) NSString *checkedinago;
@property (nonatomic, retain) Role *role;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Contact *contact;
@property (nonatomic, retain) CheckIns *checkins;
@property (nonatomic, retain) Setting *setting;

@end
