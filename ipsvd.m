
close all;
clear all;
J = imread('face.jpg');
J=rgb2gray(J);
imwrite(J,'a.bmp');
I = double(imread('a.bmp'));
figure;subplot(1,2,1);imshow(J);title('Input Image');
% perform SVD on Lena
[U,S,V] = svd(I);

% extract singular values
singvals = diag(S);

% find out where to truncate the U, S, V matrices
indices = find(singvals >= 0.01 * singvals(1));

% reduce SVD matrices
U_red = U(:,indices);
S_red = S(indices,indices);
V_red = V(:,indices);

% construct low-rank approximation of Lena
I_red = U_red * S_red * V_red';

% print results to command window
r = num2str(length(indices));
m = num2str(length(singvals));
disp(['Low-rank approximation used ',r,' of ',m,' singular values']);

% save reduced Lena
imwrite(uint8(I_red),'a1.bmp');
k=imread('a1.bmp');
subplot(122);imshow(k);title('SVD Transformed Image');

Eorig = entropy(J)
Esvd = entropy(k)

Sorig = imfinfo('a.bmp');
sori = Sorig.FileSize()
Scomp= imfinfo('a1.bmp');
scom = Scomp.FileSize()

scr = sori/scom 

x=imread('a1.bmp'); 
%figure, subplot(1,3,1); imshow(x);title('Original First Image (OI)');
F=dct2(x);
%subplot(1,3,2);imshow(F*0.01);title('FunctDct2 on OI (I1)');
ff= idct2(F);
%subplot(1,3,3); imshow(ff/255);title('FunctIDct2 on I1 (I2)');
[r c]=size(x);
DF= zeros(r,c);
DFF=DF;
IDF=DF;
IDFF=DF;
depth=4;
N=8;
for i=1:N:r
    for j=1:N:c
        f=x(i:i+N-1,j:j+N-1);
        df=dct2(f);
        DF(i:i+N-1,j:j+N-1)=df;% DCT of Block 
        dff=idct2(df);
        DFF(i:i+N-1,j:j+N-1)=dff; % Inverse DCT of Block
        
        df(N:-1:depth+1,:)=0;
        df(:,N:-1:depth+1)=0;
        IDF(i:i+N-1,j:j+N-1)=df;
        dff=idct2(df);
        IDFF(i:i+N-1,j:j+N-1)=dff;
    end
end
%figure , subplot(1,4,1);imshow(DF/255); title('After performing DCT (I3)');
%subplot(1,4,2); imshow(DFF);title('After performing DCT (I4)');
A=DFF/255;
%subplot(1,4,3);imshow(A);title('After performing DCT (I5)');
B=DFF/255;
%subplot(1,4,4);imshow(B);title('After performing DCT (I6)');

squared_error=0;   % Initializing %
rms=0;         % Initializing %
temp=0;         % Required for SNR %
[row col]= size(x);
ms=0;
for i=1:1:row 
    for j=1:1:col
        ms= (DF(i,j)- DFF(i,j))^2;
        squared_error= ms + squared_error;
        temp1=DF(i,j)*DFF(i,j);
        temp=temp1+temp;
    end 
end


mse=squared_error/(row*col)
rme=sqrt(mse)
snr=squared_error/temp
psnr= 10*log((256*256)/mse)

