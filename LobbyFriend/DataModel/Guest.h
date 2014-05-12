//
//  Guest.h
//  LobbyFriend
//
//  Created by Imran on 15/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Guest : NSManagedObject

@property (nonatomic, retain) NSNumber * blocksize;
@property (nonatomic, retain) NSNumber * offset;
@property (nonatomic, retain) NSString * guest;
@property (nonatomic, retain) NSString * staffCount;
@property (nonatomic, retain) NSNumber * guestCount;
@property (nonatomic, retain) NSNumber * cityLobbyId;
@property (nonatomic, retain) NSNumber * total;
@property (strong, nonatomic) NSMutableArray *guestArray;
@property (strong, nonatomic) NSMutableDictionary *keyDic;

@end
