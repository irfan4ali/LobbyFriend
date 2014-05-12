//
//  DataModel.h
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CheckIns : NSManagedObject

@property (nonatomic, retain) NSString * hotelid;
@property (nonatomic, retain) NSString * checkin;
@property (nonatomic, retain) NSString * roomNo;
@property (nonatomic, retain) NSString * checkout;
@property (nonatomic, retain) NSString * reason;
@property (nonatomic, retain) NSString * validfrom;
@property (nonatomic, retain) NSString * validto;
@property (nonatomic, retain) NSString * daysofstay;
@property (nonatomic, retain) NSString * firstaccess;
@property (nonatomic, retain) NSString * lastaccess;

@end
