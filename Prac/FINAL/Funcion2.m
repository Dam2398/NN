function [S] = Funcion2(v2,W,s,a,t)

[x,y] = size(W);
F = zeros(y);

if v2==1
    for i=1:y
        for j=1:y
            if i==j
                F(i,j) = -2*(t-a(i));
            end
        end
    end
    S=F;
end

if v2==3
    for i=1:y
        for j=1:y
            if i==j
                F(i,j) = 1-a(i)^2;
            end
        end
    end
    S=F*W'*s;
end

if v2==2
    for i=1:y
        for j=1:y
            if i==j
                F(i,j) = a(j)*(1-a(j));
            end
            
        end
    end
    S=F*W'*s;
end

end

