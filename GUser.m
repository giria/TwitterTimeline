//
//  GUser.m
//  TwitterTimeline
//
//  Created by Joan Barrull Ribalta on 25/08/14.
//  Copyright (c) 2014 com.giria. All rights reserved.
//

#import "GUser.h"
#import "GTweet.h"


@implementation GUser

@dynamic identifier;
@dynamic text;
@dynamic name;
@dynamic screenName;
@dynamic imageLink;
@dynamic tweets;
@dynamic retweets;

+ (NSFetchRequest *)fetchRequestForTwitterUserWithIdentifier:(NSNumber *)identifier
{
    static dispatch_once_t onceToken;
    static NSPredicate *predicateTemplate;
    
    dispatch_once(&onceToken, ^{
        predicateTemplate = [NSPredicate predicateWithFormat:@"identifier == $IDENTIFIER"];
    });
    
    NSPredicate *predicate = [predicateTemplate predicateWithSubstitutionVariables:
                              [NSDictionary dictionaryWithObject:identifier forKey:@"IDENTIFIER"]];
    
    NSFetchRequest *fetchRequest = [self fetchRequest];
    [fetchRequest setPredicate:predicate];
    
    return fetchRequest;
}

+ (id)twitterUserWithIdentifier:(NSNumber *)identifier inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [self fetchRequestForTwitterUserWithIdentifier:identifier];
    return [[context executeFetchRequest:fetchRequest error:NULL] lastObject];
}

- (void)importValuesFromDictionary:(NSDictionary *)dictionary
{
    self.identifier = dictionary[@"id"];
    self.name = dictionary[@"name"];
    self.screenName = dictionary[@"screen_name"];
    self.imageLink = dictionary[@"profile_image_url"];
}


@end
