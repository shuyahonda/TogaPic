//
//  ViewController.m
//  TogaPic
//
//  Created by Shuya Honda on 2015/04/05.
//  Copyright (c) 2015年 Shuya Honda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
}

- (IBAction)pushHeartButton:(id)sender {
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


@end
