//
//  DBMessage.m
//  FMDB
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import "DBMessage.h"

@implementation DBMessage

@synthesize messageID;
@synthesize msgData;
@synthesize sendTime;
@synthesize viewed;
@synthesize senderID;

-(id) init
{
    static int maxID = 0;
    self = [super init];
    self.messageID = (maxID++);
    return self;
}

-(id) initWithoutID
{
    self = [super init];
    return self;
}

+(DBMessage *) getRandomMessage
{
    DBMessage *msg = [[DBMessage alloc] init];
    msg.msgData = [[NSUUID UUID] UUIDString];
    msg.sendTime = [NSDate dateWithTimeIntervalSinceReferenceDate:arc4random_uniform(10000)];
    msg.viewed = NO;
    msg.senderID = 0;
    return msg;
}

+(DBMessage *) getRandomMessage:(NSInteger)senderID
{
    DBMessage *msg = [[DBMessage alloc] init];
    msg.msgData = [[NSUUID UUID] UUIDString];
    msg.sendTime = [NSDate dateWithTimeIntervalSinceReferenceDate:arc4random_uniform(10000)];
    msg.viewed = NO;
    msg.senderID = senderID;
    return msg;
}
@end
