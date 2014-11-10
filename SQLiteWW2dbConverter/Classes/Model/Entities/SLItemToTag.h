//
//  SLItemToTag.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 11/5/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLItemToTag : NSObject

@property (nonatomic, assign) NSInteger itemsToTagsMappingId;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) NSInteger tagId;

@end
