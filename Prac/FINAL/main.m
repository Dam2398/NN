clear,clc;
p = importdata('02_Polinomio_Entrada.txt');
t = importdata('02_Polinomio_Target.txt');

[filas_entrada,columnas_entrada]=size(p);
[filas_target,columnas_target]=size(t);

data = horzcat(p,t);
plot(data(:,2));

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
disp('2. 70%-15%-15%');
opcion=input(' ');
[C_E,C_V,C_P,T_E,T_V,T_P]=separar_datos(p,t,opcion,filas_entrada);
[x_C_E,y_C_E]=size(C_E);
[x_C_V,y_C_V]=size(C_V);
[x_C_P,y_C_P]=size(C_P);

red=cell(1,y-1);
bias=cell(1,y-1);
a=cell(1,y-1);

for i=1:y-1
	red{i}=2*rand(V1(i+1),V1(i))-1;
	bias{i}=2*rand(V1(i+1),1)-1;
end

h=1;

for Epoca=1:epochmax


    if mod(Epoca,epoch_val) == 0 %Epoca de validacion%
        
        sumaerrorValidacion=0;
        contador=0;
        e(:)=0;
        for dato=1:x_C_V
            a{1}=Funcion(V2(1),red{1},C_V(dato),bias{1});
            for i=2:y-1
                a{i}=Funcion(V2(i),red{i},a{i-1},bias{i});
            end
            e(dato)=T_V(dato)-a{y2};
            sumaerrorValidacion=sumaerrorValidacion+abs(e(dato));
        end    
         %Condicion de finalizacion%       
        Error_validacion(h)=sumaerrorValidacion/x_C_V;
        if error_epoch_train > Error_validacion(h)
            printf('Error listo');
            break
        end
        if h>2  %Early Stopping%
            if Error_validacion(h-1) < Error_validacion(h)
                contador=contador+1;
            else 
                contador=0;
            end
        end
        if contador==num_val
            printf('Supero num_val');
            break
        end
        h=h+1;
        
    else %Epoca de entrenamiento%
        sumaerror_Entrenamiento=0;
        e(:)=0;
        for dato=1:x_C_E
        
        a{1}=Funcion(V2(1),red{1},C_E(dato),bias{1});
        for i=2:y2
            a{i}=Funcion(V2(i),red{i},a{i-1},bias{i});
        end
        e(dato)=T_E(dato)-a{y2};
sumaerror_Entrenamiento=sumaerror_Entrenamiento+abs(e(dato));


        S{y2}=Funcion2(V2(y2),0,0,a{y2},T_E(dato));
        j=y2-1;
        while j>0
            S{j}=Funcion2(V2(j),red{j+1},S{j+1},a{j},T_E(dato));
            j=j-1;
        end

        red{1} = red{1}-alfa*S{1}*C_E(dato);
        bias{1} = bias{1}-alfa*S{1};
            for j=2:y2
                red{j} = red{j}-alfa*S{j}*a{j-1}';
                bias{j} = bias{j}-alfa*S{j};      
            end

        end
            
            
            Error_Entrenamiento(Epoca) = (sumaerror_Entrenamiento/x_C_E);
            
            if Error_Entrenamiento(Epoca) <= error_epoch_train
                fprintf('Salida exitosa con el error %d\n',Error_Entrenamiento);
                break
            end
    end
end

%Prueba%
e(:)=0;
sumaerror=0;
for dato=1:x_C_P
    
    a{1}=Funcion(V2(1),red{1},C_P(dato),bias{1});
            for i=2:y-1
                a{i}=Funcion(V2(i),red{i},a{i-1},bias{i});
            end
            resultados(dato)=a{y2};
            e(dato)=T_P(dato)-a{y2};
            sumaerror=sumaerror+abs(e(dato));
end

Error_Prueba=(sumaerror/x_C_P);
if Error_Prueba < (10^-3)
    fprintf("Bien");
end

%%

    plot(p,t,'g:', C_P,T_P,'o b', C_P,resultados,'+ r');
    legend('Señal Real', 'Targets', 'Valores obtenidos');   
    title('Resultados')






