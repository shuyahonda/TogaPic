//
//  ViewController.m
//  TogaPic
//
//  Created by Shuya Honda on 2015/04/05.
//  Copyright (c) 2015年 Shuya Honda. All rights reserved.
//

#import "ViewController.h"



typedef enum pictureType {
    Heart,
    Star
}pictureType;

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property pictureType selectedPictureType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushDeviceConnect:(id)sender {
}



#pragma mark - IBAction

- (IBAction)pushRedButton:(id)sender {
}

- (IBAction)pushBlueButton:(id)sender {
}

- (IBAction)pushBlackButton:(id)sender {
}

- (IBAction)pushStarButton:(id)sender {
    self.selectedPictureType = Star;
}

- (IBAction)pushHeartButton:(id)sender {
    self.selectedPictureType = Heart;
}

- (IBAction)pushImageSelect:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - ImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    [self.imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    }

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.imageView];
    NSLog(@"Touch ImageViewLocationx :%f y:%f", location.x, location.y);
    
    
    if (self.selectedPictureType == Heart) {
        UIImage *image = [UIImage imageNamed:@"heart"];
        CGRect rect = CGRectMake(location.x, location.y, 30, 30);
        UIImageView *heartImage = [[UIImageView alloc] initWithImage:image];
        heartImage.frame = rect;
        [self.imageView addSubview:heartImage];
    } else if (self.selectedPictureType == Star) {
        UIImage *image = [UIImage imageNamed:@"star"];
        CGRect rect = CGRectMake(location.x, location.y, 30, 30);
        UIImageView *heartImage = [[UIImageView alloc] initWithImage:image];
        heartImage.frame = rect;
        [self.imageView addSubview:heartImage];
    } else {
        NSLog(@"絵のタイプが選択されていません");
    }
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


@end
