//
//  main.m
//  launchapp
//
//  Created by Guilherme Rambo on 26/12/17.
//  Copyright © 2017 Guilherme Rambo. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <dlfcn.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            printf("Usage:\n%s com.app.bundle.identifier\n", argv[0]);
            return -1;
        }
        
        // I'm using dlopen to avoid having to link directly to SpringBoardServices
        void *spbsHandle = dlopen("/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices", RTLD_GLOBAL);
        
        if (!spbsHandle) {
            printf("ERROR: Failed to get SpringBoardServices handle:\n%s\n", dlerror());
            return 1;
        }
        
        CFStringRef identifier = CFStringCreateWithCString(kCFAllocatorDefault, argv[1], kCFStringEncodingUTF8);
        if (!identifier) {
            printf("ERROR: Unable to parse bundle identifier\n");
            return 2;
        }
        
        int(*SBSLaunchApplicationWithIdentifier)(CFStringRef identifier, bool flag) = dlsym(spbsHandle, "SBSLaunchApplicationWithIdentifier");
        
        int result = SBSLaunchApplicationWithIdentifier(identifier, FALSE);
        
        dlclose(spbsHandle);
        
        if (result != 0) {
            printf("Launch failed. Error code %d\n", result);
            return result;
        }
    }
    return 0;
}
