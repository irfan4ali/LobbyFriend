//
//  EventDataController.h
//  LobbyFriend
//
//  Created by Imran on 22/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Event.h"
@class Event;
@interface EventDataController : NSObject

@property (nonatomic,retain) Event *cityEvent, *hotelEvent;
+ (EventDataController *)getEventInstance;

- (void)addDataOfEvent: (Event *)_event;
- (Event *)getDataOfEvent;
@end
