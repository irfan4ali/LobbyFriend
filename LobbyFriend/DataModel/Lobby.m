//
//  Lobby.m
//  LobbyFriend
//
//  Created by Imran on 13/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "Lobby.h"


@implementation Lobby

@dynamic blocksize;
@dynamic offset;
@dynamic postcount;
@dynamic sticky;
@synthesize hotel;
@synthesize stickyPost;
@synthesize postArray;

- (id)init{
    if (self==[super init]) {
        postArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)totalSection{
    int sectionCount=0;
    if (self.stickyPost) {
        sectionCount++;
    }else if (self.postArray && [self.postArray count]>0){
        sectionCount++;
    }

    return sectionCount;
}

@end
