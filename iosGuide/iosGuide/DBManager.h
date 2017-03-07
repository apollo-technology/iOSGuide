//
//  DBManager.h
//  iosGuide
//
//  Created by Elijah Cobb on 2/6/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <Parse/Parse.h>

@interface DBSection : NSObject
@property NSString *title;
@property NSString *content;
@property BOOL hasImage;
@property NSString *imageUrl;
@property UIImage *image;
@end

@interface DBTutorial : NSObject
@property NSString *title;
@property NSString *overview;
@property NSString *author;
@property NSString *app;
@property NSDate *date;
@property NSString *videoUrl;
@property BOOL hasVideo;
@property NSArray *sections;
@property BOOL isPro;
@end

@interface DBErrorManager : NSObject
+(void)handleError:(NSError *)error block:(void (^)())block handleError:(void (^)())buttonAction;
@end

@interface DBManager : NSObject
+(instancetype)data;
+(void)getTutorials:(void (^)(BOOL succeeded, NSError *error))block;
+(void)displayError:(NSError *)error delegate:(UIViewController *)delegate buttonAction:(void (^)())block;
@property NSDictionary *tutorials;
@property NSArray *apps;
@end
