//
//  PBSExperimentExecutor.m
//  BusyStruct
//
//  Created by 宋瀚章 on 2020/10/20.
//

#import "PBSExperimentExecutor.h"
#import "PBSMutableDictionary.h"

@implementation PBSExperimentExecutor

- (void)doParallelWriteOnDifferentEntriesTest {
    int rangeSize = 100;
    int threadNum = 10;
    
    NSMutableDictionary *parallelDict = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < rangeSize * threadNum; i++) {
        parallelDict[@(i)] = @(-1);
    }
    
    dispatch_queue_t parallelWriteQueue = dispatch_queue_create("parallelWriteQueue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int threadId = 0; threadId < threadNum; threadId ++) {
        NSRange range = NSMakeRange(threadId * rangeSize, rangeSize);
        dispatch_async(parallelWriteQueue, ^{
            [self _write100Entries:parallelDict withEntryRange:range];
        });
    }
    
    dispatch_barrier_sync(parallelWriteQueue, ^{
        NSLog(@"finish writing data, do checking:\n");
        
        for (int i = 0; i < threadNum * rangeSize; i++) {
            NSNumber *key = @(i);
            if (((NSNumber *)parallelDict[key]).intValue != i) {
                NSLog(@"fail: %@", key);
                break;
            }
        }
        
        NSLog(@"success");
    });
}

- (void)_write100Entries:(NSMutableDictionary *)parallelDict withEntryRange:(NSRange)range {
    NSLog(@"%lu start", range.location);
    for (int i = 0; i < range.length; i++) {
        parallelDict[@(i + range.location)] = @(i + range.location);
    }
    NSLog(@"%lu finish", range.location);
}

@end
