//
//  CDVideos.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDItems;

@interface CDVideos : NSManagedObject

@property (nonatomic, retain) NSString * cover;
@property (nonatomic, retain) NSNumber * itemId;
@property (nonatomic, retain) NSNumber * localization;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * videoId;
@property (nonatomic, retain) NSString * videoUrl;
@property (nonatomic, retain) NSNumber * visibleOnMap;
@property (nonatomic, retain) CDItems *items;

@end
