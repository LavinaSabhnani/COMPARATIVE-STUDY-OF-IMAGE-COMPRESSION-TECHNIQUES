#Comparative Study of Image Compression Techniques.
In Computer Science and Information Technology, Image Compression is an application of data compression that encodes an image within fewer bits than the original image.
The main goal of such system is to reduce the storage quantity optimally, and the decoded image displayed on the monitor must be as similar to the original image as possible.
Here, brief comparision of the different fundamental - primitive theories of image compression on the basis of certain parameters is done.

There are five types of methods which are compared namely:
1. Discrete Cosine Transform (DCT).
2. Discrete Cosine Transform with Low Pass Filtering (DCT+LPF).
3. Discrete Wavelet Transform (DWT).
4. Discrete Wavelet Transform with Low Pass Filtering on LL region (DWT+LPF).
5. Single Value Decomposition (SVD).

These above methods are compared on the basis of the folllowing standard parameters:
1. Mean Squared Error (MSE)
2. Root Mean Squared Error (RMSE)
3. Compression Ratio (CR)
4. Signal-to-Noise Ratio (SNR)
5. Peak Signal-to-Noise Ratio (PSNR)
6. Entropy

In image compression technique we expect the high compression ratio (CR) and also better quality of the reconstructed image. From the results obtained, as CR increases, value of PSNR decreases and RMSE increases. In DCT at high compression ratio quality of image degrades due to blocking artifacts. Hence at high compression ratio DWT technique is used which gives the better quality of the reconstructed image as compared to DCT. Also in DCT reconstructed image have the blurred but smoothened edges.
