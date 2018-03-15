close all;
clear all;

f1=@(block_struct) dct2(block_struct.data);
f2=@(block_struct) idct2(block_struct.data);
a=imread('face.jpg');
a=rgb2gray(a);
imwrite(a,'new.tif');
figure, subplot(1,2,1);imshow(a); title('Original Image (OI)');
J=blockproc(a, [8 8],f1);
depth=find(abs(J)<50);
J(depth)=zeros(size(depth));
K= blockproc(J,[8 8],f2)/255;
subplot(1,2,2); imshow(K); title('After DCT on OI (K)');
%K;
imwrite(K,'new1.tif');
%CR= numel(J)/numel(depth); %compression ratio
%pause

img=imread('new1.tif');
imgd=im2double(img);
fff=ones(3,3)/9;
img1=filter2(fff,imgd);
imwrite(img1,'new2.tif');
figure,
subplot(131);
imshow(a); title('Original Image');
subplot(132);
imshow(img);title('DCT Image (K)');
subplot(133);
imshow(img1);title('LPF on K');

Eorig=entropy(a)
Edct=entropy(img)
Elpf=entropy(img1) %entropy after Lpf

Sorig = imfinfo('new.tif');
sori = Sorig.FileSize()
Scomp= imfinfo('new1.tif');
scom = Scomp.FileSize()
Slpf= imfinfo('new2.tif');
slp = Slpf.FileSize()

crdct=sori/scom
crlpf=sori/slp


x=imread('new1.tif'); % new1.tif=FOR DCT, new2.tif = DCT+LPF , CHANGE PARAMATERS!!!
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


