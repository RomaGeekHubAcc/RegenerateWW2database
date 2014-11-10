//
//  FMDBManager.m
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import "PrefixHeader.pch"

#import "FMDBManager.h"


//@interface FMDBManager () {
//    FMDatabase *fmDataBase;
//}
//
//@end

@implementation FMDBManager


#pragma mark - Instance initialization

+(instancetype) sharedInstance {
    static FMDBManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[FMDBManager alloc]init];
    });
    
    return __sharedInstance;
}


#pragma mark - Interface methods

-(BOOL) deleteDataBaseIfExist:(NSString *)dbFileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *databasePath = [self getPathToDataBase:dbFileName];
    
    BOOL dataBaseExist = [fileManager fileExistsAtPath:databasePath];
    if  (dataBaseExist) {
        NSError *error = nil;
        BOOL success = [fileManager removeItemAtPath:databasePath
                                               error:&error];
        if (!success) {
            $l(@"Error: %@", [error localizedDescription]);
            return NO;
        }
    }
    return YES;
}

-(BOOL) openDataBaseWithName:(NSString *)dbFileName {
    if (self.fmDataBase) {
        [self closeDatabase];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *databasePath = [self getPathToDataBase:dbFileName];
    
    BOOL dataBaseExist = [fileManager fileExistsAtPath:databasePath];
    if (!dataBaseExist) {
        NSString *defaultDatabasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFileName];
        [fileManager copyItemAtPath:defaultDatabasePath toPath:databasePath error:nil];
    }
    
    self.fmDataBase = [FMDatabase databaseWithPath:databasePath];
    
    if (![self.fmDataBase open]) {
        self.fmDataBase = nil;
        $l(@"Error! Failed to open data base");
        return NO;
    }
    return YES;
}

-(BOOL) closeDatabase {
    if (![self.fmDataBase close]) {
        $l(@" --- > Якась дивна хрєнь! База не закрилась ...");
        return  NO;
    }
    return YES;
}


#pragma mark - Private methods

-(NSString *)getPathToDataBase:(NSString *)dbFileName {
    NSString *documentDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [documentDirectoryPath stringByAppendingPathComponent:dbFileName];
}





@end
