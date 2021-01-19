%exemplu de apel: SVD('AndreeaFundal.jpeg', 5);
%exemplu de apel: SVD('AndreeaFundal.jpeg', 20);

function SVD(imageName, procentValoriSingulareUtilizate)
  I = imread(imageName);
  I = rgb2gray(I);
  I = im2double(I);

  [U,S,V]=svd(I,'econ');
  
  [m,n] = size(S);
  valoriSingulareUtilizate = (procentValoriSingulareUtilizate / 100) * min(m,n);
  valoriSingulareUtilizate = max(valoriSingulareUtilizate, 1);
  
  S2 = S;
  S2(valoriSingulareUtilizate:end,:) = 0;
  S2(:,valoriSingulareUtilizate:end) = 0;
  
  subplot(1,2,1); 
  imshow(U*S*V');   
  title('Imaginea initiala');
  
  subplot(1,2,2); 
  imshow(U*S2*V');
  title(['Descompunere SVD cu ' num2str(procentValoriSingulareUtilizate) '% valori singulare utilizate.']);
  
end





