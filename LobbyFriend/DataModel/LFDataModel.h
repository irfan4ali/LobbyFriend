//
//  LFDataModel.h
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "User.h"
#import "Role.h"
#import "Location.h"
#import "Contact.h"
#import "CheckIns.h"
#import "Setting.h"
#import "Iphone.h"
#import "Hotel.h"
#import "Post.h"
#import "Flags.h"
#import "Lobby.h"
#import "Guest.h"
#import "Deals.h"
#import "Event.h"
#import "Inbox.h"
#import "Message.h"

@interface LFDataModel : NSObject

+ (id)sharedInstance;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@property (strong,nonatomic) NSMutableArray *tempDic;

- (NSString *) getParameterString:(NSDictionary *)_dic;
- (void )loginUser:(NSMutableDictionary *)loginData;
- (void)newUserRegister:(NSMutableDictionary *)loginData;

- (User *)parseLoginResponse: (NSDictionary *)temp;

// parsing method
- (Role *)roleParsing: (NSDictionary *)roleData;
- (Location *)locationParsing: (NSDictionary *)locationData;
- (Contact *)contactParsing: (NSDictionary *)contactData;
- (CheckIns *)checkinsParsing: (NSDictionary *)checkinsData;
- (Setting *)settingParsing: (NSDictionary *)settingData;
- (Iphone *)iPhoneParsing: (NSDictionary *)iphoneData;
- (void)getLobbyDataWithoutPin;
- (Lobby *)parseLobbyData:(NSString *)_lobbyData;
- (Hotel *)hotelParsing: (NSDictionary *)hotelData;
- (Post *)facebookPostParsing: (NSArray *)postData;
- (Post *)twitterPostParsing: (NSArray *)twitterPost;
- (Post *)rssPostParsing: (NSArray *)rssPost;
- (Post *)postsPostParsing: (NSDictionary *)postsPost;
- (Flags *)flagsParsing: (NSDictionary *)flagData;
- (void)postFeedParsing: (NSDictionary *)postFeedData;
- (User *)posterDetail: (NSDictionary *)posterDetail;
   // Guest services
- (void)getHotelGuestData;
- (void)getCityGuestData;
- (Guest *)parseGuestResponse:(NSDictionary *)guestData;

-(void)getHotelDealsData;
- (void)getCityDealsData;
- (Deals *)parseDealsResponse: (NSDictionary *)dealsData;

- (void)getEventInHotelLobby;
- (void)getEventInCityLobby;
- (Event *)parseEventResponse: (NSDictionary *)eventData;

- (void)getInboxData;
- (Inbox *)parseInboxResponse: (NSDictionary *)inboxData;
- (Message *)messageParse: (NSDictionary *)messageData;

- (void)PrivateMessageSend: (NSDictionary *)messageData;


@end
