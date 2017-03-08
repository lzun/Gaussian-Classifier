mat_torn = zeros(19,7);
mat_rond = zeros(19,7);

%Leemos las imagenes una por una y se calculan sus momentos inv. de Hu
%en una matriz, cada fila representa una imagen.
for i=1:19
    newfilename = sprintf('IMAG0%d.BMP',i+100);
    newfilename2 = sprintf('IMAG0%d.BMP',i+200);
    I = imread(newfilename);
    I2 = imread(newfilename2);
    %se binarizan
    bw = imbinarize(I);
    bw2 = imbinarize(I2);
    %se calculan sus momentos invariantes de Hu
    mat_torn(i,:) = invmoments(bw);
    mat_rond(i,:) = invmoments(bw2);
end

A = mat_torn(1:7,1:2);
B = mat_rond(1:7,1:2);
%scatter(A(:,1), A(:,2)), hold on;
%scatter(B(:,1), B(:,2),'d')

%%Empieza el clasificador bayesiano
%Se calculan el vector de medias y la matriz de covarianza

mu_a = mean(A);
mu_b = mean(B);

C = cov(A);
W = C^-1*(mu_a - mu_b)';
b = 0.5*(mu_b*C^-1*mu_b' - mu_a*C^-1*mu_a');

%test con una imagen
Im = imread('IMAG0220.BMP');
inv = invmoments(imbinarize(Im))
x = inv(1:2)

W'*x' + b

%if (w*x + b > 0)
%    y = 1
%else
%    y = 2
%end

