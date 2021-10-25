p = double(dataset('File', 'entrada3.txt'));
t = double(dataset('File' , 'targets3.txt'));
[filas_entrada,columnas_entrada]=size(p);
[filas_target,columnas_target]=size(t);

disp('Escoja la opcion que guste para la division del dataset: ');
disp('1. 80%-10%-10%');
disp('2. 70%-15%-15%');
opcion=input(' ');
[C_E,C_V,C_P,T_E,T_V,T_P]=separar_datos(p,t,opcion,filas_entrada);



[x_C_E,y_C_E]=size(C_E);
[x_C_V,y_C_V]=size(C_V);
[x_C_P,y_C_P]=size(C_P);


for dato=1:x_C_E
    C_E(dato)
end


c=10^-3