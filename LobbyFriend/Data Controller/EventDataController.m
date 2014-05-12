//
//  EventDataController.m
//  LobbyFriend
//
//  Created by Imran on 22/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "EventDataController.h"
#import "Deals.h"
#import "Event.h"

@implementation EventDataController

@synthesize cityEvent,hotelEvent;
static EventDataController *_sharedInstance;

+ (EventDataController *)getEventInstance;{
    @synchronized([EventDataController class]){
        if (!_sharedInstance) {
            [[self alloc] init];
            return _sharedInstance;
        }
    }
    return _sharedInstance;
    
}
+ (id)alloc{
    @synchronized([EventDataController class]){
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

- (Event *)getDataOfEvent{
    if (true) {
        return hotelEvent;
    }else
        return cityEvent;
}
- (void)addDataOfEvent: (Event *)_event;{
    if (true) {
        hotelEvent = _event;
    }else{
        cityEvent = _event;
    }
}

@end
