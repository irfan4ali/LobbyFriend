//
//  Hotel.h
//  LobbyFriend
//
//  Created by Imran on 13/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact,Location;
@interface Hotel : NSManagedObject

@property (strong, nonatomic) Contact *contact;
@property (strong, nonatomic) Location *location;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * general_hotel;
@property (nonatomic, retain) NSString * hotel_id;
@property (nonatomic, retain) NSNumber * citylobbyid;
@property (nonatomic, retain) NSString * hotel_imageURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * title1;
@property (nonatomic, retain) NSString * title2;
@property (nonatomic, retain) NSString * title3;
@property (nonatomic, retain) NSString * url1;
@property (nonatomic, retain) NSString * url2;
@property (nonatomic, retain) NSString * url3;

@end
