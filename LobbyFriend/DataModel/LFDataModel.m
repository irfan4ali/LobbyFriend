//
//  LFDataModel.m
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "LFDataModel.h"
#import "User.h"
#import "SBJson.h"
#import "headerfiles.h"
#import "headerfiles.h"
#import "commonUsedMethod.h"
#import "NSDictionary+Value.h"
#import "AppDelegate.h"
#import "LobbyDataController.h"
#import "Hotel.h"
#import "Lobby.h"
#import "Flags.h"
#import "LobbyDataController.h"
#import "Guest.h"
#import "Deals.h"
#import "Event.h"
#import "Inbox.h"
#import "Message.h"
#import "GuestDataController.h"
#import "GuestsViewController.h"
#import "DealDataController.h"
#import "EventDataController.h"
#import "InboxDataController.h"

NSManagedObjectContext *managedObjectContext;


@implementation LFDataModel

@synthesize tempDic;
-(id)init{
    self = [super init];
    if (self) {
        
    }
    return  self;
}

+ (id)sharedInstance{

    static LFDataModel *sharedManager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (NSString *) getParameterString:(NSDictionary *)_dic
{
    NSMutableArray *tempArray  = [[NSMutableArray alloc] init];
    [_dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         // NSString *newKey  =  key;
         // NSString *newObj = obj;
         [tempArray addObject:[NSString stringWithFormat:@"%@=%@",(NSString *)key,(NSString *)obj]];
         
     }];
    NSLog(@"%@",[(NSArray *)tempArray componentsJoinedByString:@"&"]);
    return [(NSArray *)tempArray componentsJoinedByString:@"&"];
    // return [NSString stringWithFormat:@"%@&token=%@",(NSArray *)[tempArray componentsJoinedByString:@"&"],APPKEY];
    
}
- (void)newUserRegister:(NSMutableDictionary *)loginData{
    NSString *json_String=nil;//*urlString=nil;
    //NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_user/create.json"];
    url = [NSURL URLWithString:urlString1];
    [commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"%@",@"&"]];
    [parameter appendString:[self getParameterString:loginData]];
    [parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    User *loginUser = [self parseLoginResponse:temp];
    //AppDelegate *mainDel = [[UIApplication sharedApplication] delegate];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data: %@",loginUser.setting.iphoneDic);
        
        [mainDelegate saveLoginUser:loginUser];
        [self getLobbyDataWithoutPin];
    }
    User *userObject = [mainDelegate retrieveLoginUser];
    
    NSLog(@"User:%@",userObject.setting.iphoneDic);



}

- (void)loginUser:(NSMutableDictionary *)loginData{
    
    NSString *json_String=nil;//*urlString=nil;
    NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_user/login.json"];
    url = [NSURL URLWithString:urlString1];
    [commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"%@",@"&"]];
    [parameter appendString:[self getParameterString:loginData]];
    [parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];

    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
   // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    User *loginUser = [self parseLoginResponse:temp];
    //AppDelegate *mainDel = [[UIApplication sharedApplication] delegate];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data: %@",loginUser.setting.iphoneDic);
        
        [mainDelegate saveLoginUser:loginUser];
        [self getLobbyDataWithoutPin];
    }
    User *userObject = [mainDelegate retrieveLoginUser];
    
    NSLog(@"User:%@",userObject.setting.iphoneDic);
    dataLogin = [[NSMutableDictionary alloc] init];
    dataLogin = [parse objectWithString:json_String];
    BOOL status = [[dataLogin valueForKey:@"status"] intValue];
    if (status) {
        NSLog(@"Status is ok");
    }
    

}
- (User *)parseLoginResponse:(NSDictionary *)temp{
    //SBJsonParser *parse = [[SBJsonParser alloc] init];
    AppDelegate *mainDel = [[UIApplication sharedApplication] delegate];
    //2
    NSLog(@"Temp %@",temp);
   // self.managedObjectContext = appDelegate12.managedObjectContext;
    //AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    //NSMutableDictionary *temp = [parse objectWithString:jsonResponse];
    //NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if ([temp isKindOfClass:[NSDictionary class]]) {
        if (managedObjectContext == nil)
        {
            managedObjectContext = [mainDel managedObjectContext];
        }
        
        User *newUser = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
        newUser.aboutme            = [temp objectOrNilForKey:@"aboutme"];
        newUser.age                = [temp objectOrNilForKey:@"age"];
        newUser.canposttocitylobby = [temp objectOrNilForKey:@"canposttocitylobby"];
        newUser.access_token       = [temp objectOrNilForKey:@"access_token"];
        newUser.accesstoavatar     = [temp objectOrNilForKey:@"accesstoavatar"];
        newUser.checkedinago       = [temp objectOrNilForKey:@"checkedinago"];
        newUser.citylobbyid        = [temp objectOrNilForKey:@"citylobbyid"];
        newUser.firstname          = [temp objectOrNilForKey:@"firstname"];
        newUser.fullname           = [temp objectOrNilForKey:@"fullname"];
        newUser.gender             = [temp objectOrNilForKey:@"gender"];
        newUser.iden               = [temp objectOrNilForKey:@"id"];
        newUser.inbox_messages     = [temp objectOrNilForKey:@"inbox_messages"];
        newUser.isonline           = [temp objectOrNilForKey:@"isonline"];
        newUser.lastname           = [temp objectOrNilForKey:@"lastname"];
        //newUser.pictureupload      = [temp objectOrNilForKey:@"pictureupload"];
        newUser.profile_url        = [temp objectOrNilForKey:@"profile_url"];
        newUser.show_link_option   = [temp objectOrNilForKey:@"show_link_option"];
        newUser.username           = [temp objectOrNilForKey:@"username"];
        newUser.occupation         = [[temp valueForKey:@"work" ]objectOrNilForKey:@"occupation"];
        newUser.employer           = [[temp valueForKey:@"work"]objectOrNilForKey:@"employer"];
        newUser.degree             = [[temp valueForKey:@"education"] objectOrNilForKey:@"degree"];
        newUser.school             = [[temp valueForKey:@"education"] objectOrNilForKey:@"school"];
        
        Role *roleObject = [self roleParsing:[temp valueForKey:@"roles"]];
        newUser.role = roleObject;
        Contact *contactObject = [self contactParsing:[temp valueForKey:@"contact"]];
        newUser.contact = contactObject;
        Location *locationObject = [self locationParsing:[temp valueForKey:@"location"]];
        newUser.location = locationObject;
        CheckIns *checkinsObject = [self checkinsParsing:[temp valueForKey:@"checkin"]];
        newUser.checkins = checkinsObject;
        Setting *settingObject = [self settingParsing:[temp valueForKey:@"settings"]];
        newUser.setting = settingObject;
        return newUser;
    }
    return nil;

}
-(Role *)roleParsing:(NSDictionary *)roleData{
        Role *roleUser  = (Role *)[NSEntityDescription insertNewObjectForEntityForName:@"Role" inManagedObjectContext:self.managedObjectContext];
    if ([[roleData objectOrNilForKey:@"2"] isEqualToString:@"2"]) {
        //
    }
    for (NSString *attr in  roleData) {
        id value = [roleData objectForKey:attr];
        if ([roleData count]==1 && [attr isEqualToString:@"2"]) {
            roleUser.userType = [NSNumber numberWithInteger:AUTHENTICATED_USER];
            roleUser.roleName = value;
        }else{
            if (![attr isEqualToString:@"2"]) {
                roleUser.userType = [NSNumber numberWithInteger:[attr intValue]];
                roleUser.roleName = value;
            }
        
        }
    }
    //roleUser.roleName = [roleData objectOrNilForKey:@"2"];
    //roleUser.userType = [roleData objectOrNilForKey:@"3"];
    NSLog(@"Role: %@",roleUser);
    return roleUser;

}
-(Location *)locationParsing:(NSDictionary *)locationData{
    Location *locationUser = (Location *)[NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    locationUser.city = [locationData objectOrNilForKey:@"city"];
    locationUser.country = [locationData objectOrNilForKey:@"country"];
    locationUser.county  = [locationData objectOrNilForKey:@"county"];
    NSLog(@"Location: %@",locationData);
    return locationUser;

}
-(Contact *)contactParsing:(NSDictionary *)contactData{
    Contact *contactUser = (Contact *)[NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:self.managedObjectContext];
    contactUser.email = [contactData objectOrNilForKey:@"email"];
    contactUser.facebook= [contactData objectOrNilForKey:@"facebook"];
    contactUser.linkedin = [contactData objectOrNilForKey:@"linkedin"];
    contactUser.phone  = [contactData objectOrNilForKey:@"phone"];
    contactUser.twitter = [contactData objectOrNilForKey:@"twitter"];
    NSLog(@"Contact: %@",contactUser);
    return contactUser;

}
- (CheckIns *)checkinsParsing:(NSDictionary *)checkinsData{
    CheckIns *checkinsUser = (CheckIns *)[NSEntityDescription insertNewObjectForEntityForName:@"CheckIns" inManagedObjectContext:self.managedObjectContext];
    checkinsUser.checkin = [checkinsData objectOrNilForKey:@"checkin"];
    checkinsUser.checkout = [checkinsData objectOrNilForKey:@"checkout"];
    checkinsUser.daysofstay = [checkinsData objectOrNilForKey:@"daysofstay"];
    checkinsUser.firstaccess = [checkinsData objectOrNilForKey:@"firstaccess"];
    checkinsUser.hotelid = [checkinsData objectOrNilForKey:@"hotelid"];
    checkinsUser.lastaccess = [checkinsData objectOrNilForKey:@"lastaccess"];
    checkinsUser.reason = [checkinsData objectOrNilForKey:@"reason"];
    checkinsUser.roomNo = [checkinsData objectOrNilForKey:@"room#"];
    checkinsUser.validfrom = [checkinsData objectOrNilForKey:@"validfrom"];
    checkinsUser.validto = [checkinsData objectOrNilForKey:@"validto"];
    NSLog(@"Checkins: %@",checkinsUser);
    return checkinsUser;

}
-(Setting *)settingParsing:(NSDictionary *)settingData{
    Setting *settingUser = (Setting *)[NSEntityDescription insertNewObjectForEntityForName:@"Setting" inManagedObjectContext:self.managedObjectContext];
    settingUser.picture = [settingData objectOrNilForKey:@"picture"];
    Iphone *iphoneObject = [self iPhoneParsing:[settingData valueForKey:@"iphone"]];
    settingUser.iphoneDic = iphoneObject;
    NSLog(@"Setting : %@",settingUser);
    return settingUser;
}
- (Iphone *)iPhoneParsing:(NSDictionary *)iphoneData{
    Iphone *iphoneUser = (Iphone *)[NSEntityDescription insertNewObjectForEntityForName:@"Iphone" inManagedObjectContext:self.managedObjectContext];
    if ([iphoneData isKindOfClass:[NSDictionary class]]) {
    iphoneUser.hotel_post_info = [iphoneData objectOrNilForKey:@"hotel_post_info"];
    iphoneUser.likes_my_post   = [iphoneData objectOrNilForKey:@"likes_my_post"];
    iphoneUser.show_offline    = [iphoneData objectOrNilForKey:@"show_offline"];
    NSLog(@"@Iphone: %@", iphoneUser);
    }
    return  iphoneUser;

}

- (void)getLobbyDataWithoutPin{
    
    NSString *json_String=nil;//*urlString=nil;
    NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_lobby/lobby.json"];
    url = [NSURL URLWithString:urlString1];
    //[commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    
    User *loginUser = [mainDelegate retrieveLoginUser];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"&hotelid=%d&blocksize=12&offset=0",[loginUser.checkins.hotelid intValue]]];
    
    //[parameter appendString:[self getParameterString:parameter]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    Lobby *lobby =    [self parseLobbyData:json_String];
    [[LobbyDataController getLobbyInstance] addDataOfLobby:lobby];
    
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data: %@",loginUser.setting.iphoneDic);
        


    }
    Lobby *dataGet = [[LobbyDataController getLobbyInstance] getDataOfLobby];
    NSLog(@"Lobby Data: %@",[dataGet.postArray objectAtIndex:1]);
    NSLog(@"Hotel Object: %@",dataGet.hotel);
    parse = [[SBJsonParser alloc] init];
    
    dataLogin = [[NSMutableDictionary alloc] init];
    dataLogin = [parse objectWithString:json_String];


}
-(Lobby *)parseLobbyData:(NSString *)_lobbyData{
    tempDic = [[NSMutableArray alloc] init];
    NSLog(@"Lobby Data: %@",_lobbyData);
    if (managedObjectContext==nil) {
        managedObjectContext = [mainDelegate managedObjectContext];
    }
    SBJsonParser *parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:_lobbyData];
    Lobby *lobbyObject = (Lobby *)[NSEntityDescription insertNewObjectForEntityForName:@"Lobby" inManagedObjectContext:self.managedObjectContext];
    Hotel *hotelObject = [self hotelParsing:[temp valueForKey:@"hoteldetails"]];
    lobbyObject.hotel = hotelObject;
    Post *postUser = [self facebookPostParsing:[temp valueForKey:@"facebookposts"]];
    [tempDic addObject:postUser  ];
    Post *twitterPost = [self twitterPostParsing:[temp valueForKey:@"twitterposts"]];
    [tempDic addObject:twitterPost];
    Post *rssPost =  [self rssPostParsing:[temp valueForKey:@"rssposts"]];
    [tempDic addObject:rssPost];
   // NSArray *post = [temp valueForKey:@"posts"];
    NSLog(@"Sticky %@", [[temp valueForKey:@"posts"] valueForKey:@"sticky"]);
    NSLog(@"Non Sticky %@",[[temp valueForKey:@"posts"] valueForKey:@"nonsticky"]);
    lobbyObject.stickyPost =  [self postsPostParsing:[[temp valueForKey:@"posts"] valueForKey:@"sticky"]];
    for (NSDictionary *dic in  [(NSArray *)[temp valueForKey:@"posts"] valueForKey:@"nonsticky"]) {
        
          Post *notSticky =   [self postsPostParsing:dic];
          [tempDic addObject:notSticky];
        
    }
    [self postFeedParsing:[temp valueForKey:@"postfeed"]];
    
    //[self postsPostParsing:[[temp valueForKey:@"posts"] valueForKey:@"sticky"]];
   // [self postsPostParsing:[temp valueForKey:@"posts"]];

    lobbyObject.postArray = tempDic;
    
    
    
    NSLog(@"Lobby Object %@", lobbyObject);
    return lobbyObject;

}
- (Hotel *)hotelParsing:(NSDictionary *)hotelData{

    Hotel *hotelUser = (Hotel *)[NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
    hotelUser.citylobbyid = [hotelData objectOrNilForKey:@"citylobbyid"];
    hotelUser.currency = [hotelData objectOrNilForKey:@"currency"];
    hotelUser.desc = [hotelData objectOrNilForKey:@"desc"];
    hotelUser.general_hotel = [hotelData objectOrNilForKey:@"general_hotel"];
    hotelUser.hotel_id = [hotelData objectOrNilForKey:@"hotel_id"];
    hotelUser.hotel_imageURL = [hotelData objectOrNilForKey:@"hotel_imageURL"];
    hotelUser.title = [hotelData objectOrNilForKey:@"title"];
    hotelUser.title1 = [hotelData objectOrNilForKey:@"title1"];
    hotelUser.title2 = [hotelData objectOrNilForKey:@"title2"];
    hotelUser.title3 = [hotelData objectOrNilForKey:@"title3"];
    hotelUser.url1 = [hotelData objectOrNilForKey:@"url1"];
    hotelUser.url2 = [hotelData objectOrNilForKey:@"url2"];
    hotelUser.url3 = [hotelData objectOrNilForKey:@"url3"];
    
    Contact *contactObject = [self contactParsing:[hotelData valueForKey:@"contact"]];
    hotelUser.contact = contactObject;
    Location *locationObject = [self locationParsing:[hotelData valueForKey:@"location"]];
    hotelUser.location = locationObject;
    NSLog(@"Hotel Data: %@ %@ %@",hotelUser, hotelUser.contact,hotelUser.location);
    
    return hotelUser;
}
- (Post *)facebookPostParsing:(NSArray *)postData{
    
    if ([postData isKindOfClass:[NSArray class]]) {
        Post *postUser = (Post *)[NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:self.managedObjectContext];
    
    for (NSDictionary *postDic in  postData) {
        if ([postDic isKindOfClass:[NSDictionary class]]) {
            
            NSLog(@"Post link %@",[postDic valueForKey:@"link"]);
            NSLog(@"Post message %@",[postDic valueForKey:@"message"]);
            NSLog(@"Post From %@",[postDic valueForKey:@"from"]);
            NSLog(@"Post ts %@",[postDic valueForKey:@"ts"]);
            NSLog(@"Post Object id %@",[postDic valueForKey:@"object_id"]);
            
            postUser.iden = [postDic objectOrNilForKey:@"object_id"];
            postUser.description2 = [postDic objectForKey:@"message"];
            postUser.title = [[postDic valueForKey:@"from"] objectOrNilForKey:@"name"];
            postUser.created_time = [postDic objectOrNilForKey:@"ts"];
            postUser.link = [postDic objectOrNilForKey:@"link"];
        }
    }
        NSLog(@"Post User: %@",postUser);
        return postUser;
    }
    


    return nil;

}
-(Post *)twitterPostParsing:(NSArray *)twitterPost{
    
    if ([twitterPost isKindOfClass:[NSArray class]]) {
        Post *postUser = (Post *)[NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:self.managedObjectContext];
        
        for (NSDictionary *postDic in  twitterPost) {
            if ([postDic isKindOfClass:[NSDictionary class]]) {
                
                
                postUser.iden = [postDic objectOrNilForKey:@"id"];
                postUser.description2 = [postDic objectForKey:@"text"];
                postUser.title = [postDic objectOrNilForKey:@"screen_name"];
                postUser.created_time = [postDic objectOrNilForKey:@"ts"];
                postUser.link = [postDic objectOrNilForKey:@"url"];
            }
        }
        NSLog(@"Post User: %@",postUser);
        return  postUser;
    }
    return nil;
}
- (Post *)rssPostParsing:(NSArray *)rssPost{
    if ([rssPost isKindOfClass:[NSArray class]]) {
        Post *postUser = (Post *)[NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:self.managedObjectContext];
        
        for (NSDictionary *postDic in  rssPost) {
            if ([postDic isKindOfClass:[NSDictionary class]]) {
                
                
                postUser.iden = [postDic objectOrNilForKey:@"feedid"];
                postUser.description2 = [postDic objectForKey:@"desc"];
                postUser.title = [postDic objectOrNilForKey:@"title"];
                postUser.created_time = [postDic objectOrNilForKey:@"ts"];
                postUser.link = [postDic objectOrNilForKey:@"link"];
            }
        }
        NSLog(@"Post User: %@",postUser);
        return postUser;
    }
    return nil;
    
}
- (Post *)postsPostParsing:(NSDictionary *)postsPost{
    
    //if ([postsPost isKindOfClass:[NSDictionary class]]) {
        Post *postUser = (Post *)[NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:self.managedObjectContext];
        
        //for (NSDictionary *postDic in  postsPost) {
            if ([postsPost isKindOfClass:[NSDictionary class]]) {
                
                
                postUser.iden         = [postsPost objectOrNilForKey:@"id"];
                postUser.description1 = [postsPost objectOrNilForKey:@"description"];
                postUser.cost         = [postsPost objectOrNilForKey:@"cost"];
                postUser.posterDetail = [self posterDetail:postsPost];
                postUser.description2 = [postsPost objectForKey:@"desc"];
                postUser.title        = [postsPost objectOrNilForKey:@"title"];
                postUser.created_time = [postsPost objectOrNilForKey:@"ts"];
                postUser.link         = [postsPost objectOrNilForKey:@"link"];
                //postUser.comments     = [postsPost objectOrNilForKey:@"comments"];
                postUser.currency     = [postsPost objectOrNilForKey:@"currency"];
                postUser.from         = [postsPost objectOrNilForKey:@"from"];
                postUser.guests       = [postsPost objectOrNilForKey:@"guests"];
                postUser.img          = [postsPost objectOrNilForKey:@"img"];
                //postUser.joined       = [postsPost objectOrNilForKey:@"joined"];
                //postUser.likecount    = [postsPost objectOrNilForKey:@"likecount"];
                postUser.optext       = [postsPost objectOrNilForKey:@"optext"];
                postUser.optype       = [postsPost objectOrNilForKey:@"optype"];
                postUser.post_picture = [postsPost objectOrNilForKey:@"post_picture"];
                postUser.timeago      = [postsPost objectOrNilForKey:@"timeago"];
                postUser.to           = [postsPost objectOrNilForKey:@"to"];
                postUser.type         = [postsPost objectOrNilForKey:@"type" ];
                postUser.where        = [postsPost objectOrNilForKey:@"where"];

                NSLog(@"Flags %@",[postsPost valueForKey:@"flags"]);
                postUser.flag =    [self flagsParsing:[postsPost valueForKey:@"flags"]];
                //[self flagsParsing:[[postsPost valueForKey:@"flags"] valueForKey:@"1"]];
               /* for (NSDictionary *dic in  (NSArray *)[postsPost valueForKey:@"flags"]) {
                    Flags *flagObject = [self flagsParsing:[[postsPost valueForKey:@"flags"] valueForKey:@"1"]];
                    postUser.flag = flagObject;
                }*/
                NSLog(@"Comment: %@",[postsPost valueForKey:@"comments"]);
                
                
            }
       // }
        NSLog(@"Post User: %@",postUser);
    return postUser;
        
    //}
}
- (Flags *)flagsParsing:(NSDictionary *)flagData{
    Flags *flagUser = (Flags *)[NSEntityDescription insertNewObjectForEntityForName:@"Flags" inManagedObjectContext:self.managedObjectContext];
    
    NSLog(@"data %@",[[[flagData valueForKey:@"2" ] valueForKey:@"flaginfo"] objectOrNilForKey:@"flagid"]);
    if ([flagData valueForKey:@"1"]) {
        flagUser.isUserLike = [flagData valueForKey:@"currentuser" ];
        flagUser.likeId = [[[flagData valueForKey:@"1" ] valueForKey:@"flaginfo"] objectOrNilForKey:@"flagid"];
    }else if ([flagData valueForKey:@"2"]){
        flagUser.isUserReported = [flagData valueForKey:@"currentuser"];
        flagUser.reportPortId = [[[flagData valueForKey:@"2" ] valueForKey:@"flaginfo"] objectOrNilForKey:@"flagid"];

    }

    return flagUser;

}

- (void)postFeedParsing:(NSDictionary *)postFeedData{
    
    Lobby *lobbyUser = (Lobby *)[NSEntityDescription insertNewObjectForEntityForName:@"Lobby" inManagedObjectContext:self.managedObjectContext];
    NSLog(@"Feed %@",postFeedData);
    lobbyUser.blocksize = [postFeedData objectOrNilForKey:@"blocksize"];
    lobbyUser.offset   = [postFeedData objectOrNilForKey:@"offset"];
    lobbyUser.postcount = [postFeedData objectOrNilForKey:@"postcount"];
    lobbyUser.sticky  = [postFeedData objectOrNilForKey:@"sticky"];

}
- (User *)posterDetail:(NSDictionary *)posterDetail{
    User *posterObject = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    if ([posterDetail valueForKey:@"posterdetails"] &&[posterDetail valueForKey:@"posterdetails"]!=[NSNull null]) {
        
    posterObject.employer = [[posterDetail valueForKey:@"posterdetails"]objectOrNilForKey:@"employer"];
    posterObject.iden = [[posterDetail valueForKey:@"posterdetails"]objectOrNilForKey:@"id"];
    posterObject.occupation = [[posterDetail valueForKey:@"posterdetails"]objectOrNilForKey:@"occupation"];
    posterObject.pictureupload = [[posterDetail valueForKey:@"posterdetails"]objectOrNilForKey:@"picture"];
    posterObject.role = [self roleParsing:[[posterDetail valueForKey:@"posterdetails"] valueForKey:@"roles"]];
    NSLog(@"Poster %@",posterObject);
    NSLog(@"role: %@",posterObject.role);
    
    return posterObject;
    }
    return nil;

}
//////// Guest Services
- (void)getCityGuestData{
    NSString *json_String=nil;//*urlString=nil;
    //NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_citylobby/guest.json"];
    url = [NSURL URLWithString:urlString1];
    //[commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    Lobby *lobby = [LobbyDataController getLobbyInstance].getDataOfLobby;
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"&citylobbyid=%d",[lobby.hotel.citylobbyid intValue]]];
    //[parameter appendString:[self getParameterString:loginData]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    Guest *guest = [self parseGuestResponse:temp];
    [[GuestDataController getGuestInstance] addDataOfGuest:guest];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data:");
        Guest *newObject = [[GuestDataController getGuestInstance] getDataOfGuest];
        NSLog(@"Guest %@",newObject);
        NSLog(@"Guest Array %@", newObject.guestArray);
    }
   // GuestsViewController *guestController = [[GuestsViewController alloc] init];
    //[guestController reloadTableData];


}
-(void)getHotelGuestData{
    NSString *json_String=nil;//*urlString=nil;
   // NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_lobby/guest.json"];
    url = [NSURL URLWithString:urlString1];
    //[commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    Lobby *lobby = [LobbyDataController getLobbyInstance].getDataOfLobby;

    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"hotelid=%d",[lobby.hotel.hotel_id intValue]]];
    //[parameter appendString:[self getParameterString:loginData]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    Guest *guest = [self parseGuestResponse:temp];
    [[GuestDataController getGuestInstance] addDataOfGuest:guest];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data:");
        Guest *newObject = [[GuestDataController getGuestInstance] getDataOfGuest];
        NSLog(@"Guest %@",newObject);
        NSLog(@"Guest Array %@", newObject.guestArray);
    }
    
   // GuestsViewController *guestController = [[GuestsViewController alloc] init];
   // [guestController reloadTableData];


}
- (Guest *)parseGuestResponse:(NSDictionary *)guestData{
    Guest *guestObject = (Guest *)[NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.managedObjectContext];
    NSLog(@"Guest: %@",guestData);
    
    guestObject.blocksize  = [guestData objectOrNilForKey:@"blocksize"];
    guestObject.guest      = [guestData objectOrNilForKey:@"guest"];
    guestObject.offset     = [guestData objectOrNilForKey:@"offset"];
    guestObject.staffCount = [guestData objectOrNilForKey:@"staffcount"];
    guestObject.total      = [guestData objectOrNilForKey:@"total"];
    
    if ([guestData valueForKey:@"guests"]) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        NSArray *array = [guestData valueForKey:@"guests"];
        for (NSDictionary *dic in  array) {
            NSLog(@"Dic%@",dic);
            User *userGuest = [self parseLoginResponse: dic];
            NSLog(@"User %@",userGuest);
            [tempArray addObject:userGuest];
        }
        NSLog(@"Tem Array %@",tempArray);
        guestObject.guestArray = tempArray;
        
    }
    
    NSLog(@"Array %@",guestObject.guestArray);
    return guestObject;
    


}


- (void)getCityDealsData{
    NSString *json_String=nil;//*urlString=nil;
   // NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_citylobby/deals.json"];
    url = [NSURL URLWithString:urlString1];
    //[commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    Lobby *lobby = [[LobbyDataController getLobbyInstance] getDataOfLobby];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"&citylobbyid=%d",[lobby.hotel.citylobbyid intValue]]];
    //[parameter appendString:[self getParameterString:loginData]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    Deals *deals = [self parseDealsResponse:temp];
    [[DealDataController getDealInstance] addDataOfDeals:deals];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data:");
        Deals *newObject = [[DealDataController getDealInstance] getDataOfDeals];
        NSLog(@"Guest %@",newObject);
        //NSLog(@"Guest Array %@", newObject.guestArray);
    }
    
    
}

- (void)getHotelDealsData{
    NSString *json_String=nil;//*urlString=nil;
    //NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_lobby/deals.json"];
    url = [NSURL URLWithString:urlString1];
    //[commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    Lobby *lobby = [[LobbyDataController getLobbyInstance] getDataOfLobby];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"hotelid=%d",[lobby.hotel.hotel_id intValue]]];
    //[parameter appendString:[self getParameterString:loginData]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    Deals *deals = [self parseDealsResponse:temp];
    [[DealDataController getDealInstance] addDataOfDeals:deals];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data:");
        Deals *newObject = [[DealDataController getDealInstance] getDataOfDeals];
        NSLog(@"Guest %@",newObject.dealsArray);
       
    }

    
    
}

- (Deals *)parseDealsResponse:(NSDictionary *)dealsData{
    Deals *dealObject = (Deals *)[NSEntityDescription insertNewObjectForEntityForName:@"Deals" inManagedObjectContext:self.managedObjectContext];
    dealObject.blocksize = [dealsData objectOrNilForKey:@"blocksize"];
    dealObject.offset    = [dealsData objectOrNilForKey:@"offset"];
    //dealObject.dealcount = [dealsData objectOrNilForKey:@"dealcount"];
    NSLog(@"%@",[dealsData valueForKey:@"sticky"]);
    NSLog(@"%@",[dealsData valueForKey:@"deals"]);
    if ([dealsData valueForKey:@"deals"]) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        NSArray *dealsArray = [dealsData valueForKey:@"deals"];
        for (NSDictionary *dic in  dealsArray) {
           NSLog(@"Dic %@",dic);
            Post *post = [self postsPostParsing:dic];
          [tempArray addObject:post];
         }
      dealObject.dealsArray = tempArray;
        
    }else if([[dealsData valueForKey:@"sticky"] isEqualToString:@"sticky"]){
        NSLog(@"%@",[dealsData valueForKey:@"sticky"]);
        Post *stickyPost = [self postsPostParsing:[dealsData valueForKey:@"sticky"]];
        dealObject.stickyPost = stickyPost;
    }
    return dealObject;

}

#pragma mark Event Services

- (void)getEventInHotelLobby{
    NSString *json_String=nil;//*urlString=nil;
   // NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_lobby/events.json"];
    url = [NSURL URLWithString:urlString1];
    //[commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    Lobby *lobby = [[LobbyDataController getLobbyInstance] getDataOfLobby];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"hotelid=%d",[lobby.hotel.hotel_id intValue]]];
    //[parameter appendString:[self getParameterString:loginData]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    Event *event = [self parseEventResponse:temp];
    [[EventDataController getEventInstance] addDataOfEvent:event];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data:");
        Event *newObject = [[EventDataController getEventInstance] getDataOfEvent];
        NSLog(@"Guest %@",newObject.eventArray);
        
    }
    
    
    
}
- (void)getEventInCityLobby{
    NSString *json_String=nil;//*urlString=nil;
    //NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_citylobby/events.json"];
    url = [NSURL URLWithString:urlString1];
    //[commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    Lobby *lobby = [[LobbyDataController getLobbyInstance] getDataOfLobby];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"hotelid=%d",[lobby.hotel.hotel_id intValue]]];
    //[parameter appendString:[self getParameterString:loginData]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    Event *event = [self parseEventResponse:temp];
    [[EventDataController getEventInstance] addDataOfEvent:event];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data:");
        Event *newObject = [[EventDataController getEventInstance] getDataOfEvent];
        NSLog(@"Guest %@",newObject.eventArray);
        
    }
    
    
    
}
- (Event *)parseEventResponse:(NSDictionary *)eventData{
    Event *eventObject = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    eventObject.blocksize = [eventData objectOrNilForKey:@"blocksize"];
    eventObject.offset    = [eventData objectOrNilForKey:@"offset"];
    eventObject.eventcount = [eventData objectOrNilForKey:@"eventcount"];
    NSLog(@"%@",[eventData valueForKey:@"sticky"]);
    NSLog(@"%@",[eventData valueForKey:@"deals"]);
    if ([eventData valueForKey:@"events"]) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        NSArray *dealsArray = [eventData valueForKey:@"events"];
        for (NSDictionary *dic in  dealsArray) {
            NSLog(@"Dic %@",dic);
            Post *post = [self postsPostParsing:dic];
            [tempArray addObject:post];
        }
        eventObject.eventArray = tempArray;
        
    }else if([eventData valueForKey:@"sticky"] ){
        NSLog(@"%@",[eventData valueForKey:@"sticky"]);
        Post *stickyPost = [self postsPostParsing:[eventData valueForKey:@"sticky"]];
        eventObject.stickyPost = stickyPost;
    }
    return eventObject;
    
}

#pragma mark Inbox Services
- (void)getInboxData{
    NSString *json_String=nil;//*urlString=nil;
    //NSDictionary *dataLogin =nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_msg/inbox.json"];
    url = [NSURL URLWithString:urlString1];
    //[commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    //Lobby *lobby = [[LobbyDataController getLobbyInstance] getDataOfLobby];
    User *user = [mainDelegate retrieveLoginUser];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"uid=%d",[user.iden intValue]]];
    //[parameter appendString:[self getParameterString:loginData]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
    NSMutableDictionary *temp = [parse objectWithString:json_String];
    Inbox *inbox = [self parseInboxResponse:temp];
    [[InboxDataController getInboxInstance] addDataOfInbox:inbox];
    if (![self.managedObjectContext save:nil])
    {
        NSLog(@"NOT saved data");
    }
    else{
        NSLog(@"User Data:");
        Inbox *newObject = [[InboxDataController getInboxInstance] getDataOfInbox];
        NSLog(@"Guest %@",newObject.messageArray);
        
    }
    
    
    
}
- (Inbox *)parseInboxResponse:(NSDictionary *)inboxData{
    Inbox *inboxObject = (Inbox *)[NSEntityDescription insertNewObjectForEntityForName:@"Inbox" inManagedObjectContext:self.managedObjectContext];
    inboxObject.blocksize = [inboxData objectOrNilForKey:@"blocksize"];
    inboxObject.offset    = [inboxData objectOrNilForKey:@"offset"];
    inboxObject.all       = [inboxData objectOrNilForKey:@"all"];
    inboxObject.inboxcount= [inboxData objectOrNilForKey:@"inboxcount"];
    inboxObject.sent      = [inboxData objectOrNilForKey:@"sent"];
    inboxObject.unread    = [inboxData objectOrNilForKey:@"unread"];
    //inboxObject.eventcount = [inboxData objectOrNilForKey:@"eventcount"];
    if ([inboxData valueForKey:@"messages"]) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        NSArray *dealsArray = [inboxData valueForKey:@"messages"];
        for (NSDictionary *dic in  dealsArray) {
            NSLog(@"Dic %@",dic);
            Message *message = [self messageParse:dic];
            [tempArray addObject:message];
        }
        NSLog(@"Array %@",tempArray);
        inboxObject.messageArray = tempArray;
        
    }
    return inboxObject;

}

- (Message *)messageParse:(NSDictionary *)messageData{
    Message *messageObject = (Message *)[NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    NSLog(@"Message Dat %@",messageData);
    if ([messageData isKindOfClass:[NSDictionary class]]) {
        
    messageObject.body = [[messageData valueForKey:@"message"] objectOrNilForKey:@"body"];
    messageObject.created_time = [[messageData valueForKey:@"message"] objectOrNilForKey:@"created_time"];
    messageObject.message_id = [[messageData valueForKey:@"message"] objectOrNilForKey:@"message_id"];
    messageObject.read_status = [[messageData valueForKey:@"message"] objectOrNilForKey:@"read_status"];
    messageObject.subject = [[messageData valueForKey:@"message"] objectOrNilForKey:@"subject"];
        NSLog(@"dic %@",[messageData valueForKey:@"sender"]);
        NSDictionary *userDic =[messageData valueForKey:@"sender"];
        if ([userDic isKindOfClass:[NSDictionary class]]) {
            messageObject.sender  = [self parseLoginResponse:[messageData valueForKey:@"sender"]];
        }
    
    }
    
    return messageObject;
}


#pragma mark Private Message 
- (void)PrivateMessageSend:(NSDictionary *)messageData{
    
    NSString *json_String=nil;//*urlString=nil;
    NSURL *url=nil;
    NSMutableURLRequest *request=nil;
    NSData *oResponseData=nil, *postData=nil;
    NSHTTPURLResponse *responseCode=nil;
    NSError *error=nil;
    SBJsonParser *parse=nil;
    NSString *postLength=nil;
    
    //urlString = [NSString stringWithFormat:@"%@service_lf_user/login.json",APPURL];
    //url       = [NSURL URLWithString:urlString];
    
    NSMutableString *urlString1 = [[NSMutableString alloc] init];//lf_user
    [urlString1 setString:APPURL];
	[urlString1 appendFormat:@"service_lf_msg/send.json"];
    url = [NSURL URLWithString:urlString1];
    [commonUsedMethod clearCookiesForServer:url];
    request   = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    //postData  = [[self getParameterString:loginData] dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *parameter = [[NSMutableString alloc] init];
    [parameter setString:[NSString stringWithFormat:@"%@",@"&"]];
    [parameter appendString:[self getParameterString:messageData]];
    //[parameter appendString:EXTRA_PARAMETERS];
    
    NSString *parameter2 = [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Parameter %@",parameter2);
    postData  = [parameter2 dataUsingEncoding:NSUTF8StringEncoding];
    postLength= [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"Post"];
    
    oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    // oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    json_String = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    parse = [[SBJsonParser alloc] init];
}



@end
