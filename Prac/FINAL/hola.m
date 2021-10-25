


p = double(dataset('File', 'entrada3.txt'));
t = double(dataset('File' , 'targets3.txt'));
[filas_entrada,columnas_entrada]=size(p);
[filas_target,columnas_target]=size(t);

V1=input('Ingrese el V1\n');
V2=input('Ingrese el V2\n');
[x,y] = size(V1);
[x2,y2] = size(V2);

alfa=input('Factor de aprendizaje:\n');
epochmax=input('Número maximo de epocas:\n');
error_epoch_train=input('Senal de error: \n');
epoch_val=input('Cada cuantas iteraciones se llevara a cabo una epoca de validacion:\n');
num_val=input('Numero maximo de incrementos consecutivos del error de epoca de validacion:\n');
disp('Escoja la opcion que guste para la division del dataset:\n');
disp('1. 80%-10%-10%');
disp('2. 70%-15%-15%\n');
opcion=input(' ');
[C_E,C_V,C_P,T_E,T_V,T_P]=separar_datos(p,t,opcion,filas_entrada);
[x_C_E,y_C_E]=size(C_E);
[x_C_V,y_C_V]=size(C_V);
[x_C_P,y_C_P]=size(C_P);

W=cell(1,y-1);
b=cell(1,y-1);
a=cell(1,y-1);

for i=1:y-1
	W{i}=2*rand(V1(i+1),V1(i))-1;
	b{i}=2*rand(V1(i+1),1)-1;
end

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
        sumaerror=sum(e); %Condicion de finalizacion%       
        Error_validacion(Epoca)=sumaerror/x_C_V;
        if error_epoch_train > Error_validacion(Epoca)
            break
        end
        if Epoca>2  %Early Stopping%
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
            S{j}=Funcion2(V2(j),W{j+1},S{j+1},a{j},t(C_E(dato)));
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
            if error_epoch_train > Error(Epoca)
                break
            end
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
if Error_Prueba < (10^-3)
    fprintf("Bien");
end






