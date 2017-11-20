//
//  BlurView.m
//  NavScaleView
//
//  Created by Jason on 08/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "BlurView.h"
#import <Accelerate/Accelerate.h>
@interface BlurView()

@property (nonatomic, strong) UIImageView *backImageView; // 毛玻璃层

@end

@implementation BlurView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.initialBlurLevel = 0.8;
        
        self.backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        self.backImageView.contentMode = UIViewContentModeScaleToFill;
        
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
        
        self.backImageView.backgroundColor = [UIColor clearColor];
        
        self.backImageView.alpha = 0;
        
        [self addSubview:self.backImageView];
        
    }
    
    return self;
    
}



- (void)setInitialBlurLevel:(CGFloat)initialBlurLevel{
    
    _initialBlurLevel = initialBlurLevel;
    
}

- (void)setOriginalImage:(UIImage *)originalImage{
    
    _originalImage = originalImage;
    
    self.image = originalImage;
    
    dispatch_queue_t queue = dispatch_queue_create("blur_queue", NULL);
    
    dispatch_async(queue, ^{
        
        UIImage *blurImage = [self applyBlurOnImage:originalImage withRadius:self.initialBlurLevel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.backImageView.image = blurImage;
            
            self.backImageView.alpha = 0;
            
        });
        
    });
    
}



- (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur

                   withRadius:(CGFloat)blurRadius {
    
    if ((blurRadius <= 0.0f) || (blurRadius > 1.0f)) {
        
        blurRadius = 0.5f;
        
    }
    
    int boxSize = (int)(blurRadius * 100);
    
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef rawImage = imageToBlur.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
    
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(rawImage);
    
    inBuffer.height = CGImageGetHeight(rawImage);
    
    inBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));
    
    outBuffer.data = pixelBuffer;
    
    outBuffer.width = CGImageGetWidth(rawImage);
    
    outBuffer.height = CGImageGetHeight(rawImage);
    
    outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       
                                       0, 0, boxSize, boxSize, NULL,
                                       
                                       kvImageEdgeExtend);
    
    if (error) {
        
        NSLog(@"error from convolution %ld", error);
        
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             
                                             outBuffer.width,
                                             
                                             outBuffer.height,
                                             
                                             8,
                                             
                                             outBuffer.rowBytes,
                                             
                                             colorSpace,
                                             
                                             CGImageGetBitmapInfo(imageToBlur.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    
    CGContextRelease(ctx);
    
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
    
}



- (void)setScrollView:(UIScrollView *)scrollView{
    
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    
    _scrollView = scrollView;
    
    // kvo添加监听
    
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context{
    
    CGFloat blur = -self.scrollView.contentOffset.y/self.bounds.size.height;
    
    NSLog(@"blur ==== %.2f",blur);
    
    self.backImageView.alpha = blur*4;
    
}



@end
