//
//  InitialVC.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/7/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "InitialVC.h"
#import "DBManager.h"

@interface InitialVC (){
    BOOL doneDownloading;
    BOOL doneAnimating;
    IBOutlet UIActivityIndicatorView *loaderView;
    IBOutlet UIImageView *iconImageView;
    UIImageView *cirleView;
}

@end

@implementation InitialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self animateEverything];
    [self checkIfDone];
    [[PFUser currentUser] fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        [DBErrorManager handleError:error block:^{
            [DBManager getTutorials:^(BOOL succeeded, NSError *error) {
                [DBErrorManager handleError:error block:^{
                    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig * _Nullable config, NSError * _Nullable error) {
                        [DBErrorManager handleError:error block:^{
                            doneDownloading = YES;
                        } handleError:^{
                            [self seagueToSettings];
                        }];
                    }];
                } handleError:^{
                    [self seagueToSettings];
                }];
            }];
        } handleError:^{
            [PFUser logOut];
            UIViewController *homeVC = [self.storyboard instantiateInitialViewController];
            [self presentViewController:homeVC animated:YES completion:nil];
        }];
    }];
}


-(void)animateEverything{
    cirleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"launchCircle.png"]];
    cirleView.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 160, 160);
    cirleView.center = iconImageView.center;
    cirleView.alpha = 0;
    [self.view addSubview:cirleView];
    [self.view sendSubviewToBack:cirleView];
    self.view.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.75 animations:^{
        cirleView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            CGRect rect = cirleView.frame;
            rect.size.width = self.view.frame.size.height*1.25;
            rect.size.height = self.view.frame.size.height*1.25;
            cirleView.frame = rect;
            cirleView.center = iconImageView.center;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.25 initialSpringVelocity:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect rect = cirleView.frame;
                rect.size.width = 170;
                rect.size.height = 170;
                cirleView.frame = rect;
                cirleView.center = iconImageView.center;
            } completion:^(BOOL finished) {
                doneAnimating = YES;
                double delayInSeconds = 1;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    // do something
                    
                    [UIView animateWithDuration:1 animations:^{
                        loaderView.alpha = 1;
                    }];
                });
            }];
        }];
    }];
}

-(void)checkIfDone{
    if (doneAnimating && doneDownloading) {
        [self segueHome];
    } else {
        [self performSelector:@selector(checkIfDone) withObject:nil afterDelay:0.5];
    }
}

-(void)segueHome{
    UIViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self presentViewController:homeVC animated:YES completion:^{
        
    }];
}

-(void)seagueToSettings{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
