## Pytorch-iOS

A simple image classification app based on ResNet18. Currently the code is only available on iOS devices. 

### libtorch.a

All `.a` files in this repo are static libraries that were generated using cmake based on code from the master branch of Pytorch. They're not ready for production use as Pytorch is still under development by Facebook, stay tuned.

### Demo

To run the demo on device,  an Apple developer account is required, other than that, just clone the code and everything should be compiled in XCode, feel free to open issues.

### Trouble Shooting

- Check to see the `header/lib search path` has been set properly accroding to your local environment
- For the testing purpose, we can simply add `-load_all` as a linker flag to load all the symbols in `.a`

![](./screenshot.png)
