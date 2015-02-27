//
//  Logging.h
//  PromiQuiz
//
//  Created by Nikolas Burk on 20/11/14.
//  Copyright (c) 2014 Nikolas Burk. All rights reserved.
//

#ifndef PromiQuiz_Logging_h
#define PromiQuiz_Logging_h

// The DLog macro is used to only output when the DEBUG variable is set (-DDEBUG in the projects's C flags for the debug confirguration: edit scheme).
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//#import <NSLogger/NSLogger.h>


#endif
