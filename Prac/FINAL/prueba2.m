

[x_C_E,y_C_E]=size(C_E);
[x_C_V,y_C_V]=size(C_V);
[x_C_P,y_C_P]=size(C_P);

for Epoca=1:epochmax
sumaerror=0;

    if mod(Epoca,epoch_val) == 0 %Epoca de validacion%
        contador=0;
        e(:)=0;
        for dato=1:x_C_V
            a{1}=Funcion(V2(1),W{1},p(C_V(dato)),b{1});
            for i=2:y-1
                a{i}=Funcion(V2(i),W{i},a{i-1},b{i});
            end
            e(dato)=t(C_V(dato))-a{y2};
        end    
        sumaerror=sum(e);         %Early Stopping%
        Error_validacion(Epoca)=sumaerror/x_C_V;
        if Epoca>2
        if Error_validacion(Epoca-1)<Error_validacion(Epoca)
            contador=contador+1;
        else 
            contador=0;
        end
        end
        if contador==num_val
            break;
        end
        
    else %Epoca de entrenamiento%
        e(:)=0;
        for dato=1:x_C_E
        
        a{1}=Funcion(V2(1),W{1},p(C_E(dato)),b{1});
        for i=2:y-1
            a{i}=Funcion(V2(i),W{i},a{i-1},b{i});
        end
        e(dato)=t(C_E(dato))-a{y2};

        S{y2}=Funcion2(V2(y2),0,0,a{y2},t(C_E(dato)));
        j=y2-1;
        while j>0
            S{j}=Funcion2(V2(y2),W{j+1},S{j+1},a{j},t(C_E(dato)));
            j=j-1;
        end

        W{1} = W{1}-alfa*S{1}*p(C_E(dato))';
        b{1} = b{1}-alfa*S{1};
            for j=2:y2
                W{j} = W{j}-alfa*S{j}*a{j-1}';
                b{j} = b{j}-alfa*S{j};      
            end

        end
            sumaerror=sum(e);
            Error(Epoca)=sumaerror/x_C_E;
    end
end

%Prueba%
e(:)=0;
sumaerror=0;
for dato=1:x_C_P
    
    a{1}=Funcion(V2(1),W{1},p(C_P(dato)),b{1});
            for i=2:y-1
                a{i}=Funcion(V2(i),W{i},a{i-1},b{i});
            end
            e(dato)=t(C_P(dato))-a{y2};
end
sumaerror=sum(e);
Error_Prueba=sumaerror/x_C_P;







