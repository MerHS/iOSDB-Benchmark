//
//  DBMessage.m
//  Realm
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import "DBMessage.h"

@implementation DBMessage

-(id) init
{
    static NSInteger maxID = 0;
    self = [super init];
    self.messageID = (maxID++);
    return self;
}

-(id) initWithoutID
{
    self = [super init];
    return self;
}

+(NSString *) primaryKey{
    return @"messageID";
}

+(DBMessage *) getRandomMessage
{
    DBMessage *msg = [[DBMessage alloc] init];
    msg.msgData = [[NSUUID UUID] UUIDString];
    msg.sendTime = [NSDate dateWithTimeIntervalSinceReferenceDate:arc4random_uniform(10000)];
    msg.viewed = arc4random_uniform(2) ? YES : NO;
    msg.senderID = 0;
    return msg;
}

+(DBMessage *) getRandomMessage:(DBSender *)senderID
{
    DBMessage *msg = [[DBMessage alloc] init];
    msg.msgData = [[NSUUID UUID] UUIDString];
    msg.sendTime = [NSDate dateWithTimeIntervalSinceReferenceDate:arc4random_uniform(10000)];
    msg.viewed = arc4random_uniform(2) ? YES : NO;
    msg.senderID = senderID;
    [senderID.messages addObject:msg];
    return msg;
}


// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
