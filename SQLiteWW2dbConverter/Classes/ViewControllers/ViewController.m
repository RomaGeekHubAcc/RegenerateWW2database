//
//  ViewController.m
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//


#import "FMDBManager.h"
#import "FMDB.h"
#import "SLItem.h"
#import "SLImage.h"
#import "SLVideo.h"
#import "SLPack.h"
#import "SLType.h"
#import "SLContentType.h"
#import "SLDimension.h"
#import "SLTag.h"
#import "SLItemToTag.h"

#import "ViewController.h"


typedef NS_ENUM(NSUInteger, NewDbType) {
    NewDbTypeBiographies = 16,
    NewDbTypeEventShort = 28,
    NewDbTypeEventLong = 12,
    NewDbTypePhoto = 17,
    NewDbTypeVideo = 19
};

typedef NS_ENUM(NSUInteger, NewDbContentType) {
    NewDbContentTypePerson = 19,
    NewDbContentTypeEventShort = 20,
    NewDbContentTypeEventLong = 21,
    NewDbContentTypePhoto = 23,
    NewDbContentTypeVideo = 24
};

@interface ViewController () {
    NSMutableArray *items;
    NSMutableArray *images;
    NSMutableArray *videos;
    NSMutableArray *contentPacks;
    NSMutableArray *types;
    NSMutableArray *dimensions;
    NSMutableArray *tags;
    NSMutableArray *itemsToTagRelationships;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)convertDB:(id)sender;
- (IBAction)deleteConvertedDB:(id)sender;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action methods

- (IBAction)convertDB:(id)sender {
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    [self deleteConvertedDB:nil];
    
    [self fetchDataFromOldDatabase];
    [self writeFetchedDataToNewDatabase];
    
    NSString *pathToDocuments = [Utilities getPathToDocumentsDirectory];
    NSString *message = [NSString stringWithFormat:@"Go to Finder, press CMD+SHIFT+G and insert pathStr to Documents Directory %@. Take %@ file", pathToDocuments, new_db_name];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Converting Finished!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    $l("\n\n path to Documents Directory  - >\n%@", pathToDocuments);
}

- (IBAction)deleteConvertedDB:(id)sender {
    [[FMDBManager sharedInstance] deleteDataBaseIfExist:new_db_name];
}


#pragma mark - Private methods

-(void) fetchDataFromOldDatabase {
    [[FMDBManager sharedInstance] openDataBaseWithName:ww2_db_name];
    
//    items = [self getAllItems];
//    images = [self getAllImageItems];
    videos = [self getAllVideos];
    contentPacks = [self getAllPacks];
//    types = [self getAllTypes];
//    dimensions = [self getAllDimensions];
//    tags = [self getAllTags];
    itemsToTagRelationships = [self getAllItemToTagRelationship];
    
    [[FMDBManager sharedInstance] closeDatabase];
}

-(void) writeFetchedDataToNewDatabase {
    if ([[FMDBManager sharedInstance] openDataBaseWithName:new_db_name]) {
        [self writePacks];
        [self writeItemsToTagsRelationship];
    }
    [[FMDBManager sharedInstance] closeDatabase];
}


-(void) writeItemsToTagsRelationship {
    for (SLItemToTag *itTagRel in itemsToTagRelationships) {
        NSString *executeUpdateStr = @"INSERT OR REPLACE INTO ITEMS_TO_TAGS_MAPPING VALUES (?, ?, ?)";
        BOOL isSuccess = [[FMDBManager sharedInstance].fmDataBase executeUpdate:executeUpdateStr, [NSNumber numberWithInteger:itTagRel.itemsToTagsMappingId], [NSNumber numberWithInteger:itTagRel.itemId], [NSNumber numberWithInteger:itTagRel.tagId]];
        
        if (!isSuccess) {
            $l("-- insert ITEMS_TO_TAGS_MAPPING error - > %@", [[FMDBManager sharedInstance].fmDataBase lastError]);
        }
    }
    $l("\n\n --- ITEMS_TO_TAGS_MAPPING inserting finished");
}

-(void) writePacks {
    for (SLPack *packItem in contentPacks) {
        NSString *executeUpdateStr = @"INSERT OR REPLACE INTO PACKS VALUES (?, ?)";
        BOOL isSuccess = [[FMDBManager sharedInstance].fmDataBase executeUpdate:executeUpdateStr, [NSNumber numberWithInteger:packItem.packId], packItem.title];
        
        if (!isSuccess) {
            $l("-- insert PACKS error - > %@", [[FMDBManager sharedInstance].fmDataBase lastError]);
        }
    }
    $l("\n\n --- PACKS inserting finished");
}

-(void) writeVideos {
    for (SLVideo *videoItem in videos) {
        BOOL isSuccess = [[FMDBManager sharedInstance].fmDataBase executeUpdate:@"INSERT OR REPLACE INTO VIDEOS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [NSNumber numberWithInteger:videoItem.videoId], videoItem.title, videoItem.cover, videoItem.thumbnailCover, videoItem.videoUrl, videoItem.position, videoItem.visibleOnMap, videoItem.itemId, videoItem.localization];
        
        if (!isSuccess) {
            $l("-- insert VIDEOS error - > %@", [[FMDBManager sharedInstance].fmDataBase lastError]);
        }
    }
     $l("\n\n --- VIDEOS inserting finished");
}


-(NSMutableArray *) getAllItems {
    
    NSInteger primaryKey;
    
    NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
    NSMutableIndexSet *toRemoveObjIndexes = [NSMutableIndexSet indexSet];
    
//    FMResultSet *resSet = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT COUNT(*) FROM ZIMPSYNCABLEOBJECT"];
//    int countRows = 0;
//    if ([resSet next]) {
//        countRows = [resSet intForColumnIndex:0];
//    }

    FMResultSet *rs = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT * FROM ZIMPSYNCABLEOBJECT"];
                                                                                            
    while ([rs next]) {
        SLItem *item = [[SLItem alloc] init];
        
        item.itemId = [rs intForColumn:z_pk];
        item.packId = [rs intForColumn:z_contentPack];
        item.title = [self getTitleWithFMResultSet:rs];
        
        primaryKey = [rs intForColumn:z_ent];
        
        if (primaryKey == 6) { //photo
            item.contentTypeId = 23;
            item.coverId = 28;
            item.typeId = NewDbTypePhoto;
            item.imageName = [rs stringForColumn:z_filename1];
            if (!item.imageName) {
                continue;
            }
        }
        if (primaryKey == 5) { // video
            item.contentTypeId = 24;
            item.coverId = 29;
            item.typeId = NewDbTypeVideo;
            if (![rs stringForColumn:z_posterFrameFileName]) {
                continue;
            }
        }
        item.timelineImage = [NSString stringWithFormat:@"timelineImage%ld.png", (long)item.itemId];
        
        item.itemShortText = [rs stringForColumn:z_summary];
        item.itemLongText = [rs stringForColumn:z_text];
        
        item.lastChangeDate = [self getRightDateFromDate:[rs dateForColumn:z_lastmodified]];
        
        
        item.dateFrom = [self getRightDateFromDate:[rs dateForColumn:z_dateFrom]];
        item.dateTo = [self getRightDateFromDate:[rs dateForColumn:z_dateTo]];
        item.date = item.dateFrom;
        
        
        
        if ([self getItemIdWhereDateWithResultSet:rs]) {
            item.indexOfObjectWhereDate = [self getItemIdWhereDateWithResultSet:rs];
        }
        
        
        item.includeTitle = item.itemShortText ? YES : NO;
        item.isMap = NO;
        item.visibleOnMapText = NO;
        item.ipadPriority = (NSInteger)75;
        item.iphoneVisible = NO;
        item.favorite = NO;
        
        if (primaryKey == 7) {
            NSInteger ztype = [rs intForColumn:z_type];
            if (ztype == 5442) {  // video
                item.contentTypeId = NewDbContentTypeEventShort;
                item.typeId = NewDbTypeEventShort;
            }
//            else if (!item.itemShortText) {
//                $l(@" --- item #%li skiped. reason: haven't itemShortText", item.itemId);
//                continue;
//            }
            
            if (ztype == 5443) {  // photo
                item.itemId = [self eventTypeWithLongText:item.itemLongText];
                if (item.itemId == NewDbTypeEventShort) {
                    item.contentTypeId = NewDbContentTypeEventShort;
                } else if (item.itemId == NewDbTypeEventLong) {
                    item.contentTypeId = NewDbContentTypeEventLong;
                }
            }
            
            if (ztype == 5445) {
                item.itemId = NewDbTypeEventLong;
                item.contentTypeId = NewDbContentTypeEventLong;
                
            }
            
            if (ztype == 5446) {
                // will be added later
            }
            
            if (ztype == 5447) {
                item.typeId = NewDbTypeBiographies;
                item.contentTypeId = NewDbContentTypePerson;
            }
            
            if (ztype == 5449) {
                item.typeId = NewDbTypeEventShort;
                item.contentTypeId = NewDbContentTypeEventShort;
            }
            item.coverId = [self coverIdForContentType:item.contentTypeId];
            
            if (!item.itemShortText) {
                $l(@"item #%li skiped. reason: item hasn't itemShortText", item.itemId);
                continue;
            }
        }
        
        
        [itemsArray addObject:item];
        $l(@".... item %ld added...", (long)item.itemId);
        
    }  // Finished while..
    
    
    // Adding date to items
    for (SLItem *item in itemsArray) {
        if (!item.date && item.indexOfObjectWhereDate) {
            SLItem *itemWithDate = itemsArray[item.indexOfObjectWhereDate];
            item.dateFrom = itemWithDate.dateFrom;
            item.dateTo = itemWithDate.dateTo;
            item.date = item.dateFrom;
            
            if (item.contentTypeId != 24 && item.contentTypeId != 23) {
                item.itemShortText = itemWithDate.itemShortText;
                item.itemLongText = itemWithDate.itemLongText;
            } else if (item.contentTypeId == 24 && !item.title){
                item.title = itemWithDate.title;
            }
            
            [toRemoveObjIndexes addIndex:[itemsArray indexOfObject:itemWithDate]];
        }
    }
    [toRemoveObjIndexes removeAllIndexes];
    
    for (SLItem *item in itemsArray) {
        if (!item.date) {
            [toRemoveObjIndexes addIndex:[itemsArray indexOfObject:item]];
        }
    }
    [itemsArray removeObjectsAtIndexes:toRemoveObjIndexes];
    [toRemoveObjIndexes removeAllIndexes];
    
    
    for (int i = 0; i < itemsArray.count; i++) {
        SLItem *item = itemsArray[i];
        $l(@"--item %d:\n  item.itemId = %ld, \n  item.typeId = %ld, \n  item.contenType = %ld, \n  item.coverId = %ld, \n  item.title = %@, \n  item.shortText = %@ \n  item.longText = %@ \n  item.date = %@\n\n", i, (long)item.itemId, (long)item.typeId, (long)item.contentTypeId, (long)item.coverId, item.title, item.itemShortText, item.itemLongText, item.date);
        if (item.contentTypeId == 29) {
            $l(@"--- !!! --item %d:\n  item.itemId = %ld, \n  item.contenType = %ld, \n item.coverId = %ld, \n  item.title = %@, \n  item.shortText = %@ \n  item.longText = %@ \n  item.date = %@\n\n", i, (long)item.itemId, (long)item.contentTypeId, (long)item.coverId, item.title, item.itemShortText, item.itemLongText, item.date);
        }
    }
    $l(@"\n\n -- Getting items finished, total count = %d", (int)itemsArray.count);
    return itemsArray;
}


-(NSMutableArray *) getAllImageItems {
    NSMutableArray *allImages = [[NSMutableArray alloc] init];
    
    int counter = 1;
    
    FMResultSet *rs = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT * FROM ZIMPSYNCABLEOBJECT"];
    while ([rs next]) {
        
        NSInteger primaryKey = [rs intForColumn:z_ent];
        if (primaryKey == 6) {  // Photo
            SLImage *imageItem = [[SLImage alloc] init];
            
            NSString *oldImageName = [rs stringForColumn:z_filename1];
            if (!oldImageName) {
                continue;
            }
            imageItem.oldImageName = oldImageName;
            imageItem.imageId = counter;
            imageItem.itemId = [rs intForColumn:z_pk];
            imageItem.title = [rs stringForColumn:z_name3];
            imageItem.position = 0;
            imageItem.hideWhiteBorder = 0;
            imageItem.visibleOnMap = 0;
            imageItem.thumbnailImage = [NSString stringWithFormat:@"thumbnailImage%ld.png", (long)imageItem.imageId];
            imageItem.fullImage = [NSString stringWithFormat:@"fullImage%ld.png", (long)imageItem.imageId];
            
            [imageItem generateFullAndThumnailImages];
            counter ++;
            
            [allImages addObject:imageItem];
            $l("--- imageItem %d added..", imageItem.itemId);
        }
        
    }
    $l(@"\n\n---Getting imageItems finished. Total count = %d", counter - 1);
    
    return allImages;
}

-(NSMutableArray *) getAllVideos {
    NSMutableArray *allVideos = [[NSMutableArray alloc] init];
    
    int counter = 1;
    
    FMResultSet *rs = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT * FROM ZIMPSYNCABLEOBJECT"];
    while ([rs next]) {
        NSInteger primaryKey = [rs intForColumn:z_ent];
        if (primaryKey == 5) { // Video
            SLVideo *videoItem = [[SLVideo alloc] init];
            NSString *videofileName = [rs stringForColumn:z_url];
            if  (!videofileName) {
                continue;
            }
            videoItem.videoCoverOldName = [rs stringForColumn:z_posterFrameFileName];
            
            videoItem.videoId = counter;
            videoItem.title = [rs stringForColumn:z_name2];
            videoItem.itemId = [rs intForColumn:z_pk];
            videoItem.position = 0;
            videoItem.localization = 0;
            videoItem.visibleOnMap = 0;
            videoItem.cover = [NSString stringWithFormat:@"videoCover%ld.png", (long)videoItem.videoId];
            videoItem.thumbnailCover = [NSString stringWithFormat:@"videoCoverThumbnail%ld.png", (long)videoItem.videoId];
            videoItem.videoUrl = [rs stringForColumn:z_url];
            
            if (![videoItem generateVideoCovers]) {
                $l(" --- video without cover :/ :'(");
            }
            counter ++;
            
            [allVideos addObject:videoItem];
            $l("--- videoItem %d added..", videoItem.itemId);
        }
    }
    $l(@"\n\n---Getting videoItems finished. Total count = %d", counter - 1);
    
    return allVideos;
}


-(NSMutableArray *) getAllPacks {
    NSMutableArray *allPacks  = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT * FROM ZIMPSYNCABLEOBJECT"];
    int counter = 1;
    while ([rs next]) {
        NSString *packTitle = [rs stringForColumn:z_name1];
        if (packTitle) {
            SLPack *packItem = [[SLPack alloc] init];
            packItem.title = packTitle;
            if ([packTitle isEqualToString:@"World War II Day by Day"]) {
                packItem.packId = 43;
            } else if ([packTitle isEqualToString:@"Pacific War Day by Day"]) {
                packItem.packId = 44;
            }
            
            counter ++;
            [allPacks addObject:packItem];
            $l("--- packItem %d added..", packItem.packId);
        }
    }
    $l(@"\n\n---Getting packItems finished. Total count = %d", counter - 1);
    
    return allPacks;
}


-(NSMutableArray *) getAllDimensions {
    NSMutableArray *allDimensions = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT * FROM ZIMPSYNCABLEOBJECT"];
    while ([rs next]) {
        if ([rs intForColumn:z_ent] != 19) {  // dimensions
            continue;
        }
        
        SLDimension *dimensionItem = [[SLDimension alloc] init];
        dimensionItem.dimensionId = [rs intForColumn:z_pk];
        dimensionItem.title = [rs stringForColumn:z_name8];
        dimensionItem.isFilter = [rs boolForColumn:z_isFilter];
        dimensionItem.color = 0;
        
        [allDimensions addObject:dimensionItem];
    }
    $l(@"\n\n---Getting dimensions finished. Total count = %d", allDimensions.count);
    
    for (SLDimension *dItem in allDimensions) {
        $l(@"\n\n dimensionItem.dimensionId = %d, \ndimensionItem.title = %@, \ndimensionItem.isFilter = %d", dItem.dimensionId, dItem.title, dItem.isFilter);
    }
    
    
    return allDimensions;
}

-(NSMutableArray *) getAllTags {
    NSMutableArray *allTags = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT * FROM ZIMPSYNCABLEOBJECT"];
    while ([rs next]) {
        if ([rs intForColumn:z_ent] != 18) {  // Tag
            continue;
        }
        SLTag *tagItem = [[SLTag alloc] init];
        tagItem.tagId = [rs intForColumn:z_pk];
        tagItem.title = [rs stringForColumn:z_name7];
        tagItem.latitude = [rs doubleForColumn:z_latitude];
        tagItem.longitude = [rs doubleForColumn:z_longtitude];
        tagItem.radius = [rs doubleForColumn:z_radius];
        tagItem.dimensionId = [rs intForColumn:z_dimension];
        
        tagItem.latitude = tagItem.latitude ? tagItem.latitude : 0;
        tagItem.longitude = tagItem.longitude ? tagItem.longitude : 0;
        tagItem.radius = tagItem.radius ? tagItem.radius : 0;
        
        if (!tagItem.dimensionId) {
            $l(@" --- tagItem %@ skiped. reason: haven't dimensionId", tagItem.title);
            continue;
        }
        
        
        [allTags addObject:tagItem];
    }
    $l(@"\n\n---Getting tags finished. Total count = %d", allTags.count);
    
    for (SLTag *tagItem in allTags) {
        $l(@"\n\ntagItem.tagId = %d \n  tagItem.title = %@ \n  tagItem.latitude = %f \n  tagItem.longitude = %f \n  tagItem.radius = %f \n  tagItem.dimensionId = %d", tagItem.tagId, tagItem.title, tagItem.latitude, tagItem.longitude, tagItem.radius, tagItem.dimensionId);
    }
    
    return allTags;
}


-(NSMutableArray *) getAllTypes {
    NSMutableArray *allTypes = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT * FROM ZIMPSYNCABLEOBJECT"];
    while ([rs next]) {
        NSInteger ent = [rs intForColumn:z_ent];
        if (ent == 21) {
            SLType *typeItem = [[SLType alloc] init];
            
            typeItem.title = [rs stringForColumn:z_name10];
            typeItem.zeditoriconnum = [rs intForColumn:z_editorIconNum];
            switch (typeItem.typeId) {
                case 5441:                       // айтемів цього типу в базі нема
                    typeItem.typeId = 5441;
                    typeItem.contenTypeId = 100; // temp
                    break;
                case 5442:
                    typeItem.typeId = NewDbTypeVideo;
                    typeItem.contenTypeId = 24;  // VIDEO
                     break;
                case 5443:
                    typeItem.typeId = NewDbTypePhoto;
                    typeItem.contenTypeId = 23;  // PHOTO
                    break;
                case 5444:
#warning вияснити з цим типом
                    typeItem.typeId = 5444;
                    typeItem.contenTypeId = 101; // temp
                    break;
                case 5445:
#warning розібратись із цим типом і з показ фото якщо є
                    typeItem.typeId = NewDbTypeEventLong;
                    typeItem.contenTypeId = 21;  // EVENT(long)
                    break;
                case 5446:
#warning вияснити з цим типом
                    typeItem.typeId = 5446;
                    typeItem.contenTypeId = 102; // temp
                    break;
                case 5447:
                    typeItem.typeId = NewDbTypeBiographies;
                    typeItem.contenTypeId = 19;  // Person
                    break;
                case 5448:                       // айтемів цього типу в базі нема
                    typeItem.typeId = 5448;
                    typeItem.contenTypeId = 104; // temp
                    break;
                case 5449:
                    typeItem.typeId = NewDbTypeEventShort;
                    typeItem.contenTypeId = NewDbContentTypeEventShort;  // EVENT(short)
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    return allTypes;
}


-(NSMutableArray *) getAllItemToTagRelationship {
    NSMutableArray *itemsToTagsArr = [[NSMutableArray alloc] init];
    unsigned int counter = 1;
    
    FMResultSet *rs = [[FMDBManager sharedInstance].fmDataBase executeQuery:@"SELECT * FROM Z_7TAGS"];
    while ([rs next]) {
        SLItemToTag *itemToTag = [[SLItemToTag alloc] init];
        itemToTag.itemsToTagsMappingId = counter;
        itemToTag.itemId =[rs intForColumn:z_7itemId];
        itemToTag.tagId = [rs intForColumn:z_7tagId];
        
        [itemsToTagsArr addObject:itemToTag];
        
        counter ++;
    }
    $l(@"\n\n---Getting ItemsToTagRelationship finished. Total count = %d", itemsToTagsArr.count);
    
    return itemsToTagsArr;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-(NSInteger) coverIdForContentType:(NewDbContentType)contentType {
    if (contentType == NewDbContentTypeEventShort) {
        NSArray *coverIds = @[@20, @21, @22];
        int index = arc4random()%3;
        NSNumber *coverId = coverIds[index];
        return [coverId integerValue];
    }
    if (contentType == NewDbContentTypeEventLong) {
        NSArray *coverIds = @[@23, @24, @25, @26];
        int index = arc4random()%4;
        NSNumber *coverId = coverIds[index];
        return [coverId integerValue];
    }
    if (contentType == NewDbContentTypePerson) {
        return 19;
    }
    
    return 0;
}

-(NewDbType) eventTypeWithLongText:(NSString *)lText {
    if (lText.length > 300) {
        return NewDbTypeEventShort;
    }
    return NewDbTypeEventLong;
}

-(NSInteger) getItemIdWhereDateWithResultSet:(FMResultSet *)resSet {
    if ([resSet intForColumn:z_item]) {
        return [resSet intForColumn:z_item];
    } else if ([resSet intForColumn:z_item1]) {
        return [resSet intForColumn:z_item1];
    }
    return 0;
}

-(NSDate *) getRightDateFromDate:(NSDate *)gotDate {
    if (!gotDate) {
        return nil;
    }
    NSTimeInterval tInteval = [gotDate timeIntervalSince1970];
    NSDate *rightDate = [NSDate dateWithTimeIntervalSinceReferenceDate:tInteval];
    
    return rightDate;
}


-(NSString *) getTitleWithFMResultSet:(FMResultSet *)rs {
    NSArray *keys = @[z_name, z_name1, z_name2, z_name3,  z_name4, z_name5, z_name6, z_name7, z_name8, z_name9, z_name10, z_title];
    NSString *title = @"";
    NSString *enter = @"\n";
    
    for (int i = 0; i < keys.count; i++) {
        if ([rs stringForColumn:keys[i]]) {
            if (title.length) {
                title = [title stringByAppendingString:enter];
            }
            title = [title stringByAppendingString:[rs stringForColumn:keys[i]]];
        }
    }
    
    return title;
}

@end
