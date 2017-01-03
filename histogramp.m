function out=histogramp(clique)
H=zeros(1,8);
for i=1:8
    if clique{i}(1)==clique{i}(2)
       H(i)= 1;
    else
        H(i)=(-1);
    end
Ht1=H(1)+H(2);
Ht2=H(3)+H(4);
Ht3=H(5)+H(6);
Ht4=H(7)+H(8);
Hist=[Ht1,Ht2,Ht3,Ht4];
out=Hist;                 %%对第一个参数进行估计
end