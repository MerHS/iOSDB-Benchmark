//
//  DBSender.h
//  FMDB
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBSender : NSObject

@property (nonatomic) NSInteger senderID;
@property (nonatomic, strong) NSString * senderName;
@property (nonatomic, strong) NSData * senderImage;

-(id) initWithoutID;
+(DBSender *) getRandomSender;

@end
