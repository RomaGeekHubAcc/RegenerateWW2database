//
//  CDContentTypes.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDTypes;

@interface CDContentTypes : NSManagedObject

@property (nonatomic, retain) NSNumber * contentId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) CDTypes *types;

@end
