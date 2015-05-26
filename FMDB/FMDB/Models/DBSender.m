//
//  DBSender.m
//  FMDB
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import "DBSender.h"

@implementation DBSender

@synthesize senderID;
@synthesize senderImage;
@synthesize senderName;

-(id) init
{
    static NSInteger idMax = 0;
    self = [super init];
    self.senderID = idMax++;
    return self;
}

-(id) initWithoutID
{
    self = [super init];
    return self;
}

+(DBSender *) getRandomSender
{
    DBSender *sender = [[DBSender alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"chess" ofType:@"png"];
    sender.senderImage = [NSData dataWithContentsOfFile:path];
    sender.senderName = [[NSUUID UUID] UUIDString];
    return sender;
}


@end
