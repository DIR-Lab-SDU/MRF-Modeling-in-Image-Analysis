clc
clear all
close all
%% init
L = [0,1];                % label field
M = length(L);            % label number
img = rand(100,100);      % init image
filter = zeros(3,3);      % 3x3 window
alpha = 0                 % 1st-order potential factor
beta = 0.8*[1 1 -1 -1]    % interaction parameter
clique = cell(1,8);       % c8 c1 c5  b4 b1 b3
                          % c3 [] c4  b2 [] b2
                          % c6 c2 c7  b3 b1 b4
%% funcs
figure(1)
imshow(img)

% calculated parameters
betaC = reshape([beta',beta']',1,8);

% iteration
[r,c] = size(img);
distribution = 0;
for k = 1:10
    for i = 1:r
        for j = 1:c
            if (i==1)&&(j==1)
                filter(1,1) = NaN;
                filter(1,2) = NaN;
                filter(1,3) = NaN;
                filter(2,1) = NaN;
                filter(2,2) = img(i,j);
                filter(2,3) = img(i,j+1);
                filter(3,1) = NaN;
                filter(3,2) = img(i+1,j);
                filter(3,3) = img(i+1,j+1);
            end
            if (i==1)&&(j~=1)&&(j~=c)
                filter(1,1) = NaN;
                filter(1,2) = NaN;
                filter(1,3) = NaN;
                filter(2,1) = img(i,j-1);
                filter(2,2) = img(i,j);
                filter(2,3) = img(i,j+1);
                filter(3,1) = img(i+1,j-1);
                filter(3,2) = img(i+1,j);
                filter(3,3) = img(i+1,j+1);
            end
            if (i==1)&&(j==c)
                filter(1,1) = NaN;
                filter(1,2) = NaN;
                filter(1,3) = NaN;
                filter(2,1) = img(i,j-1);
                filter(2,2) = img(i,j);
                filter(2,3) = NaN;
                filter(3,1) = img(i+1,j-1);
                filter(3,2) = img(i+1,j);
                filter(3,3) = NaN;
            end
            
            if (i~=1)&&(i~=r)&&(j==1)
                filter(1,1) = NaN;
                filter(1,2) = img(i-1,j);
                filter(1,3) = img(i-1,j+1);
                filter(2,1) = NaN;
                filter(2,2) = img(i,j);
                filter(2,3) = img(i,j+1);
                filter(3,1) = NaN;
                filter(3,2) = img(i+1,j);
                filter(3,3) = img(i+1,j+1);
            end
            if (i==r)&&(j~=1)&&(j~=c)
                filter(1,1) = img(i-1,j-1);
                filter(1,2) = img(i-1,j);
                filter(1,3) = img(i-1,j+1);
                filter(2,1) = img(i,j-1);
                filter(2,2) = img(i,j);
                filter(2,3) = img(i,j+1);
                filter(3,1) = NaN;
                filter(3,2) = NaN;
                filter(3,3) = NaN;
            end
            
            if (i==r)&&(j==1)
                filter(1,1) = NaN;
                filter(1,2) = img(i-1,j);
                filter(1,3) = img(i-1,j+1);
                filter(2,1) = NaN;
                filter(2,2) = img(i,j);
                filter(2,3) = img(i,j+1);
                filter(3,1) = NaN;
                filter(3,2) = NaN;
                filter(3,3) = NaN;
            end
            
            if (i==r)&&(j==c)
                filter(1,1) = img(i-1,j-1);
                filter(1,2) = img(i-1,j);
                filter(1,3) = NaN;
                filter(2,1) = img(i,j-1);
                filter(2,2) = img(i,j);
                filter(2,3) = NaN;
                filter(3,1) = NaN;
                filter(3,2) = NaN;
                filter(3,3) = NaN;
            end
            
            if (i~=1)&&(i~=r)&&(j==c)
                filter(1,1) = img(i-1,j-1);
                filter(1,2) = img(i-1,j);
                filter(1,3) = NaN;
                filter(2,1) = img(i,j-1);
                filter(2,2) = img(i,j);
                filter(2,3) = NaN;
                filter(3,1) = img(i+1,j-1);
                filter(3,2) = img(i+1,j);
                filter(3,3) = NaN;
            end
            if (i>1)&&(i<r)&&(j>1)&&(j<r)
                filter(1,1) = img(i-1,j-1);
                filter(1,2) = img(i-1,j);
                filter(1,3) = img(i-1,j+1);
                filter(2,1) = img(i,j-1);
                filter(2,2) = img(i,j);
                filter(2,3) = img(i,j+1);
                filter(3,1) = img(i+1,j-1);
                filter(3,2) = img(i+1,j);
                filter(3,3) = img(i+1,j+1);
            end
            clique = updateclique(filter);
            Pf = getPf(clique, M, betaC, alpha, L);
            img(i,j) = L(find(mnrnd(1,Pf)==1));
        end
    end
    k
    figure(2)
    imshow(img)
end
