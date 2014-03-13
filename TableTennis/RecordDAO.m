//
//  RecordDAO.m
//  台球记录
//
//  Created by Luo Shikai on 14-3-12.
//  Copyright (c) 2014年 isnailbook. All rights reserved.
//

#import "RecordDAO.h"

@implementation RecordDAO

static RecordDAO *sharedManager = nil;

+ (RecordDAO *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
        [sharedManager createdEditableCopyOfDatabaseIfNeeded];
    });
    return sharedManager;
}

- (void)createdEditableCopyOfDatabaseIfNeeded
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableDBPath = [self applicationDocumentsDirectoryFile];
    
    BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
    if (!dbexits)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"RecordsList.plist"];
        
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        
        if (!success)
        {
            //NSAssert1(0, @"错误写入文件：'%@'。", [error localizedDescription]);
        }
    }
}

- (NSString *)applicationDocumentsDirectoryFile
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingString:@"RecordsList.plist"];
    
    return path;
}

- (int)create:(Record *)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    if (array == nil)
    {
        array = [[NSMutableArray alloc] init];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[[dateFormat stringFromDate:model.date], model.shots]
                                                     forKeys:@[@"date", @"shots"]];
    
    [array insertObject:dict atIndex:0];
    [array writeToFile:path atomically:YES];
    
    return 0;
}

- (int)remove:(Record *)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        //Note* note = [[Note alloc] init];
        NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        //note.content = [dict objectForKey:@"content"];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]){
            [array removeObject: dict];
            [array writeToFile:path atomically:YES];
            break;
        }
    }
    
    return 0;
}

-(int) modify:(Record *)model
{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        NSString* content = [dict objectForKey:@"shots"];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:model.date]){
            [dict setValue:content forKey:@"shots"];
            [array writeToFile:path atomically:YES];
            break;
        }
    }
    return 0;
}

-(NSMutableArray*) findAll
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    //[self.listData removeAllObjects];
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        Record* record = [[Record alloc] init];
        record.date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        record.shots = [dict objectForKey:@"shots"];
        
        [listData addObject:record];
        
    }
    return listData;
}

-(Record *) findById:(Record *)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary* dict in array) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        Record* record = [[Record alloc] init];
        record.date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
        record.shots = [dict objectForKey:@"shots"];
        
        //比较日期主键是否相等
        if ([record.date isEqualToDate:model.date]){
            return record;
        }
    }
    return nil;
}

@end
