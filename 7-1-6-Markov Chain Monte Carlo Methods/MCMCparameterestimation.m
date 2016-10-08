% the MCMC parameter estimation method according to the paper-MRF parameter estimation by MCMC method Stan li

load('data1.mat');
% a texture image whose second clique is 1, 1, 1, -1;
% and the corrsepond clique type is ©¤    ©¦   ¨u   ¨v
%                                   ¦Â1  ¦Â2  ¦Â3  ¦Â4
[r,c]=size(img);
thetat=unifrnd(-5,5,[1,4]);% initialize the parameter
T=1;
for k=1:500
Hc=zeros(r,c);
Ht=zeros(r,c);
thetac=zeros(1,4);
theta1=reshape([thetat',thetat']',[1,8]);
thetac(1)=normrnd(thetat(1),0.5); % the candidate parameter ¦Â1
thetac(2)=normrnd(thetat(2),0.5); % the candidate parameter ¦Â2
thetac(3)=normrnd(thetat(3),0.5); % the candidate parameter ¦Â3
thetac(4)=normrnd(thetat(4),0.5); % the candidate parameter ¦Â4
thetac1=reshape([thetac',thetac']',[1,8]);
P=zeros(r,c);
for i=2:r-1
    for j=2:c-1

        
        neighbor=[img(i-1,j-1) img(i-1,j) img(i-1,j+1);
                  img(i,j-1)   img(i,j)   img(i,j+1);
                  img(i+1,j-1) img(i+1,j) img(i+1,j+1)];
        clique=updateclique(neighbor);
        Ht(i,j)=histogram(clique,theta1); % the current energy
        Hc(i,j)=histogram(clique,thetac1);% the candidate energy 
       
       
        
        Hzcr=zeros(1,4);
        Hztr=zeros(1,4);
        for m=0:3
           
            neighborz=[img(i-1,j-1) img(i-1,j) img(i-1,j+1);
                       img(i,j-1)   m          img(i,j+1);
                       img(i+1,j-1) img(i+1,j) img(i+1,j+1)];
            clique1=updateclique(neighborz);
            Hzcr(m+1)=histogram(clique1,thetac1);
            
            Hztr(m+1)=histogram(clique1,theta1);
            
        end
       sumc=exp(Hzcr(1))+exp(Hzcr(2))+exp(Hzcr(3))+exp(Hzcr(4)); 
       % the candidate paration function 
       sumt=exp(Hztr(1))+exp(Hztr(2))+exp(Hztr(3))+exp(Hztr(4));
       % the current paration function
       
        P(i,j)=Hc(i,j)-Ht(i,j)-log(sumc)+log(sumt);
        % page 7 (10)
        
    end
end
Po=exp(sum(sum(P)));
% the acceptance probablilty
if  Po > 1
    thetat = thetac;
elseif Po > (1-T)
    thetat = thetac;
       
end
T = T /log((100+k))*log(100);

end

