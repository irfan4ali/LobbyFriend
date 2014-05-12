//
//  Guest.m
//  LobbyFriend
//
//  Created by Imran on 15/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "Guest.h"


@implementation Guest

@dynamic blocksize;
@dynamic offset;
@dynamic guest;
@dynamic staffCount;
@dynamic guestCount;
@dynamic cityLobbyId;
@dynamic total;
@synthesize keyDic, guestArray;


-(id)init{
    if (self==[super init]) {
        guestArray = [[NSMutableArray alloc] init];
    }
    return self;

}
@end
