//
//  SystemSoundManager.m
//  AlertSound
//
//  Created by LV on 16/6/16.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import "SystemSoundManager.h"
#import "SystemSoundInfo.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SystemSoundManager ()
@property (nonatomic, strong) NSMutableArray * soundData;
@end

@implementation SystemSoundManager
static SystemSoundManager * _systemSoundObj;


#pragma mark - Public Method
+ (instancetype)defaultCenter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _systemSoundObj = [[SystemSoundManager alloc] init];
    });
    return _systemSoundObj;
}

- (NSMutableArray *)getSoundData
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSURL * _soundDataURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds"];
    NSDirectoryEnumerator * _soundDirectoryEnum = [fileManager enumeratorAtURL:_soundDataURL
                                                    includingPropertiesForKeys:@[NSURLIsDirectoryKey]
                                                                       options:0
                                                                  errorHandler:^BOOL(NSURL * _Nonnull url, NSError * _Nonnull error) {
                                                                      return YES;
                                                                  }];
    NSURL * soundFileURL;
    while (soundFileURL = [_soundDirectoryEnum nextObject]) {
        
        NSNumber * isDirectory = nil;
        if (![soundFileURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil]) {
            
        }else if (![isDirectory boolValue]) {
            
            SystemSoundID soundID ;
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundFileURL), &soundID);
            
            SystemSoundInfo * dataInfo = [[SystemSoundInfo alloc] init];
            dataInfo.soundID   = soundID;
            dataInfo.soundUrl  = soundFileURL;
            dataInfo.soundName = soundFileURL.lastPathComponent;
            [_soundData addObject:dataInfo];
        }
    }
    return _soundData;
}

- (void)playWithSound:(UInt32)soundID
{
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - Private Method
- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    _soundData = [NSMutableArray array];
    return self;
}

@end
