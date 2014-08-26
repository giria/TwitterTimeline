//
//  GTweet.h
//  TwitterTimeline
//
//  Created by Joan Barrull Ribalta on 25/08/14.
//  Copyright (c) 2014 com.giria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GManagedObject.h"

@interface GTweet : GManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSDate * publicationDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSManagedObject *user;
@property (nonatomic, retain) NSManagedObject *retweetedBy;

+ (NSFetchRequest *)fetchRequestForAllTweets;

+ (id)firstTweetInManagedObjectContext:(NSManagedObjectContext *)context;
+ (id)lastTweetInManagedObjectContext:(NSManagedObjectContext *)context;



@end
