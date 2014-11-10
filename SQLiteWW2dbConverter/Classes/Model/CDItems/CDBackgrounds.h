//
//  CDBackgrounds.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDBackgrounds : NSManagedObject

@property (nonatomic, retain) NSNumber * backgroundId;
@property (nonatomic, retain) NSString * path;

@end
