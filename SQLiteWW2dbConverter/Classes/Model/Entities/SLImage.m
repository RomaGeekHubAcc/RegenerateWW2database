//
//  SLImage.m
//  Parallaxer
//
//  Created by s.leluk on 17.09.12.
//  Copyright 2012 Mozi Development. All rights reserved.
//

#import "PrefixHeader.pch"
#import "Utilities.h"

#import "SLImage.h"


static NSString * const fullImagesfolderName = @"full";
static NSString * const thumbnailImagesfolderName = @"thumbnail";


@interface SLImage () 

@end


@implementation SLImage

@synthesize itemId, imageId, position, visibleOnMap, hideWhiteBorder, title, thumbnailImage, fullImage, oldImageName;


#pragma mark - Instance initialization

-(id) init {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	return self;
}


#pragma mark - Interface methods

-(BOOL) generateFullAndThumnailImages {
    if (![self generateFullImage]) {
        return NO;
    }
    if (![self generateThumnailImage]) {
        //
    }
    
    return YES;
}


-(BOOL) generateFullImage {
    NSString *fullImageName = [NSString stringWithFormat:@"jfull_%@", self.oldImageName];
    fullImageName = [Utilities replacePathExtentionTo:@"jpg" forString:fullImageName];
    
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:fullImageName
                                                           ofType:nil];
    NSString *copyFilePath = [Utilities getPathForFolder:fullImagesfolderName];
    copyFilePath = [copyFilePath stringByAppendingPathComponent: self.fullImage];
    
    if (!pathToFile || !copyFilePath) {
        return NO;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:copyFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:copyFilePath
                                                   error:nil];
    }
    
    NSError *error = nil;
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:pathToFile
                                                        toPath:copyFilePath
                                                         error:&error];
    
    if (!isSuccess) {
        $l(@"copy image error -> %@", error);
        return NO;
    } else {
        $l(@"---fullImage%d added", (int)self.imageId);
    }
    
    return YES;
}

-(BOOL) generateThumnailImage {
    NSString *thumbnailImageName = [NSString stringWithFormat:@"thumb_%@", self.oldImageName];
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:thumbnailImageName
                                                           ofType:nil];
    NSString *copyFilePath = [Utilities getPathForFolder:thumbnailImagesfolderName];
    copyFilePath = [copyFilePath stringByAppendingPathComponent: self.thumbnailImage];
    if (!pathToFile) {
        pathToFile = [Utilities getPathForFolder:@"thumb-copy"];
        pathToFile = [pathToFile stringByAppendingPathComponent:self.fullImage];
        BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:pathToFile];
        if (!fileExist) {
            return NO;
        }
        
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:copyFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:copyFilePath
                                                   error:nil];
    }
    NSError *error = nil;
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:pathToFile
                                                             toPath:copyFilePath
                                                              error:&error];
    if (!isSuccess) {
        $l(@"copy image error -> %@", error);
        return NO;
    } else {
        $l(@"---thumbnailImage%d added", (int)self.imageId);
    }
    
    return YES;
}


#pragma mark - Action methods


#pragma mark - Private methods


#pragma mark - Notification observers


#pragma mark - Delegated methods

@end
