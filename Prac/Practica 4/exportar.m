data = rand(10, 2);


fid = fopen('parametros_finales.txt','w');

fprintf(fid, '( %f %f )\n', data.');

fclose(fid);