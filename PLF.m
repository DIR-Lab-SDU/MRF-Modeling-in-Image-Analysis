function out=PLF(beta)
load('data1.mat');
[r,c]=size(img);
Pus=zeros(r,c);

Hz=zeros(r,c);
for i=2:r-1
    for j=2:c-1
        Pu=zeros(1,4);
        neighbor=[img(i-1,j-1) img(i-1,j) img(i-1,j+1);
                  img(i,j-1)   img(i,j)   img(i,j+1);
                  img(i+1,j-1) img(i+1,j) img(i+1,j+1)];
        clique=updateclique(neighbor);
        Pur=histogramp(clique);
        Pu(1)=Pur(1);
        Pu(2)=Pur(2);
        Pu(3)=Pur(3);
        Pu(4)=Pur(4);
       
        Pus(i,j)=Pu(1)*beta(1)+Pu(2)*beta(2)+Pu(3)*beta(3)+Pu(4)*beta(4);
        
       
        Pz=zeros(1,4);
        Hzp=zeros(1,4);
        for m=0:3
            neighborz=[img(i-1,j-1) img(i-1,j) img(i-1,j+1);
                       img(i,j-1)   m          img(i,j+1);
                       img(i+1,j-1) img(i+1,j) img(i+1,j+1)];
            clique1=updateclique(neighborz);
            Pzr=histogramp(clique1);
            Pz(1)=Pzr(1);
            Pz(2)=Pzr(2);
            Pz(3)=Pzr(3);
            Pz(4)=Pzr(4);
            Hzp(m+1)=exp(Pz(1)*beta(1)+Pz(2)*beta(2)+Pz(3)*beta(3)+Pz(4)*beta(4));
            
            
        end
        Hz(i,j)=log(sum(Hzp));
        
       
        
    end
end
out=sum(sum(Hz))-sum(sum(Pus));
end
