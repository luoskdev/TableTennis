//
//  RecordDAO.h
//  台球记录
//
//  Created by Luo Shikai on 14-3-12.
//  Copyright (c) 2014年 isnailbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"

@interface RecordDAO : NSObject

+ (RecordDAO *)sharedManager;

- (NSString *)applicationDocumentsDirectoryFile;
- (void)createdEditableCopyOfDatabaseIfNeeded;

- (int)create:(Record *)model;
- (int)remove:(Record *)model;
- (int)modify:(Record *)model;
- (NSMutableArray *)findAll;
- (Record *)findById:(Record *)model;

@end
