function [a] = Funcion(v2,W,a,b)

if v2==1
    a=purelin(W*a+b);
end
if v2==2
    a=logsig(W*a+b);
end
if v2==3
    a=tansig(W*a+b);
end
end

