//
//  SLVideo.m
//  Parallaxer
//
//  Created by s.leluk on 17.09.12.
//  Copyright 2012 Mozi Development. All rights reserved.
//




#import "PrefixHeader.pch"

#import "SLVideo.h"


static NSString * const videothumbnailFolderName = @"videothumbnail";
static NSString * const videocoverFolderName = @"videocovers";


@interface SLVideo () 

@end


@implementation SLVideo

@synthesize title, itemId, videoId, position, videoUrl, visibleOnMap, cover, thumbnailCover, localization, videoCoverOldName;


#pragma mark - Instance initialization

-(id) init {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	return self;
}




#pragma mark - Interface methods

-(BOOL) generateVideoCovers {
    NSString *videoThumbnailName = [NSString stringWithFormat:@"thumb_%@", self.videoCoverOldName];
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:videoThumbnailName
                                                           ofType:nil];
    
    NSString *copyFilePath = [Utilities getPathForFolder:videothumbnailFolderName];
    copyFilePath = [copyFilePath stringByAppendingPathComponent:self.thumbnailCover];
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
        $l(@"copy thumbnailImage error -> %@", error);
        return NO;
    } else {
        $l(@"---thumbnailImage%d added", (int)self.itemId);
    }
    
    NSString *videoCoverName = [NSString stringWithFormat:@"jfull_%@", self.videoCoverOldName];
    videoCoverName = [Utilities replacePathExtentionTo:@"jpg" forString:videoCoverName];
    
    pathToFile = [[NSBundle mainBundle] pathForResource:videoCoverName
                                                           ofType:nil];
    copyFilePath = [Utilities getPathForFolder:videocoverFolderName];
    copyFilePath = [copyFilePath stringByAppendingPathComponent:self.cover];
    
    if (!pathToFile || !copyFilePath) {
        return NO;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:copyFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:copyFilePath
                                                   error:nil];
    }
    isSuccess = [[NSFileManager defaultManager] copyItemAtPath:pathToFile
                                                        toPath:copyFilePath
                                                         error:&error];
    if (!isSuccess) {
        $l(@"copy vodecoverImage error -> %@", error);
        return NO;
    } else {
        $l(@"---videoCover%d added", (int)self.itemId);
    }
    return YES;
}


#pragma mark - Action methods


#pragma mark - Private methods


#pragma mark - Notification observers


#pragma mark - Delegated methods

@end
