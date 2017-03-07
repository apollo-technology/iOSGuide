//
//  DBManager.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/6/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+(instancetype)data{
    static DBManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

+(void)displayError:(NSError *)error delegate:(UIViewController *)delegate buttonAction:(void (^)())block{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
    }]];
    [delegate presentViewController:alertController animated:YES completion:nil];
}

+(UIImage *)getImageForKey:(NSString *)string{
    NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:string];
    return [UIImage imageWithData:data];
    
}

+(BOOL)imageIsSaved:(NSString *)string{
    if ([[NSUserDefaults standardUserDefaults] dataForKey:string]) {
        return YES;
    } else {
        return NO;
    }
}

+(void)getTutorials:(void (^)(BOOL succeeded, NSError *error))block{
    PFQuery *query = [PFQuery queryWithClassName:@"tutorials"];
    [query addAscendingOrder:@"app"];
    [query addAscendingOrder:@"title"];
    [query setLimit:1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            if (block) {
                block(NO,error);
            }
        } else {
            NSMutableDictionary *tutorialsTemp = [NSMutableDictionary new];
            for (PFObject *object in objects) {
                
                DBTutorial *tutorial = [DBTutorial new];
                tutorial.title = object[@"title"];
                tutorial.overview = object[@"overview"];
                tutorial.hasVideo = [object[@"hasVideo"] boolValue];
                tutorial.isPro = [object[@"isPro"] boolValue];
                tutorial.videoUrl = object[@"videoUrl"];
                tutorial.author = object[@"author"];
                tutorial.date = object.updatedAt;
                tutorial.app = object[@"app"];
                
                NSMutableArray *sectionsTemp = [NSMutableArray new];
                for (NSDictionary *sectionsData in object[@"sections"]) {
                    DBSection *section = [DBSection new];
                    section.title = sectionsData[@"title"];
                    section.content = sectionsData[@"content"];
                    section.hasImage = [sectionsData[@"hasImage"] boolValue];
                    section.imageUrl = sectionsData[@"image"];
                    
                    if (section.hasImage) {
                        if ([self imageIsSaved:sectionsData[@"image"]]) {
                            section.image = [self getImageForKey:sectionsData[@"image"]];
                        } else {
                            
                        }
                    }
                    
                    [sectionsTemp addObject:section];
                }
                tutorial.sections = sectionsTemp;
                
                if (tutorialsTemp[object[@"app"]]) {
                    NSMutableArray *app = [tutorialsTemp objectForKey:object[@"app"]];
                    [app addObject:tutorial];
                    [tutorialsTemp setObject:app forKey:object[@"app"]];
                } else {
                    NSMutableArray *app = [NSMutableArray new];
                    [app addObject:tutorial];
                    [tutorialsTemp setObject:app forKey:object[@"app"]];
                }
            }
            [[DBManager data] setTutorials:tutorialsTemp];
            [[DBManager data] setApps:[tutorialsTemp.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
            if (block) {
                block(YES,nil);
            }
        }
    }];
}

@end

@implementation DBErrorManager

+(void)handleError:(NSError *)error block:(void (^)())block handleError:(void (^)())buttonAction{
    if (error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (buttonAction) {
                buttonAction();
            }
        }]];
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:^{
            
        }];
    } else {
        if (block) {
            block();
        }
    }
}

@end


@implementation DBTutorial
@end

@implementation DBSection
@end
