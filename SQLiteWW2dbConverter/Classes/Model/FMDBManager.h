//
//  FMDBManager.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//


#import "FMDB.h"


@interface FMDBManager : NSObject

@property (strong, nonatomic) FMDatabase *fmDataBase;

+(instancetype) sharedInstance;

-(BOOL) openDataBaseWithName:(NSString *)dbFileName;
-(BOOL) closeDatabase;
-(BOOL) deleteDataBaseIfExist:(NSString *)dbFileName;

@end
