//
//  VAMacroUtils.h
// 
//
//  Created by V on 12/12/2015.
//  Copyright © 2015 V. All rights reserved.
//

#ifndef VAMacroUtils_h
#define VAMacroUtils_h

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

/* Versatile*/

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define VALog(object)     NSLog(@"%@", object)
#define VALogError(error) NSLog(@"Error: %@\n", error)
#define VALogSelector     NSLog(@"\"%@\" selector: \"%@\"", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#define VALogWarning      NSLog(@"%@: Warning to implement %@ in subclass.", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#define VAAssert          NSAssert(NO, @"%@: Expected to implement %@ in subclass.", NSStringFromClass([self class]), NSStringFromSelector(_cmd))

#define VASizeMake(length)         CGSizeMake(length, length)
#define VARectMake(x, y, size)     CGRectMake(x, y, size.width, size.height)
#define VASquareMake(x, y, length) CGRectMake(x, y, length, length)
#define VAEdgeInsetsMake(length)   UIEdgeInsetsMake(length, length, length, length);

#define VIEW_BOUNDS self.view.bounds
#define VIEW_SIZE   self.view.bounds.size
#define VIEW_WIDTH  CGRectGetWidth(VIEW_BOUNDS)
#define VIEW_HEIGHT CGRectGetHeight(VIEW_BOUNDS)

#define STATUS_BAR_HEIGHT     [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIGATION_BAR_HEIGHT self.navigationController.navigationBar.frame.size.height
#define TOP_BARS_HEIGHT       STATUS_BAR_HEIGHT+NAVIGATION_BAR_HEIGHT

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_SIZE   [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define DIRECTORY_DOCUMENT [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] absoluteString]

/* Vagrant*/

#define UMENG_APP_KEY     @"568f144ae0f55a7954002658"
#define APP_MASTER_SECRET @"kgz5lcohwed2orwqqekqycceheqtmqay"

#define TABLE_CELL              @"VATableViewCell"
#define COLLECTION_CELL         @"VACollectionViewCell"
#define WORK_CELL               @"VAWorkTableViewCell"
#define ARTIST_CELL             @"VAArtistTableViewCell"
#define SALE_CELL               @"VASaleCollectionViewCell"
#define DISCOVER_CELL           @"VADiscoverTableViewCell"
#define USER_COLLECTION_CELL    @"VAUserCollectionViewCell"
#define USER_ARTICLE_CELL       @"VAUserArticleTableViewCell"
#define USER_HOST_WORK_CELL     @"VAUserHostWorkTableViewCell"
#define USER_HOST_DISCOVER_CELL @"VAUserHostDiscoverTableViewCell"

#define CELL_TYPE_WORK     @"1"
#define CELL_TYPE_DISCOVER @"2"

#define WORK_RAHMEN        @"workRahmen"
#define USER_AVATAR_RAHMEN @"userAvatarRahmen"

#define VESSEL_BUTTON_WIDTH VIEW_WIDTH*0.27
#define VESSEL_TITLE_HEIGHT VIEW_HEIGHT*0.05
#define VESSEL_VIEW_HEIGHT  VIEW_HEIGHT*0.95

#define DEFAULT_ROW_HEIGHT_VIA_PERCENTAGE_OF_(length)  length*0.04
#define WORK_ROW_HEIGHT_VIA_PERCENTAGE_OF_(length)     length*0.6
#define ARTIST_ROW_HEIGHT_VIA_PERCENTAGE_OF_(length)   length*0.3
#define SALE_ITEM_HEIGHT_VIA_PERCENTAGE_OF_(length)    length*0.49
#define SALE_ITEM_SPACING_VIA_PERCENTAGE_OF_(length)   length*0.01
#define DISCOVER_ROW_HEIGHT_VIA_PERCENTAGE_OF_(length) length*0.45

#define USER_HOST_WORK_ROW_HEIGHT_VIA_PERCENTAGE_OF_(length)       length*0.51
#define USER_HOST_DISCOVER_ROW_HEIGHT_VIA_PERCENTAGE_OF_(length)   length*0.345
#define USER_COLLECTION_ITEM_WIDTH_VIA_PERCENTAGE_OF_(length)      length*0.46
#define USER_COLLECTION_ITEM_HEIGHT_VIA_PERCENTAGE_OF_(length)     length*0.8
#define USER_COLLECTION_ITEM_EDGE_INSET_VIA_PERCENTAGE_OF_(length) length*0.023
#define USER_ARTICLE_ROW_HEIGHT_VIA_PERCENTAGE_OF_(length)         length*0.36

#define HOT_URL_STRING        @"http://v1.artandus.com/index/hot"
#define ARTIST_URL_STRING     @"http://v1.artandus.com/index/artist"
#define SALE_URL_STRING       @"http://v1.artandus.com/index/sale"
#define READ_URL_STRING       @"http://v1.artandus.com/discover/read"
#define PERSONAGE_URL_STRING  @"http://v1.artandus.com/discover/personage"
#define EXHIBIT_URL_STRING    @"http://v1.artandus.com/discover/exhibit"
#define USER_URL_STRING       @"http://v1.artandus.com/user"                // Append path: row_id
#define ART_URL_STRING        @"http://v1.artandus.com/artid"               // Append path: row_id
#define ARTICLE_URL_STRING    @"http://v1.artandus.com/article"             // Append path: row_id
#define COLLECTION_URL_STRING @"http://v1.artandus.com/collection"          // Append path: collection_id?last_id=0

#define WORK_URL_STRING             @"http://work.artandus.com"                   // Append path: pid
#define HEAD_URL_STRING             @"http://head.artandus.com"                   // Append path: uid
#define NEWS_URL_STRING             @"http://news.artandus.com"                   // Append path: pid
#define COVER_URL_STRING            @"http://cover.artandus.com"                  // Append path: cover
#define COLLECTION_COVER_URL_STRING @"http://collection.artandus.com"             // Append path: cover_id

#endif /* VAMacroUtils_h */
