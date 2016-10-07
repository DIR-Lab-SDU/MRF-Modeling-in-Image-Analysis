function out = getPf(clique, M, betaC, alpha, L)
%% V2(fi,fi') & Uf
Uf = zeros(1,M);
for j = 1:M
    V2 = zeros(1,8);
    for i = 1:8
        if isnan(clique{i}(2))
            
        else
            if L(j) == clique{i}(2)
                V2(i) = betaC(i);
            else
                V2(i) = -betaC(i);
            end
        end
    end
    Uf(j) = alpha*L(j) + sum(V2);
end

%% conditional probability
% Uf
Pf = exp(Uf)/sum(exp(Uf));
%sum(Pf)
out = Pf;

end