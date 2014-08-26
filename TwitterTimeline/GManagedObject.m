//
//  GManagedObject.m
//  TwitterTimeline
//
//  Created by Joan Barrull Ribalta on 25/08/14.
//  Copyright (c) 2014 com.giria. All rights reserved.
//

#import "GManagedObject.h"

@implementation GManagedObject

+ (NSString *)entityName
{
    return NSStringFromClass([self class]);
}

+ (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    [fetchRequest setFetchBatchSize:25];
    
    return fetchRequest;
}

+ (id)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                         inManagedObjectContext:context];
}

+ (id)importFromDictionary:(NSDictionary *)dictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    GManagedObject *object = [self insertNewObjectInManagedObjectContext:context];
    [object importValuesFromDictionary:dictionary];
    
    return object;
}

- (void)importValuesFromDictionary:(NSDictionary *)dictionary
{
    // Must be overridden by subclasses
}




@end
