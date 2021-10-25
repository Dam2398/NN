function [Salida] = feed(V2,W,p,b,y)

 a=cell(1,y-1);
 a{1}=Funcion(V2(1),W{1},p,b{1});
    for i=2:y-1
        a{i}=Funcion(V2(i),W{i},a{i-1},b{i});
    end
    Salida = a;

end

