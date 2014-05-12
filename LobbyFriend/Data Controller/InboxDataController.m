//
//  InboxDataController.m
//  LobbyFriend
//
//  Created by Imran on 22/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "InboxDataController.h"
#import "Inbox.h"
@implementation InboxDataController
@synthesize inbox;
static InboxDataController *_sharedInstance;

+ (InboxDataController *)getInboxInstance;{
    @synchronized([InboxDataController class]){
        if (!_sharedInstance) {
            [[self alloc] init];
            return _sharedInstance;
        }
    }
    return _sharedInstance;
    
}
+ (id)alloc{
    @synchronized([InboxDataController class]){
        _sharedInstance = [super alloc];
        return  _sharedInstance;
    }
    return nil;
}




- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (Inbox *)getDataOfInbox{
    return inbox;
}
- (void)addDataOfInbox:(Inbox *)_inbox{
    inbox = _inbox;
}


@end
