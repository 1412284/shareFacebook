//
//  ViewController.m
//  demoShareVideoFacebook
//
//  Created by CPU11197-local on 4/5/18.
//  Copyright © 2018 CPU11197-local. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ViewController ()

@end

@implementation ViewController
NSURL *videoURL;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShareImg:(id)sender {
    if(![FBSDKAccessToken currentAccessToken])
    {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc]init];
        [loginManager logOut];  //very important line for login to work
        [loginManager logInWithPublishPermissions:@[@"publish_actions"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                NSLog(@"Process error");
            } else if (result.isCancelled) {
                NSLog(@"Cancelled");
            } else {
                NSLog(@"Logged in");
                [self sharePhotoOnFacebook];
            }
            
        }];
    }
    else {
        [self sharePhotoOnFacebook];
        
    }
    
}
- (IBAction)btnShareVideo:(id)sender {
    if(![FBSDKAccessToken currentAccessToken])
    {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc]init];
         [loginManager logOut];  //very important line for login to work
        [loginManager logInWithPublishPermissions:@[@"publish_actions"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                NSLog(@"Process error");
            } else if (result.isCancelled) {
                NSLog(@"Cancelled");
            } else {
                NSLog(@"Logged in");
                [self shareVideoOnFacebook];
            }
            
        }];
    }
    else {
        [self shareVideoOnFacebook];
        
    }
}
- (void) sharePhotoOnFacebook{
    UIImage *img = [UIImage imageNamed:@"iconkara.png"];
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = img;
    photo.userGenerated = YES;
    photo.caption = @"Add Your caption";
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];
}
- (void) shareVideoOnFacebook {
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"clip3" ofType:@"mp4"];
    videoURL =[NSURL fileURLWithPath:fullPath];
    FBSDKShareVideo *video = [[FBSDKShareVideo alloc] init];
    video.videoURL = videoURL;
    FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
    content.video = video;
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
}


@end
