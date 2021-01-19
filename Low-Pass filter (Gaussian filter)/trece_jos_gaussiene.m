%exemplu de apel: trece_jos_gaussiene('AndreeaFundal.jpg', 20);
%exemplu de apel: trece_jos_gaussiene('AndreeaFundal.jpg', 50);

function [Output] = trece_jos_gaussiene(imgname, windowSize)

  P = imread(imgname);
  P = rgb2gray(P);
  [xImg, yImg, zImg] = size(P);
  
  if(zImg>1)
    I = rgb2gray(P);
  end
  
  I = double(P);

  % deviatia standard care e constanta
  sigma = 1.76;

  % facem un mesh de marimea ferestrei
  [x,y]=meshgrid(-windowSize:windowSize,-windowSize:windowSize);

  M = size(x,1)-1;
  N = size(y,1)-1;
  
  % pentru fiecare element din fereastra se vor aplica urmatoarele
  % calculam exponentul
  Exp_comp = -(x.^2+y.^2)/(2*sigma*sigma);
  % calculul final
  Kernel= exp(Exp_comp)/(2*pi*sigma*sigma);

  Output=zeros(size(I));
  % Punem imaginea intr-un chenar
  I = padarray(I,[windowSize windowSize]);

  for i = 1:size(I,1)-M
      for j =1:size(I,2)-N
          % pentru fereastra din pixelul curent I(i:i+M,j:j+M)
          % inmultim cu Kernelul calculat mai sus
          % i.e. (1 1, 0 0).*(2 2,2 2) = (1*2 1*2, 0*2 0*2)
          Temp = I(i:i+M,j:j+M).*Kernel;
          % valoarea pixelului final va fi valoarea sumei tuturor valorilor
          % din Temp
          Output(i,j)=sum(Temp(:));
      end
  end

  % imaginea fara zgomot
  Output = uint8(Output);
  
  figure
  subplot(1,2,1), imshow(uint8(P));
  title('Imagine initiala');
  
  subplot(1,2,2), imshow(uint8(Output));
  title('Imagine rezultat');
  
  imwrite(uint8(Output), 'rezultat.bmp');
end