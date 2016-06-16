//
//  SystemSoundManager.h
//  AlertSound
//
//  Created by LV on 16/6/16.
//  Copyright © 2016年 lvhongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemSoundManager : NSObject

+ (instancetype)defaultCenter;
- (NSMutableArray *)getSoundData;
- (void)playWithSound:(UInt32)soundID;

@end
