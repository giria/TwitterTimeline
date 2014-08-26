//
//  GTweet.m
//  TwitterTimeline
//
//  Created by Joan Barrull Ribalta on 25/08/14.
//  Copyright (c) 2014 com.giria. All rights reserved.
//

#import "GTweet.h"
#import "GUser.h"


@implementation GTweet

@dynamic identifier;
@dynamic publicationDate;
@dynamic text;
@dynamic user;
@dynamic retweetedBy;

+ (NSFetchRequest *)fetchRequestForAllTweets
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"identifier"
                                                                     ascending:NO];
    
    NSFetchRequest *fetchRequest = [self fetchRequest];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    return fetchRequest;
}

+ (id)firstTweetInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"identifier"
                                                                     ascending:YES];
    
    NSFetchRequest *fetchRequest = [self fetchRequest];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    [fetchRequest setFetchLimit:1];
    
    return [[context executeFetchRequest:fetchRequest error:NULL] lastObject];
}

+ (id)lastTweetInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"identifier"
                                                                     ascending:NO];
    
    NSFetchRequest *fetchRequest = [self fetchRequest];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    [fetchRequest setFetchLimit:1];
    
    return [[context executeFetchRequest:fetchRequest error:NULL] lastObject];
}
- (void)importValuesFromDictionary:(NSDictionary *)dictionary
{
    self.identifier = dictionary[@"id"];
    
    NSDictionary *retweetedStatus = dictionary[@"retweeted_status"];
    
    NSString *dateString = nil;
    NSDictionary *userDictionary = nil;
    NSDictionary *retweetedByDictionary = nil;
    
    if (retweetedStatus) {
        self.text = retweetedStatus[@"text"];
        
        dateString = retweetedStatus[@"created_at"];
        userDictionary = retweetedStatus[@"user"];
        retweetedByDictionary = dictionary[@"user"];
    }
    else {
        self.text = dictionary[@"text"];
        
        dateString = dictionary[@"created_at"];
        userDictionary = dictionary[@"user"];
    }
    
    self.publicationDate = [[self class] dateFromTwitterDate:dateString];
    
    GUser *user = [GUser twitterUserWithIdentifier:userDictionary[@"id"]
                                              inManagedObjectContext:self.managedObjectContext];
    
    if (!user) {
        user = [GUser importFromDictionary:userDictionary
                             inManagedObjectContext:self.managedObjectContext];
    }
    
    self.user = user;
    
    if (retweetedByDictionary) {
        GUser *retweetedBy = [GUser twitterUserWithIdentifier:retweetedByDictionary[@"id"]
                                                         inManagedObjectContext:self.managedObjectContext];
        
        if (!retweetedBy) {
            retweetedBy = [GUser importFromDictionary:retweetedByDictionary
                                        inManagedObjectContext:self.managedObjectContext];
        }
        
        self.retweetedBy = retweetedBy;
    }
}
+ (NSDate *)dateFromTwitterDate:(NSString *)dateString
{
    static dispatch_once_t onceToken;
    static NSDateFormatter *dateFormatter;
    
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    });
    
    return [dateFormatter dateFromString:dateString];
}

@end
